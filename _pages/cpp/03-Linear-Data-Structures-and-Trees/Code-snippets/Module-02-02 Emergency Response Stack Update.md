# Emergency Response Stack Update

```cpp
// FREEZE CODE BEGIN
#include "RMS.h"
#include <iostream>
#include <stdexcept>
#include <vector>
#include <sstream>
#include <string>
// FREEZE CODE END

// WRITE YOUR CODE HERE
class Stack: public RMS {
    public:
        std::string pop() {
            if (this->isEmpty()) {
                throw std::underflow_error("Cannot delete from an empty stack.");
            } else {
                Node* tempNode = this->top;
                std::string data = tempNode->data;
                top = tempNode->next;
                delete tempNode;
                return data;
            }
        }

        void printStack() {
            Node* tempNode = this->top;
            while (tempNode != nullptr) {
                std::cout << "Incident to resolve: " << tempNode->data << std::endl;
                tempNode = tempNode->next;
            }
        }
};

// FREEZE CODE BEGIN
class Popstack {
public:     
std::vector<std::string> parseArgs(int argc, char* argv[]) {
    std::vector<std::string> incidents;
    std::stringstream sb;
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) != ":") {
            sb << argv[i] << " ";
            if (i + 1 == argc) {
                incidents.push_back(sb.str());
                sb.str("");
                sb.clear();
            }
        } else {
            incidents.push_back(sb.str());
            sb.str("");
            sb.clear();
        }
    }
    return incidents;
 }

};

int main(int argc, char* argv[]) {
    Stack incidentStack;
    Popstack parse;
    std::vector<std::string> incidents = parse.parseArgs(argc, argv);
    for (const std::string& incident : incidents) {
        incidentStack.push(incident);
    }
    try {
        std::string resolvedIncident = incidentStack.pop();
        std::cout << "Resolved Incident: " << resolvedIncident << std::endl;
    } catch (const std::runtime_error& e) {
        std::cerr << e.what() << std::endl;
    }

    std::cout << "RMS Status" << std::endl;
    std::cout << "----------" << std::endl;
    incidentStack.printStack();

    return 0;
}

// FREEZE CODE END
```

