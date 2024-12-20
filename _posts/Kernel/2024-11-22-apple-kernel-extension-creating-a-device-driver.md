---
layout: post
title: Apple Kernel Extension - Creating a Device Driver
categories: [Kernel extensions]
tags: [Metal, GPU, IOKit, Apple, MacOS]
date: 2024-11-22 15:05 -0500
---

![Kernel architecture](/assets/Kernel/2024-11-22-apple-kernel-extension-creating-a-device-driver/userclient_architecture.gif){: .default width="200"}

## KEXT: Kernel Extensions Overview

OS X provides a kernel extension mechanism as a means of allowing dynamic loading of code into the kernel, without the need to recompile or relink. 
Because these kernel extensions (KEXTs) provide both modularity and dynamic loadability, they are a natural choice for any relatively self-contained service that requires access to internal kernel interfaces.

Kernel extensions are implemented as bundles, which contain the following: 

* __Information property list__: a text file that describes the contents, settings, and requirements of the KEXT. This file is required.
* __KEXT binary__: a file in Mach-O format, containing the actual binary code used by the KEXT.
* __Resources__: for example, icons or localization dictionaries. Resources are optional.
* __KEXT bundles__: a kext can contain other KEXTs.

Dependencies in KEXTs can be considered analogous to required header files or libraries in code development.{: .prompt-tip}

You need to log in to the root account (or use the su or sudo command), since only the root account can load kernel extensions.{: .prompt-warning}

When testing your KEXT, you can load and unload it manually, as well as check the load status. You can use the `kextload` command to load any KEXT. Note that this command is useful only when developing a KEXT. Eventually, after it has been tested and debugged, you install your KEXT in one of the standard places.{: .prompt-tip}

### The Information Property List

A kext’s `Info.plist` file describes the kext’s contents. Every kext must have an `Info.plist` file. Because a kext can be loaded during early boot when limited processing is available, this file must be in XML format and cannot include comments. The following keys are of particular importance in a kext’s Info.plist file:

* `CFBundleIdentifier` is used to locate a kext both on disk and in the kernel. Multiple kexts with a given identifier can exist on disk, but only one such kext can be loaded in the kernel at a time.
* `CFBundleExecutable` specifies the name of your kext’s executable, if it has one.
* `CFBundleVersion` indicates the kext’s version. Kext version numbers follow a strict pattern (see Info.plist Properties for Kernel Extensions).
* `OSBundleLibraries` lists the libraries (which are kexts themselves) that the kext links against.
* `IOKitPersonalities` is used by an I/O Kit driver for automatically loading the driver when it is needed.

There are several more kext-specific Info.plist keys that allow you to further describe your kext. For a complete discussion of all kext Info.plist keys, including keys that refer to kernel-specific runtime facilities, see [Info.plist Properties for Kernel Extensions](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/Articles/infoplist_keys.html#//apple_ref/doc/uid/TP40009481-SW1).

### The Executable

This is your kext’s compiled, executable code. Your executable is responsible for defining entry points that allow the kernel to load and unload the kext. These entry points differ depending on the Xcode template you use when creating your kext. Table 1 describes the default differences between the two kext Xcode templates. This table is intended to illustrate only the most common use of each template; the kernel does not differentiate between kexts created with different templates, and it is possible to incorporate elements of both templates into a kext.

| **Feature**              | **Generic Kernel Extension Template**                                                                                                                                                                              | **IOKit Driver Template**                                                                                                                                                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Programming Language** | Usually C                                                                                                                                                                                                          | C++                                                                                                                                                                                                       |
| **Implementation**       | C functions registered as callbacks with relevant subsystems                                                                                                                                                       | Subclasses of one or more I/O Kit driver classes, such as `IOGraphicsDevice`                                                                                                                              |
| **Entry Points**         | Start and stop functions with C linkage                                                                                                                                                                            | C++ static constructors and destructors                                                                                                                                                                   |
| **Loading Behavior**     | Must be loaded explicitly                                                                                                                                                                                          | Loaded automatically by the I/O Kit when needed                                                                                                                                                           |
| **Unloading Behavior**   | Must be unloaded explicitly                                                                                                                                                                                        | Unloaded automatically by the I/O Kit after a fixed interval when no longer needed                                                                                                                        |
| **Tutorial**             | [Creating a Generic Kernel Extension with Xcode](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptKEXT/kext_tutorial.html#//apple_ref/doc/uid/20002365-BABJHCJA) | [Creating a Device Driver with Xcode](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptIOKit/iokit_tutorial.html#//apple_ref/doc/uid/20002366-CIHECHHE) |

### Generic kernel extension vs I/O Kit device driver

macOS supports both - you can write a driver that makes something appear in `/dev` and it's C-like, or you can write something that appears in the IORegistry and it's a C++ library you use.

### Kernel Extensions Must be Developer ID for Kexts Signed and Reside in `/Library/Extensions`

With System Integrity Protection, kernel extensions must be signed with a Developer ID for Signing Kexts certificate, and installed into the /Library/Extensions directory.

### Building and linking

Because kexts are linked at load time, a kext must list its libraries in its information property list with the `OSBundleLibraries` property. The best way to find which libraries a KEXT links to is to run the `kmutil libraries --xml -p /path//to/kext.kext` and copy its output into your kext’s `Info.plist` file.

### Installing

KEXTs are usually installed in the folder `/System/Libraries/Extensions`. The Kernel Extension Manager (in the form of a daemon, `kextd`), always checks here. __KEXTs can also be installed in ROM or inside an application bundle__. Installing KEXTs in an application bundle allows an application to register those KEXTs without the need to install them permanently elsewhere within the system hierarchy. This may be more convenient and allows the KEXT to be associated with a specific, running application. When it starts, the application can register the KEXT and, if desired, unregister it on exit.

## Transferring Data Into and Out of the Kernel

__The Darwin kernel gives you several ways to let your kernel code communicate with application code.__

You may use memory mapping (particularly the BSD copyin and copyout routines) and block copying in conjunction with one of the aforementioned APIs to move large or variably sized chunks of data between the kernel and user space.

Thee are the I/O Kit transport mechanisms and APIs that enable driver code to communicate with application code. This section describes aspects of the kernel environment that give rise to these mechanisms and discusses the alternatives available to you.

Aspects of the kernel that affect how cross-boundary I/O takes place, or should take place:

* The kernel is a slave to the application. __Code in the kernel (such as in a driver) is passive in that it only reacts to requests from processes__ in user space. Drivers should not initiate any I/O activity on their own.
* Kernel resources are discouraged in user space. Application code cannot be trusted with kernel resources such as kernel memory buffers and kernel threads. __To eliminate the need for passing kernel resources to user space, the system provides several kernel–user space transport mechanisms for a range of programmatic circumstances.__
* User processes cannot take direct interrupts. As a corollary to the previous point, kernel interrupt threads cannot jump to user space. Instead, if your application must be made aware of interrupts, it should provide a thread on which to deliver a notification of them.
* __Each kernel–user space transition incurs a performance hit.__ The kernel's transport mechanisms consume resources and thus exact a performance penalty. __Each trip from the kernel to user space (or vice versa) involves the overhead__ of Mach RPC calls, the probable allocation of kernel resources, and perhaps other expensive operations. The goal is to use these mechanisms as efficiently as possible.
* The kernel should contain only code that must be there. Adding unnecessary code to the kernel—specifically code that would work just as well in a user process—bloats the kernel, potentially destabilizes it, unnecessarily wires down physical memory (making it unavailable to applications), and degrades overall system performance.

## References

* [Creating a Device Driver with Xcode](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptIOKit/iokit_tutorial.html#//apple_ref/doc/uid/20002366)
* [Kernel Extension Overview](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KernelProgramming/Extend/Extend.html)
* [Implementing drivers, system extensions, and kexts](https://developer.apple.com/documentation/kernel/implementing_drivers_system_extensions_and_kexts?language=occ)
* [The Anatomy of a Kernel Extension](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptAnatomy/kext_anatomy.html#//apple_ref/doc/uid/20002364-CIHJBCID)
* [Creating a Driver Using the DriverKit SDK
](https://developer.apple.com/documentation/driverkit/creating_a_driver_using_the_driverkit_sdk)


