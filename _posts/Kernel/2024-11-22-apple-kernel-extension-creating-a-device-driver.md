---
layout: post
title: Apple Kernel Extension - Creating a Device Driver
categories: [Kernel extensions]
tags: [Metal, GPU, IOKit, Apple, MacOS]
date: 2024-11-22 15:05 -0500
---

![Kernel architecture](/assets/Kernel/2024-11-22-apple-kernel-extension-creating-a-device-driver/userclient_architecture.gif){: .default width="200"}

## KEXT: Kernel Extensions Overview

OS X provides a kernel extension mechanism as a means of allowing dynamic loading of code into the kernel, without the need to recompile or relink. Because these kernel extensions (KEXTs) provide both modularity and dynamic loadability, they are a natural choice for any relatively self-contained service that requires access to internal kernel interfaces.

Kernel extensions are implemented as bundles, which contain the following: 

* __Information property list__: a text file that describes the contents, settings, and requirements of the KEXT. This file is required.
* __KEXT binary__: a file in Mach-O format, containing the actual binary code used by the KEXT.
* __Resources__: for example, icons or localization dictionaries. Resources are optional.
* __KEXT bundles__: a kext can contain other KEXTs.

 Dependencies in KEXTs can be considered analogous to required header files or libraries in code development.{: .prompt-tip}

You need to log in to the root account (or use the su or sudo command), since only the root account can load kernel extensions.{: .prompt-warning}

When testing your KEXT, you can load and unload it manually, as well as check the load status. You can use the `kextload` command to load any KEXT. Note that this command is useful only when developing a KEXT. Eventually, after it has been tested and debugged, you install your KEXT in one of the standard places.

### Debugging a KEXT

Before you can debug a KEXT, you must first enable kernel debugging, as OS X is not normally configured to permit debugging the kernel.

Kernel debugging is performed using two OS X computers, called the development or debug host and the debug target. Debugging must be performed in this fashion because you must temporarily halt the kernel on the target in order to use the debugger. When you halt the kernel, all other processes on that computer stop. However, a debugger running remotely can continue to run and can continue to examine (or modify) the kernel on the target.

Developers generally debug KEXTs using gdb, a source-level debugger with a command-line interface. [Tutorial on Debugging a Kernel Extension with GDB](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptDebugger/debug_tutorial.html#//apple_ref/doc/uid/20002367)

The Kernel Extension Manager (KEXT Manager) is responsible for loading and unloading all installed KEXTs (commands such as kextload are used only during development). Installed KEXTs are dynamically added to the running OS X kernel as part of the kernel’s address space. An installed and enabled KEXT is invoked as needed.

## Building and linking

Because kexts are linked at load time, a kext must list its libraries in its information property list with the OSBundleLibraries property. At this stage of creating your driver, you need to find out what those libraries are. The best way to do so is to run the `kextlibs` tool on your built kext and copy its output into your kext’s `Info.plist` file.

## Installing

KEXTs are usually installed in the folder `/System/Libraries/Extensions`. The Kernel Extension Manager (in the form of a daemon, kextd), always checks here. KEXTs can also be installed in ROM or inside an application bundle. Installing KEXTs in an application bundle allows an application to register those KEXTs without the need to install them permanently elsewhere within the system hierarchy. This may be more convenient and allows the KEXT to be associated with a specific, running application. When it starts, the application can register the KEXT and, if desired, unregister it on exit.


## Creating a Device Driver with Xcode


Every I/O Kit driver is based on an I/O Kit family, a collection of C++ classes that implement functionality that is common to all devices of a particular type. Examples of I/O Kit families include storage devices (disks), networking devices, and human-interface devices (such as keyboards).

An I/O Kit driver communicates with the device it controls through a provider object, which typically represents the bus connection for the device. Provider objects that do so are referred to as nubs.

An I/O Kit driver is loaded into the kernel automatically when it matches against a device that is represented by a nub. A driver matches against a device by defining one or more personalities, descriptions of the types of device the driver can control.

After an I/O Kit driver matches against a device and loads into the kernel, it routes I/O for the device, as well as vending services related to the device, such as providing a firmware update mechanism.





## References

* [Creating a Device Driver with Xcode](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KEXTConcept/KEXTConceptIOKit/iokit_tutorial.html#//apple_ref/doc/uid/20002366)
* [Kernel Extension Overview](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KernelProgramming/Extend/Extend.html)
* [Implementing drivers, system extensions, and kexts](https://developer.apple.com/documentation/kernel/implementing_drivers_system_extensions_and_kexts?language=occ)


