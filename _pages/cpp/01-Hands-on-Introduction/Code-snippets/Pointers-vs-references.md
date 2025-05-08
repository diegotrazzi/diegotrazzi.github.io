---
title: "Pointers"
---

## Pointers vs references

A reference acts as an alias to an object, allowing direct access without explicit dereferencing, unlike a pointer, which holds the memory address of an object and requires dereferencing (*) to access the object’s value or members. Using a reference simplifies syntax, while a pointer provides more flexibility (e.g., reassigning to point to another object or handling nullptr).

### Pointers

* **Declaration:** `int* ptr;`  
* **Memory Address:** A pointer holds the memory address of an object.
* **Nullability:** Pointers can be `nullptr`, meaning they may not point to any object.
* **Dereferencing:** You need to use the dereference operator (`*`) to access the value at the memory address the pointer holds. Example: `int value = *ptr;`
* **Reassignment:** Pointers can be reassigned to point to different objects or even be set to `nullptr`. Example: `ptr = &newObj;`
* **Size:** Pointers typically take up the size of an address (often 4 or 8 bytes, depending on the platform).
* **Memory Management:** Pointers can be dynamically allocated and deallocated using `new` and `delete`.

### References

* **Declaration:** `int& ref = obj;`
* **Memory Address:** A reference does not hold a memory address; it is an alias to the object itself.
* **Nullability:** References **cannot** be null. They must always refer to a valid object when initialized.
* **Dereferencing:** References automatically dereference. You access the value directly without needing to use an operator like `*`. Example: `int value = ref;`
* **Reassignment:** Once a reference is bound to an object, it **cannot** be changed to refer to a different object.
* **Size:** References are typically implemented as pointers internally, but you don’t have direct access to their size or address.
* **Memory Management:** No need for manual memory management with references as they automatically refer to valid objects.

### Key Differences in Operators

* **Pointer Dereference (`*`):** When you want to access the value of the object a pointer is pointing to, you use `*`. This gives you the object itself, allowing modifications. Example: `*ptr = 10;`
* **Reference Dereference (Implicit):** With references, dereferencing is automatic. You directly interact with the object. Example: `ref = 10;`
* **Pointer Access (`->`):** To access members of the object that a pointer points to, you use `->`, which is a combination of dereferencing and accessing the member. Example: `ptr->method();`
* **Reference Access (`.`):** You use `.` to access members of the object that a reference refers to, just like you would with an object directly. Example: `ref.method();`

### Summary Table

| Feature                         | Pointer                         | Reference                    |
|----------------------------------|---------------------------------|------------------------------|
| **Can be null**                  | Yes (`nullptr`)                 | No                           |
| **Initialization**               | Must be initialized to an object or `nullptr` | Must be initialized to an object |
| **Dereferencing**                | Requires `*` to access value    | No need for dereferencing    |
| **Reassignable**                 | Yes (can point to different objects) | No (always refers to the same object) |
| **Memory Management**            | Requires manual management (via `new`/`delete`) | No manual management required |
| **Operator for accessing members** | `->`                           | `.`                           |

Exmaple:

```cpp
#include <iostream>

struct Item {
    int value;
    void show() { std::cout << value << std::endl; }
};

int main() {
    Item obj{42};

    // Using pointer
    Item* ptr = &obj;
    std::cout << ptr->value << std::endl;  // access member via pointer
    ptr->show();                           // call function via pointer

    // Using reference
    Item& ref = obj;
    std::cout << ref.value << std::endl;   // access member via reference
    ref.show();                            // call function via reference

    return 0;
}
```

