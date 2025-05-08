---
title: "Stack (LIFO)"
---

## List-Based Stack Implementation

A stack implemented with a linked list offers more flexibility than an array-based stack, as it can dynamically grow or shrink in size. In this implementation, the head node of the linked list serves as the top of the stack. The core operations—push, pop, peek, and isEmpty—all operate in constant time $O(1)$, providing efficient stack behavior without the fixed size constraint of arrays.

```cpp
// Node class definition
class Node {
public:
    int data;
    Node* next;

    Node(int data) {
        this->data = data;
        this->next = nullptr;
    }
};
```

`LinkedStack` class:

```cpp
// LinkedStack class definition
class LinkedStack {
private:
    // Initialize the head (top) of the linked list
    Node* head;

public:
    // Constructor to initialize an empty stack
    LinkedStack() {
        head = nullptr;
    }

    // Push operation
    void push(int value) {
        Node* newNode = new Node(value);
        newNode->next = head;
        head = newNode;
    }

    // Pop operation
    int pop() {
        if (isEmpty()) {
            std::cout << "Stack is empty. Cannot pop." << std::endl;
            return -1;
        }
        int poppedValue = head->data;
        Node* temp = head; // The temp node is needed to delete the old head and free its memory
        head = head->next;
        delete temp;
        return poppedValue;
    }

    // Peek operation
    int peek() {
        if (isEmpty()) {
            std::cout << "Stack is empty. Cannot peek." << std::endl;
            return -1;
        }
        return head->data;
    }

    // Check if stack is empty
    bool isEmpty() {
        return head == nullptr;
    }
};
```
