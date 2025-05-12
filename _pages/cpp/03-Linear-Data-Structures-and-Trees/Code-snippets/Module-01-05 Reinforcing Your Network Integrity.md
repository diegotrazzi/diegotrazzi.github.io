# Reinforcing Your Network Integrity

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <string>

class Node {
public:
    std::string data;
    Node* next;

    Node(std::string data) {
        this->data = data;
        this->next = nullptr;
    }
};

class LinkedList {
public:
    Node* head;
    Node* tail;
    int length;

    LinkedList() {
        head = nullptr;
        tail = nullptr;
        length = 0;
    }

    void insert(std::string data) {
        Node* newNode = new Node(data);
        if(head == nullptr) {
            head = newNode;
            tail = newNode;
        } else {
            tail->next = newNode;
            tail = newNode;
        }
        length++;
    }

    void display() {
        if(head != nullptr) {
            Node* current = head;
            while(current != nullptr) {
                std::cout << current->data << " ";
                current = current->next;
            }
            std::cout << std::endl;
        }
    }

// FREEZE CODE END

// WRITE YOUR CODE HERE
    static LinkedList mergeLinkedLists(LinkedList& list1, LinkedList& list2) {
        LinkedList mergedList;
        Node* list1CurrentNode = list1.head;
        Node* list2CurrentNode = list2.head;

        while (list1CurrentNode != nullptr && list2CurrentNode != nullptr) {
            mergedList.insert(list1CurrentNode->data);
            mergedList.insert(list2CurrentNode->data);
            list1CurrentNode = list1CurrentNode->next;
            list2CurrentNode = list2CurrentNode->next;
        }

        while (list1CurrentNode != nullptr) {
            mergedList.insert(list1CurrentNode->data);
            list1CurrentNode = list1CurrentNode->next;
        }

        while (list2CurrentNode != nullptr) {
            mergedList.insert(list2CurrentNode->data);
            list2CurrentNode = list2CurrentNode->next;
        }

        return mergedList;

    }


// FREEZE CODE BEGIN
};

LinkedList makeList(std::string elems[], int start, int stop) {
    LinkedList newList;
    for (int i = start; i < stop; i++) {
        newList.insert(elems[i]);
    }
    return newList;
}

int findDivider(std::string elems[], int length) {
    for (int i = 0; i < length; i++) {
        if (elems[i].rfind(":", 0) == 0) {
            return i;
        }
    }
    return -1;
}

int main(int argc, char* argv[]) {
    LinkedList list1;
    LinkedList list2;
    LinkedList mergedList;
    std::string* args = new std::string[argc - 1];
    for(int i = 0; i < argc - 1; i++) {
        args[i] = argv[i + 1];
    }
    int divider = findDivider(args, argc - 1);
    list1 = makeList(args, 0, divider);
    list2 = makeList(args, divider + 1, argc - 1);
    mergedList = LinkedList::mergeLinkedLists(list1, list2);
    mergedList.display();
    delete[] args;
    return 0;
}
// FREEZE CODE END
```
