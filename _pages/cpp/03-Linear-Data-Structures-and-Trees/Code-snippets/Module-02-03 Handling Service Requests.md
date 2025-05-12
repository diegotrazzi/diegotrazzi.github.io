# Handling Service Requests

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <vector>
#include <string>
#include "Helper.h"
// FREEZE CODE END

// WRITE YOUR CODE HERE
class Node {
public:
    std::string value;
    Node* next;
    Node(std::string value) : value(value), next(nullptr) {}
};

class Queue {
public:
    Node* front;
    Node* rear;
    
    Queue() : front(nullptr), rear(nullptr) {}
    
    void enqueue(std::string value) {
        Node* newNode = new Node(value);
        if (front == nullptr) {
            front = newNode;
            rear = newNode;
        } else {
            rear->next = newNode;
            rear = newNode;
        }
    }

    void printQueue() {
        Node* tmpNode = front;
        while (tmpNode != nullptr) {
            std::cout << "Remaining service request: " << tmpNode->value << std::endl;
            tmpNode = tmpNode->next;
        }
    }
};


// FREEZE CODE BEGIN
int main(int argc, char* argv[]) {
    Queue serviceQueue;
    std::vector<std::string> serviceRequests = Helper::parseArgs(argc, argv);
    
    for (const std::string& request : serviceRequests) {
        serviceQueue.enqueue(request);
    }
    
    std::cout << "Service Queue Status" << std::endl;
    std::cout << "--------------------" << std::endl;
    serviceQueue.printQueue();
    
    return 0;
}
// FREEZE CODE END
```
