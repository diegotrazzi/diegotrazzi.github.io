---
title: "Circular Linked List"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/circular-linked-list.webp" alt="CLL" height="150">
</div>

In a circular linked list (CLL), the last node points back to the head, forming a loop (unlike singly/doubly linked lists that end with nullptr). CLLs can be singly or doubly linked, though singly is more common for lower memory use.

A circular linked list (CLL) has the same time complexities as a singly linked list (SLL); the main difference is structural (looped vs. linear), not in operation costs. Would you like a side-by-side comparison?

| Operation               | Singly Linked | Doubly Linked                  | Circular Linked               |
|-------------------------|---------------|-------------------------------|-------------------------------|
| Insertion (Beginning)   | $O(1)$        | $O(1)$                        | $O(1)$                        |
| Insertion (End)         | $O(n)$ or $O(1)$ (with tail) | $O(n)$ or $O(1)$ (with tail) | $O(n)$ or $O(1)$ (with tail) |
| Insertion (Position)    | $O(n)$        | $O(n)$                        | $O(n)$                        |
| Deletion (Beginning)    | $O(1)$        | $O(1)$                        | $O(1)$                        |
| Deletion (End)         | $O(n)$ or $O(1)$ (with tail) | $O(n)$ or $O(1)$ (with tail) | $O(n)$ or $O(1)$ (with tail) |
| Deletion (Position)     | $O(n)$        | $O(n)$                        | $O(n)$                        |
| Traversal               | $O(n)$        | $O(n)$                        | $O(n)$                        |
| Searching               | $O(n)$        | $O(n)$                        | $O(n)$                        |

## Circular Linked List Implementation

```c++
class Node {
public:
    Node* next;
    int data;

    Node(int data) : data(data), next(nullptr) {}
};

class CircularList {
public:
    Node* head;
    Node* tail;

    CircularList() : head(nullptr), tail(nullptr) {}
};
```

## Linked List Operations

### Insertion

To add a node at the start of a circular linked list: create a new node; if the list is empty, set head and tail to it and point its next to itself; if not, link the new node’s next to the current head, update head to the new node, and update tail’s next to point to the new head.

#### At the Beginning

```cpp
void insertAtBeginning(int data) {
    Node* newNode = new Node(data);
    if (head == nullptr) {
        // List is empty, make the new node the head and tail.
        head = newNode;
        tail = newNode;
        newNode->next = newNode;
    } else {
        newNode->next = head;
        head = newNode;
        tail->next = newNode;
    }
}
```

#### At the End

Start by creating a new node. If the list is empty (head == nullptr), set both head and tail to the new node, point its next to itself, and return to exit the method.
If the list is not empty, set newNode->next to head, set tail->next to newNode, and update tail to point to newNode.

```cpp
void insertAtEnd(int data) {
        Node* newNode = new Node(data);

        if(head == nullptr) {
            // List is empty, make the new node the head and tail.
            head = newNode;
            tail = newNode;
            newNode->next = newNode;
            return;
        }

        newNode->next = head;
        tail->next = newNode; // Point to itself for circularity.
        tail = newNode;
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
        while (currentPos < pos - 1) {
            current = current->next;
            currentPos++;

            if (current == head) {
                std::cout << "Invalid position." << std::endl;
                return;
            }
        }

        // Adjust links to insert the new node at the specified position.
        newNode->next = current->next;
        current->next = newNode;
        if (newNode->next == head) {
            tail = newNode;
        }
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
        
        if (head == tail) {
          head = nullptr;
          tail = nullptr;
          return;
        }
        
        head = head->next;
        tail->next = head;
    }
```

#### From the End

If the list is empty, do nothing. If it has one node, set head and tail to nullptr. Otherwise, traverse from head to find the node before tail, set its next to head, and update tail to this node.

```cpp
void deleteAtEnd() {
    if (head == nullptr) return;

    if (head == tail) { 
        head = nullptr;
        tail = nullptr;
        return;
    }

    Node* secondToLast = head;
    while (secondToLast->next != tail) {
        secondToLast = secondToLast->next;
    }

    secondToLast->next = head;
    tail = secondToLast;
}
```

#### Delete with Node*

To delete a given node, check if the list is empty or the node is null; if so, exit. If deleting the head or only node, call deleteAtBeginning(). If deleting the tail, call deleteAtEnd(). Otherwise, traverse with prevDel to find the node just before del, then set prevDel->next = del->next to bypass (and effectively remove) del.

```cpp
void deleteNode(Node* del) {
    if (head == nullptr || del == nullptr) return;

    if (head == del || head == tail) {
        deleteAtBeginning();
        return;
    }

    if (tail == del) {
        deleteAtEnd();
        return;
    }

    Node* prevDel = head;

    while (prevDel != nullptr) {
        if (prevDel->next == del) {
            break;
        }
        prevDel = prevDel->next;
    }

    prevDel->next = del->next;
}
```

#### From a Specific Position

Check three cases: if the list is empty, print a message and exit; if position < 1, print invalid position and exit; if position is 1, call deleteAtBeginning(). Else, traverse to the node before the target, adjust current->next to skip the node, and if the removed node was the tail, update tail to current.

```cpp
void deleteAtPos(int pos) {
    if (head == nullptr) {
        std::cout << "Cannot remove node from an empty list." << std::endl;
        return;
    }

    if(pos < 1) {
        std::cout << "Invalid position." << std::endl;
        return;
    }

    if(pos == 1) {
        deleteAtBeginning();
    } else {
        Node* current = head;
        int currentPos = 1;

        // Traverse the list to find the node before the desired position.
        while (currentPos < pos - 1) {
            current = current->next;
            currentPos++;

            if (current == tail) {
                std::cout << "Invalid position." << std::endl;
                return;
            }
        }

        // Adjust links to insert the new node at the specified position.
        current->next = current->next->next;
        if (current->next == head) {
            tail = current;
        }
    }
}
```

## Navigating a Circular Linked List

### Traversal

Traversing a CLL must detect when it loops back to the head to avoid infinite loops. A correct printList method processes nodes until it returns to the head. Traversing by stopping at the tail risks missing the tail’s data, so head-based stopping is safer.

> ⚠️ Important: Be sure to uncomment the break statement in the printList method. We do not want any more infinite loops when we run our code.

```cpp
void printList() {
    Node* current = head;

    while (current != nullptr) {
        std::cout << current->data << " ";
        current = current->next;

        if (current == head) {
            std::cout << std::endl;
            break;
        }
    }
}
```

### Search

Create findNode(int value). Start with current = head and traverse the list. If current->data == value, return current. Move to current->next; if back at head, break and return nullptr (node not found).

```cpp
Node* findNode(int targetValue) {
    Node* current = head;

    while(current != nullptr) {
        if (current->data == targetValue) {
        return current;
        }
        current = current->next;

        if(current == head) {
        break;
        }
    }

    return nullptr;
}
```
