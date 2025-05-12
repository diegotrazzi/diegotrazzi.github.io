# Remove Vulnerable Protocols

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <string>

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
        head = nullptr;
    }
// FREEZE CODE END

// WRITE YOUR CODE HERE
    void deleteTarget(const std::string& target) {
        // pointer to presious
        // while loop until node->data == target
        // link the previous to the next
        
        Node* previous = nullptr;
        Node* temp = head;
        
        if (head != nullptr) {
            head = head->next;
            temp = head;
        }


        // target is on first place
        if (temp != nullptr && temp->data == target) {
            head = temp->next;
            delete temp;
            return;
        }

        // target is somewhere along the SinglyLinkedList
        while (temp != nullptr && temp->data != target) {
            previous = temp;
            temp = temp->next;
        }

        if (temp == nullptr) return;

        // if temp is found
        previous->next = temp->next;
        delete temp;
    }


// FREEZE CODE BEGIN
    void printList() const {
        Node* temp = head;
        while (temp != nullptr) {
            std::cout << temp->data << " -> ";
            temp = temp->next;
        }
        std::cout << "NULL" << std::endl;
    }
};

void makeList(SinglyLinkedList& list, char* values[], int size) {
    for (int i = 0; i < size; ++i) {
        Node* newNode = new Node(values[i]);
        if (list.head == nullptr) {
            list.head = newNode;
        } else {
            Node* temp = list.head;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            temp->next = newNode;
        }
    }
}

int main(int argc, char* argv[]) {
    SinglyLinkedList list;
    makeList(list, argv + 1, argc - 2);  // Make list with first 5 elements
    list.deleteTarget(argv[argc - 1]);   // Target is the last argument
    list.printList();
    return 0;
}

// FREEZE CODE END
```
