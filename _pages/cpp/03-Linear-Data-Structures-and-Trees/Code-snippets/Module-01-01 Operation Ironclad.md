# Operation Ironclad

```cpp
#include <iostream>
#include <string>

// FREEZE CODE BEGIN
class Node {
public:
    std::string data;
    Node* next;

    Node(const std::string& data) {
        this->data = data;
        this->next = nullptr;
    }
};

class SinglyLinkedList {
public:
    Node* head;

    SinglyLinkedList() {
        this->head = nullptr;
    }
// FREEZE CODE END

// WRITE YOUR CODE HERE
    void insert(const std::string& data) {
      // Insert new node at the end of the list
      Node* newNode = new Node(data);
      Node* temp = head;
      while (temp->next != nullptr) {
        temp = temp->next;
      }
      temp->next = newNode;
    }


// FREEZE CODE BEGIN
    // Utility method to print the linked list.
    void printList() const {
        Node* temp = head;
        while (temp != nullptr) {
            std::cout << temp->data << " -> ";
            temp = temp->next;
        }
        std::cout << "NULL" << std::endl;
    }

};

void makeList(SinglyLinkedList& list, char* values[]) {
    for (int i = 0; i < 4; ++i) {
        Node* newNode = new Node(values[i]);
        Node* temp;
        if (list.head == nullptr) {
            list.head = newNode;
        } else {
            temp = list.head;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            temp->next = newNode;
        }
    }
}

int main(int argc, char* argv[]) {
    SinglyLinkedList list;
    makeList(list, argv + 1);
    list.insert(argv[5]);
    list.printList();
    return 0;
}
// FREEZE CODE END
```

