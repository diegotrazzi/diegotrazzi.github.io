---
title: "Dynamic Array-Based Implementation of Queue (FIFO)"
---

## Dynamic Array-Based Implementation

Dynamic arrays (like `std::vector`) let queues resize automatically, avoiding manual pointer management. We track the front with an index.

> :warning: **Note:** the `enqueue()` cost is $O(1)(amortized)$ meaning that is an averaged time per operation over a sequence of operations, giving a more comprehensive understanding of performance. this is because the array has to resize form time to time.

> :warning: **Warning:** In this implementation, the vector keeps growing even as you dequeue because you only move the `frontIndex` forward—but never actually remove old elements from the vector’s storage.

Example:

```cpp
#include <iostream>
#include <vector> // REMEMBER TO INCLUDE!

class DynamicArrayQueue {
private:
    std::vector<int> queue;
    int frontIndex;  // Keeps track of the front index
    
public:
    // Initialize an empty queue
    DynamicArrayQueue() {
        frontIndex = 0;
    }

    // Enqueue: Add an element to the end of the queue
    void enqueue(int value) {
        queue.push_back(value);  // std::vector handles resizing
    }

    // Dequeue: Remove an element from the front of the queue
    int dequeue() {
        if (isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }
        int temp = queue[frontIndex];
        frontIndex++;
        return temp;
    }

    // Peek: View the front element without removing it
    int peek() {
        if (isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }
        return queue[frontIndex];
    }

    // Check if the queue is empty
    bool isEmpty() {
        return frontIndex >= queue.size();
    }
};
```
