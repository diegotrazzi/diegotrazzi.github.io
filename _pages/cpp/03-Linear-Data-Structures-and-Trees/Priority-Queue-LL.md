---
title: "Linked List Based Implementation of Priority Queue"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Priority-Queue-LL.png" alt="CLL" height="250">
</div>

## Linked List Based Implementation

A linked list-based priority queue uses a singly linked list where each node stores data and a next pointer. The `enqueue` operation inserts elements in descending priority order, either at the head if it’s empty or the new value is larger, or by traversing the list to find the correct spot. `dequeue` removes the **head node (highest priority)**. Time complexity is O(n) for enqueue and O(1) for dequeue and peek.

Calss Node:

```cpp
class Node {
public:
    int data;
    Node* next;

    Node(int data) : data(data), next(nullptr) {}
};
```

`LinkedListPriorityQueue` class: has two attributes, head (keeps track of the first node) and size (keeps track of the size of the list):

```cpp
class LinkedListPriorityQueue {
private:
    Node* head;
    int size;

public:
    // Constructor
    LinkedListPriorityQueue() : head(nullptr), size(0) {}
    
    // Enqueue operation with priority handling
    void enqueue(int value) {
        Node* newNode = new Node(value);
        // Insert at the head if empty or higher priority
        if (isEmpty() || value > head->data) {
            newNode->next = head;
            head = newNode;
        } else { // iterate to find the correct spot
            Node* current = head;
            while (current->next != nullptr && current->next->data <= value) {
                current = current->next;
            }
            newNode->next = current->next;
            current->next = newNode;
        }
        size++;
        }
    
    // Dequeue operation
    int dequeue() {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }
        int value = head->data;
        Node* temp = head;
        head = head->next;
        delete temp;
        size--;
        return value;
    }

    // Peek operation
    int peek() const {
        if (isEmpty()) {
            throw std::underflow_error("Priority queue is empty");
        }
        return head->data;
    }

    // Check the size of the Priority Queue
    int getSize() const {
        return size;
    }

    // Check if the Priority Queue is empty
    bool isEmpty() const {
        return head == nullptr;
    }

    ~LinkedListPriorityQueue() {
        while (!isEmpty()) {
            dequeue();
        }
    }

};
```

Main method:

```cpp
int main() {
    LinkedListPriorityQueue myPQ;
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
