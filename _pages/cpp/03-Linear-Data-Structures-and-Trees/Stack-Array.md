---
title: "Stack (LIFO)"
---

A stack is a linear data structure (ADT) that allows insertion and deletion of elements only at one end, called the top. It follows the **Last In, First Out (LIFO)** principle: the most recently added element is the first to be removed. The key operations are `push` (add), `pop` (remove), and optionally `peek` (view the top without removing). Stacks do not support direct traversal or access to elements below the top.

## Array-Based Stack Implementation

An array-based stack uses an **array** and a **top index** to manage elements, following the LIFO principle. Push, pop, and peek operations adjust or access the top index, ensuring fast performance $O(1)$. Though arrays allow efficient access, they have fixed size unless dynamically resized. 

The ArrayStack class encapsulates this, providing methods to push, pop, peek, and check if the stack is empty or full, demonstrating basic stack behavior through array management:

```cpp
class ArrayStack {
private:
    // Initialize the maximum size of the stack
    int maxSize;
    // Initialize a variable to track the top element
    int top;
    // Create an array to hold the stack elements
    int* stackArray;

public:
    // Constructor to set up the stack size
    ArrayStack(int size) {
        maxSize = size;
        stackArray = new int[maxSize];
        // Set the top to -1 as the stack is initially empty
        top = -1;
    }

    // Destructor to clean up the allocated memory
    ~ArrayStack() {
        delete[] stackArray;
    }

    // Push operation to add a value to the top of the stack
    void push(int value) {
        // Check if the stack is full
        if (isFull()) {
            std::cout << "Stack is full. Cannot push " << value << std::endl;
            return;
        }
        // Increment the top and add the value
        stackArray[++top] = value;
    }

    // Pop operation to remove the top value from the stack
    int pop() {
        // Check if the stack is empty
        if (isEmpty()) {
            std::cout << "Stack is empty. Cannot pop." << std::endl;
            return -1;
        }
        // Remove the top value and decrement the top
        return stackArray[top--];
    }

    // Peek operation to view the top value without removing it
    int peek() {
        // Check if the stack is empty
        if (isEmpty()) {
            std::cout << "Stack is empty. Cannot peek." << std::endl;
            return -1;
        }
        // Return the top value without removing it
        return stackArray[top];
    }

    // Check if the stack is empty
    bool isEmpty() {
        return (top == -1);
    }

    // Check if the stack is full
    bool isFull() {
        return (top == maxSize - 1);
    }
};
```
