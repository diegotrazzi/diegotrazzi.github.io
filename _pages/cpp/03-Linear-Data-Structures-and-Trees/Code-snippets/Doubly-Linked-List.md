---
title: "Doubly Linked List"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/doubly-linked-list.webp" alt="BigO" height="100">
</div>

A doubly linked list (DLL) is a list of nodes, where each node has two pointers. One references the next node in the list, while the other pointer references the previous node.

In a doubly linked list: inserting at the beginning costs $O(1)$; inserting at the end costs $O(1)$ with a tail pointer, else $O(n)$; inserting at a position costs $O(n)$ due to traversal. Deleting at the beginning is $O(1)$; at the end, $O(1)$ with tail, else $O(n)$; deleting at a position is $O(n)$, or $O(1)$ if you already have the node pointer. Traversal is $O(n)$, and searching is $O(n)$.

## Doubly Linked List Implementation

```c++
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

class DoublyLinkedList {
public:
    Node* head;
    Node* tail;

    DoublyLinkedList() {
        head = nullptr;
        tail = nullptr;
    }
};
```

## Linked List Operations

### Traversal

We cannot know the length of any given linked list ahead of time, so we need to utilize a while loop (same as singly linked list).

```cpp
  void printList() {
      Node* temp = head;
      while (temp != nullptr) {
          std::cout << temp->data << " ";
          temp = temp->next;
      }
      std::cout << std::endl;
  }

  void reversePrint() {
      Node* current = tail;

      while (current != nullptr) {
          std::cout << current->data << " ";
          current = current->prev;
      }
      std::cout << std::endl;
    }
```

---

### Search

Searching a doubly linked list is still done in a linear manner. Let’s take a look at how we can simplify some of our other operations using a search method.

```cpp
Node* findNode(int value) {
        Node* current = head;
        while (current != nullptr) {
            if (current->data == value) {
                return current;
            }
            current = current->next;
        }
        return nullptr; // node not found
    }
```

---

### Insertion

To insert a node at the beginning of the list, you have to change the head to the new node and make the new node point to the original head.

#### At the Beginning

```cpp
    void insertAtBeginning(int data) {
        Node* newNode = new Node(data);
        newNode->next = head;

        if (head != nullptr) {
            head->prev = newNode;
        }

        head = newNode;

        if (head->next == nullptr) {
            tail = newNode;
        }
    }
```

#### At the End

```cpp
    void insertAtEnd(int data) {
        Node* newNode = new Node(data);

        if (head == nullptr) {
            head = newNode;
            tail = newNode;
        } else {
            tail->next = newNode;
            newNode->prev = tail;
            tail = newNode;
        }
    }
```

#### At a Specific Position

```cpp
    void insertAtPos(int data, int pos) {
        if (pos < 1) {
            std::cout << "Invalid position." << std::endl;
            return;
        }

        if (pos == 1) {
            insertAtBeginning(data);
        } else {
            Node* current = head;
            Node* newNode = new Node(data);
            int currentPos = 1;

            // Traverse the list to find the node before the desired position.
            while (currentPos < pos - 1 && current != nullptr) {
                current = current->next;
                currentPos++;
            }

            if (current == nullptr) {
                std::cout << "Invalid position." << std::endl;
                return;
            }

            // Adjust links to insert the new node at the specified position.
            newNode->prev = current;
            newNode->next = current->next;
           if (current->next == nullptr) {
                tail = newNode;
            } else {
                current->next->prev = newNode;
            }
            current->next = newNode;
        }
    }
```
---

### Deletion

Just like the insertion operations, we are going to cover how to remove nodes from the beginning, end, and at a specific position in a list.

#### Form the Beginning

```cpp
void deleteAtBeginning() {
    if (head == nullptr) {
        return;
    }

    Node* oldHead = head;
    head = head->next;

    if (head != nullptr) {
        head->prev = nullptr;
    }

    delete oldHead;  // free memory
}
```

#### From the End

```cpp
void deleteAtEnd() {
    if (tail == nullptr) return;

    Node* oldTail = tail;
    tail = tail->prev;

    if (tail) tail->next = nullptr;

    delete oldTail;  // free memory
}
```

#### From a Specific Position

```cpp
void deleteAtPos(int pos) {
    if (pos < 1) {
        std::cout << "Invalid position." << std::endl;
        return;
    }

    if (pos == 1) {
        deleteAtBeginning();
        return;
    }

    Node* current = head;
    int currentPos = 1;

    while (currentPos < pos && current != nullptr) {
        current = current->next;
        currentPos++;
    }

    if (current == nullptr) {
        std::cout << "Invalid position." << std::endl;
        return;
    }

    // Adjust links to delete the node at the specified position.
    current->prev->next = current->next;
    if (current->next == nullptr) {
      tail = current->prev;
      } else {
        current->next->prev = current->prev;
      }

    delete current;  // free memory
}
```

#### Delete with Node*

```cpp
void deleteNode(Node* del) {
        if (head == nullptr || del == nullptr) return;

        if (head == tail) {
            delete head;
            head = nullptr;
            tail = nullptr;
            return;
        }
        
        if (head == del) {
            deleteAtBeginning();
            return;
        }

        if (tail == del) {
            deleteAtEnd();
            return;
        }

        del->prev->next = del->next;
        del->next->prev = del->prev;
        delete del;
    }
```
