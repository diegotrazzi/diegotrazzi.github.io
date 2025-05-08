---
title: "Linked-List Based Implementation of Queue (FIFO)"
---

## Linked List-Based Implementation of Queue

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/LIFO-ring-buffer-LL-01.webp" alt="RINGLL" height="350">
</div>

A linked list-based queue uses a dynamic singly linked list with front and rear pointers. It’s flexible (no fixed size) and uses a Node class for elements. The queue handles memory cleanup in its destructor.

> :warning: Unlike a ring buffer, a linked list-based queue doesn’t need to wrap around. We simply remove the dequeued node and create a new node when enqueuing.

```cpp
// Define Node class for linked list elements
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

Then create the LinkedListQueue class:

```cpp
class LinkedListQueue {
private:
    Node* front;  // Front of the queue
    Node* rear;   // Rear of the queue

public:
    // Initialize an empty queue
    LinkedListQueue() {
        front = nullptr;
        rear = nullptr;
    }

    // Enqueue: Add an element to the REAR
    void enqueue(int value) {
        Node* newNode = new Node(value);
        if (isEmpty()) {
            front = newNode;
            rear = newNode;
        } else {
            rear->next = newNode;
            rear = newNode;
        }
    }

    // Dequeue: Remove an element from the front of the queue
    int dequeue() {
        if (isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }
        int temp = front->data;
        Node* tempNode = front;
        front = front->next;
        delete tempNode;
        if (isEmpty()) {
            rear = nullptr; // If queue becomes empty
        }
        return temp;
    }

    // Peek: View the front element without removing it
    int peek() {
        if (isEmpty()) {
            throw std::runtime_error("Queue is empty");
        }
        return front->data;
    }

    // Check if the queue is empty
    bool isEmpty() {
        return front == nullptr;
    }

    ~LinkedListQueue() {
        while (!isEmpty()) {
            dequeue();
        }
    }
};
```
