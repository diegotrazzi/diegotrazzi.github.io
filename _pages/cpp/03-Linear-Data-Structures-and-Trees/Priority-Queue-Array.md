---
title: "Array Based Implementation of Priority Queue"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Priority-Queue-Array02.png" alt="CLL" height="250">
</div>

A **priority queue** is a data structure where elements are dequeued based on priority rather than just FIFO order, making it useful for tasks like scheduling and data compression. In the current context, integers represent priority, with **larger numbers having higher priority**. Core operations include **enqueue (insert with priority), dequeue (remove highest priority), peek, isEmpty, and size**. Implementations range from simple arrays and linked lists, $O(n)$ for `enqueue()` operations, to binary and Fibonacci heaps, $O(log_n)$.

## Array Based Implementation

> :warning: An array-based priority queue stores elements in order of priority, requiring traversal of the array to insert or remove elements in the correct position. Both enqueue and dequeue have $O(n)$ time complexity in the worst case due to this traversal.

The **ArrayPriorityQueue** class uses a fixed-size array to store elements in descending order of priority. The enqueue method **inserts elements in their correct position by shifting lower-priority elements**, while dequeue removes the highest-priority element (at the end).

```cpp
#include <iostream>
#include <stdexcept>

class ArrayPriorityQueue {
private:
    int capacity;
    int* array;
    int size;

public:
    // Constructor
    ArrayPriorityQueue(int capacity) {
        this->capacity = capacity;
        array = new int[this->capacity];
        size = 0;
    }

    ~ArrayPriorityQueue() {
        delete[] array;
    }

    // Enqueue operation with priority handling
    void enqueue(int value) {
        if (isFull()) {
            throw std::overflow_error("Priority queue is full");
        }

        if (isEmpty()) {
            array[size++] = value;
            return;
        }

        int i;
        for (i = size - 1; i >= 0; i--) {
            if (value < array[i]) {
                array[i + 1] = array[i];
            } else {
                break;
            }
        }
        array[i + 1] = value;
        size++;
    }

    // Dequeue operation
    int dequeue() {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }

        return array[--size];
    }

    // Peek operation
    int peek() {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }

        return array[size - 1];
    }

    // Check the size of the Priority Queue
    int getSize() const {
        return size;
    }

    // Check if the Priority Queue is empty
    bool isEmpty() const {
        return size == 0;
    }

    // Check if the priority queue is full
    bool isFull() const {
        return size == capacity;
    }
};
```

Main method:

```cpp
int main() {
    ArrayPriorityQueue myPQ(5);
    myPQ.enqueue(3);
    myPQ.enqueue(2);
    myPQ.enqueue(4);
    std::cout << "Highest priority element: " << myPQ.peek() << std::endl;
    std::cout << "Priority queue size: " << myPQ.getSize() << std::endl;
    std::cout << "Dequeue operation result: " << myPQ.dequeue() << std::endl;
    std::cout << "Priority queue size: " << myPQ.getSize() << std::endl;

    return 0;
}
```
