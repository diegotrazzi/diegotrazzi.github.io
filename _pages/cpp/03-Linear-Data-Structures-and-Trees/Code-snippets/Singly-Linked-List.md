---
title: "Singly Linked List"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/linked-list.png" alt="BigO" height="100">
</div>

- No wasted space as it grows/shrinks **dynamically**.
- Faster insertions and deletions $O(1)$ if position reference is available.
- Slower random access $O(n)$, including **deletion**, **traversal** and **searching**.
- Each node has additional memory overhead for the ‘next’ reference.
- Linked List Types: **Singly, Doubly, Circular.**
- Space complexity is $O(n)$.

**Stack/Queue Implementations**: They can be used to implement other data structures like stacks and queues.

## Singly Linked List Implementation

```c++
class Node {
  public:
    int data;
    Node* next;

    Node(int data) : data(data) {
      next = nullptr;
    }
};

class LinkedList {
  public:
    Node* head; // LL needs a head pointer

    LinkedList() {
      head = nullptr;
    }

    void add(int data) {
      Node* newNode = new Node(data);
      // Add node to the list
      if (head == nullptr) {
        head = newNode;
      } else {
        // traverse the LL using a temp pointer
        Node* temp = head;
        while (temp->next != nullptr) {
          temp = temp->next;
        }
        temp->next = newNode;
      }
    }
```

## Linked List Operations

### Insertion

To insert a node at the beginning of the list, you have to change the head to the new node and make the new node point to the original head.

```cpp
void insertAtBeginning(int data) {
    Node* newNode = new Node(data);
    newNode->next = head;
    head = newNode;
  }
```

To add a node at the end of the list, you have to traverse the list to the last node and then link the new node.

```cpp
void insertAtEnd(int data) {
    Node* newNode = new Node(data);
    if (head == nullptr) {
        head = newNode;
        return;
    }
    Node* last = head;
    while (last->next != nullptr) {
        last = last->next;
    }
    last->next = newNode;
}
```

### Deletion

To delete a node, you first need to find it and then rearrange the pointers to exclude it from the list. There are three different cases for this operation. The node to delete is the head, the node to delete is not in the list, or the node to delete is somewhere in the list. We are going to need two additional Node objects when performing a deletion – `temp` and `prev`.

```cpp
void deleteNode(int data) {
    Node* temp = head;
    Node* prev = nullptr;

    if (temp != nullptr && temp->data == data) {
        head = temp->next;
        delete temp;
        return;
    }

    while (temp != nullptr && temp->data != data) {
        prev = temp;
        temp = temp->next;
    }

    if (temp == nullptr) return;

    prev->next = temp->next;
    delete temp;
}
```

## Navigating a Circular Linked List

### Traversal

We cannot know the length of any given linked list ahead of time, so we need to utilize a while loop.

```cpp
int countNodes() {
    Node* temp = head;
    int counter = 0;
    while (temp != nullptr) {
        counter += 1;
        temp = temp->next;
    }
    return counter;
}
```

### Search

To search for a node in a linked list, you are going to use a linear search. Unlike searching an array, you do not return an index, as direct access to a value is not done in a linked list.

```cpp
bool search(int data) {
    Node* current = head;
    while (current != nullptr) {
        if (current->data == data)
            return true;
        current = current->next;
    }
    return false;
}
```
