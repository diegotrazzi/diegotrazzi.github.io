---
title: "Deque Doubly Linked List"
---

## Representing a Circular Deque with an Array

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Deque-LL.jpg" alt="CLL" height="350">
</div>

A deque can be efficiently implemented using a doubly linked list, allowing **dynamic growth and constant-time insertion/removal at both ends**. Each node stores data and pointers to the previous and next nodes.

```cpp
#include <iostream>
#include <stdexcept>

class Node {
public:
    int data;
    Node* next;
    Node* prev;

    Node(int data) {
        this->data = data;
        this->next = nullptr;
        this->prev = nullptr;
    }
};
```

```cpp
class DequeLinkedList {
private:
    Node* head;
    Node* tail;
    int size;

public:
    DequeLinkedList() {
        head = nullptr;
        tail = nullptr;
        size = 0;
    }

    void addFront(int data) {
        Node* newNode = new Node(data);

        if (isEmpty()) {
            head = newNode;
            tail = newNode;
        } else {
            newNode->next = head;
            head->prev = newNode;
            head = newNode;
        }

        size++;
    }

    void addRear(int data) {
        Node* newNode = new Node(data);

        if (isEmpty()) {
            head = newNode;
            tail = newNode;
        } else {
            newNode->prev = tail;
            tail->next = newNode;
            tail = newNode;
        }

        size++;
    }

    int removeFront() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        Node* temp = head;
        head = head->next;
        if (head == nullptr) {
            tail = nullptr;
        } else {
            head->prev = nullptr;
        }
        int data = temp->data;
        delete temp;
        size--;
        return data;
    }

    int removeRear() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        Node* temp = tail;
        tail = tail->prev;
        if (tail == nullptr) {
            head = nullptr;
        } else {
            tail->next = nullptr;
        }
        int data = temp->data;
        delete temp;
        size--;
        return data;
    }

    int peekFront() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }
        return head->data;
    }

    int peekRear() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }
        return tail->data;
    }

    bool isEmpty() {
        return head == nullptr;
    }

    int getSize() {
        return size;
    }
};
```

Main method:

```cpp
int main() {
    DequeLinkedList myDeque;

    myDeque.addFront(1);
    myDeque.addFront(2);
    std::cout << "Front element: " << myDeque.peekFront() << std::endl;

    myDeque.addRear(3);
    myDeque.addRear(4);
    std::cout << "Rear element: " << myDeque.peekRear() << std::endl;

    std::cout << "Removed from front: " << myDeque.removeFront() << std::endl;
    std::cout << "Removed from rear: " << myDeque.removeRear() << std::endl;

    std::cout << "Is deque empty? " << (myDeque.isEmpty() ? "true" : "false") << std::endl;
    std::cout << "Size of deque: " << myDeque.getSize() << std::endl;

    return 0;
}
```
