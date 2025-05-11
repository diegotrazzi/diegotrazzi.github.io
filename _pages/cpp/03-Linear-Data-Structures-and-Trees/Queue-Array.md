---
title: "Array-Based Implementation of Queue (Ring Buffer)"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/FIFO.gif" alt="CLL" height="150">
</div>

A queue is a linear data structure that follows the **First In, First Out (FIFO)** principle: the first element added is the first removed, like people lining up for a bus. It supports key operations: **enqueue (add to back), dequeue (remove from front), peek (view front), isEmpty, and isFull**. Queues are abstract data types and can be implemented using arrays, linked lists, or other structures, depending on the application’s needs. FIFO ensures fairness and order, useful in scheduling and data processing.

## Representing a Circular Queue with an Array [Ring Buffer]

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/LIFO-ring-buffer03.gif" alt="CLL" height="350">
</div>

This explains how to implement a queue using an array, specifically a circular queue to reuse space after dequeuing. The queue tracks elements with **front, rear, and size pointers**. Key operations - **enqueue, dequeue, peek, isEmpty, and isFull** — all run in constant time $O(1)$:

```cpp
class ArrayQueue {
private:
    int capacity; // Maximum capacity of the queue
    int front;   // Front index for dequeue operation
    int rear;    // Rear index for enqueue operation
    int size;    // Current size of the queue
    int* array;  // Array representing the queue

public:
    ArrayQueue(int c) {
        capacity = c;
        array = new int[capacity];
        front = 0;
        rear = -1;
        size = 0;
    }

    // Enqueue: Add an element to the rear of the queue
    void enqueue(int data) {
        if(isFull()) {
            throw std::runtime_error("Queue is full");
        }
        
        rear = (rear + 1) % capacity;
        array[rear] = data; 
        size++;
    }

    // Dequeue: Remove an element from the front of the queue
    int dequeue() {
        if(isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }
        
        int data = array[front];
        front = (front + 1) % capacity;
        size--;
        return data; 
    } 

    // Peek: View the front element without removing it
    int peek() {
        if (isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }

        return array[front];
    }

    // Check if queue is empty
    bool isEmpty() {
        return size == 0;
    }

    // Check if queue is full
    bool isFull() {
        return size == capacity; // Circular queue condition for full
    }

    ~ArrayQueue() {
        delete[] array;
    }
};
```

Main method:

```cpp
int main() {
    ArrayQueue myQueue(5);
    myQueue.enqueue(1);
    myQueue.enqueue(2);
    myQueue.enqueue(3);
    std::cout << "Peek: " << myQueue.peek() << std::endl;
    std::cout << "Dequeue: " << myQueue.dequeue() << std::endl;
    std::cout << "Peek: " << myQueue.peek() << std::endl;

    return 0;
}
```
