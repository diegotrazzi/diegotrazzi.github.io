---
title: "Constructor"
---

## Constructor with Initializer List vs. Body Assignment

In C++, you can assign member variables in two ways: using an **initializer list** or by assigning inside the constructor body.

* **Initializer List**: assigns directly during construction (more efficient, needed for `const` or references).

* **Body Assignment**: assigns after default construction (may be less efficient).

### Example 1

```cpp
class MyClass {
    int x, y;
public:
    // Using initializer list
    MyClass(int a, int b) : x(a), y(b) {}

    // Equivalent longer form (inside body)
    // MyClass(int a, int b) {
    //     x = a;
    //     y = b;
    // }
};
```

### Constructor with `const` Member (Initializer List Required)

For `const` members, you **must** use an initializer list since they can’t be assigned after construction.

### Example 2

```cpp
class MyClass {
    const int x;
public:
    // Must use initializer list for const
    MyClass(int a) : x(a) {}

    // This would cause an error:
    // MyClass(int a) {
    //     x = a; // ❌ cannot assign to const
    // }
};
```
