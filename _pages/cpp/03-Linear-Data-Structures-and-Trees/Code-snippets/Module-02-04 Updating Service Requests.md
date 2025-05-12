# Updating Service Requests

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include "PartialQueue.h"
#include "Helper.h"
// FREEZE CODE END

// WRITE YOUR CODE HERE
class Queue : public PartialQueue {
public:
    std::string dequeue() {
        if (this->isEmpty()) {
            throw std::underflow_error("Queue is empty");
        }
        Node* tmpNode = front;
        std::string data = tmpNode->data;
        front = front->next;
        totalNodes--;
        delete tmpNode;
        return data;
    }

    std::string peek() {
        if (this->isEmpty()) {
            throw std::underflow_error("Queue is empty; cannot peek");
        }
        return front->data;
    }

    int getCount() {
        // I can't keep track of totalNodes becaus eI don't have access to the enqueue
        Node* tmpNode = front;
        int totalcount = 0;
        while (tmpNode != nullptr) {
            tmpNode = tmpNode->next;
            totalcount++;
        }
        return totalcount;
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
    try {
        std::cout << "Next request: " << serviceQueue.peek() << std::endl;
        std::cout << "Processing Service Request: " << serviceQueue.dequeue() << std::endl;
        std::cout << "Remaining requests: " << serviceQueue.getCount() << std::endl;
        std::cout << "Processing Service Request: " << serviceQueue.dequeue() << std::endl;
        std::cout << "Remaining requests: " << serviceQueue.getCount() << std::endl;
        std::cout << "Processing Service Request: " << serviceQueue.dequeue() << std::endl;
        std::cout << "Next request: " << serviceQueue.peek() << std::endl;
    } catch (const std::runtime_error& e) {
        std::cout << e.what() << std::endl;
    }

    return 0;
}
// FREEZE CODE END
```

