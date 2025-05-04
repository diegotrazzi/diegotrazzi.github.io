---
title: "Linear Data Structures and Trees"
---

**ADTs** focus on the bigger picture (**the what**), while data structures focus on the details (**the how**).

## Dynamic Array-Based List

**Dynamic Array-Based Implementation with std::vector:**

* Fast random access $O(1)$.
* Less memory overhead than linked lists.
* Slower insertions and deletions $O(n)$ due to element shifting.
* Fixed-size arrays limit capacity; dynamic arrays incur resizing costs.

**Operations:**

* Subslits (using constructor)
* Sorting
* Find
* Erase

:bulb: [Implementation Details](./Code-snippets/Dynamic-Array-List.md)

---

## Singly Linked List

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/linked-list.png" alt="Linked List" height="100">
</div>

* Faster insertions and deletions $O(1)$ if position reference is available.
* No wasted space as it grows/shrinks dynamically.
* Slower random access $O(n)$.
* Each node has additional memory overhead for the ‘next’ reference.
* Linked List Types: **Singly, Doubly, Circular.**

**Operations:**

* Traversal
* Insertion
* Deletion
* Searching

:bulb: [Implementation Details](./Code-snippets/Linked-List.md)

---

## Doubly Linked List

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/doubly-linked-list.webp" alt="BigO" height="100">
</div>

A doubly linked list (DLL) is a list of nodes, where each node has two pointers. One references the next node in the list, while the other pointer references the previous node.

:bulb: [Implementation Details](./Code-snippets/Doubly-Linked-List.md)

## REFERENCES

* [std::vector<T,Allocator>::erase](https://en.cppreference.com/w/cpp/container/vector/erase)
