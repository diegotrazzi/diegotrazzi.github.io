---
title: "Dynamic Array Based Implementation of Priority Queue"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Priority-Queue-LL.png" alt="CLL" height="250">
</div>

## Dynamic Arra Based Implementation

A priority queue using std::vector stores elements in order by inserting at the correct position, supports efficient peek and dequeue (O(1)), and uses vector methods for dynamic resizing and management.

```cpp
#include <iostream>
#include <vector>
#include <stdexcept>

class VectorPriorityQueue {
private:
    std::vector<int> vector;

public:
    // Constructor
    VectorPriorityQueue() {}

    // Enqueue operation with priority handling
    void enqueue(int value) {
        int indexToInsert = 0;
        // Find the correct index to insert the item based on priority
        for (int i = 0; i < vector.size(); i++) {
            int current = vector[i];
            // Compare the new item with the current item for priority
            if (value > current) {
                indexToInsert = i;
                break;
            }
            // If the new item has higher priority, increment the index
            indexToInsert++;
        }
        // Insert the item at the determined index
        vector.insert(vector.begin() + indexToInsert, value);
    }

    // Dequeue operation
    int dequeue() {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }
        int value = vector[0];
        vector.erase(vector.begin());
        return value;
    }
    
    // Peek operation
    int peek() const {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }
        return vector[0];
    }
    
    // Check the size of the Priority Queue
    int getSize() const {
        return vector.size();
    }
    
    // Check if the Priority Queue is empty
    bool isEmpty() const {
        return vector.empty();
    }
};
```

Main method:

```cpp
int main() {
    VectorPriorityQueue myPQ;
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
