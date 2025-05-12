# Operation Priority Shield

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <vector>
#include <stdexcept>
#include "Helper.h"
// FREEZE CODE END

// WRITE YOUR CODE HERE
class Node {
public:
    Incident data;
    Node* next;
    Node(Incident incident, Node*next) : data(incident), next(nullptr) {}
};

class PriorityQueue { // HEAD == highest priority
public:    
    Node* head;
    size_t size;

    PriorityQueue() : head(nullptr), size(0) {}

    void enqueue(Incident newIncident){
    Node* newNode = new Node(newIncident, nullptr);
    // Check if empty, insert at the head
    if (isEmpty() || newIncident.priority > head->data.priority) {
            newNode->next = head;
            head = newNode;
        } else {
        // Iterate to find correct spot
        Node* current = head;
        while (current->next != nullptr && current->next->data.priority >= newIncident.priority) {
            current = current->next;
        }
        newNode->next = current->next;
        current->next = newNode;
        }
        size++;
    }
    
    Incident dequeue(){ // Remove highest priority == head
        if (isEmpty()) {
            throw std::runtime_error("Cannot dequeue; priority queue is empty");
        }
        Incident newIncident = head->data;
        Node* oldHead = head;
        head = head->next;
        delete oldHead;
        size--;
        return newIncident;
    }

    Incident peek(){
        if (isEmpty()) {
            throw std::runtime_error("Cannot peek; priority queue is empty");
        }
        Incident newIncident = head->data;
        return newIncident;
    }
    
    int getSize(){
        return size;
    }

    bool isEmpty(){
        return size == 0;
    }
    
    void printQueue(){
        Node* current = head;
        while (current != nullptr) {
            std::cout << priorityToString(current->data.priority) << " " << current->data.description << std::endl;
            current = current->next;
        }
    }

    std::string priorityToString(Priority p) {
        switch (p) {
            case Priority::LOW: return "LOW";
            case Priority::MEDIUM: return "MEDIUM";
            case Priority::HIGH: return "HIGH";
            default: return "UNKNOWN";
        }
    }
};


// FREEZE CODE BEGIN
int main(int argc, char* argv[]) {
    PriorityQueue priorityShield;
    std::vector<std::string> arguments(argv + 1, argv + argc);
    std::vector<std::string> incidents = Helper::parseArgs(arguments);
    std::vector<Incident> incidentObjects = Helper::parseIncidents(incidents);
    for (const auto& incident : incidentObjects) {
        priorityShield.enqueue(incident);
    }
    std::cout << "Priority Queue Status" << std::endl;
    std::cout << "---------------------" << std::endl;
    std::cout << "Empty queue: " << std::boolalpha << priorityShield.isEmpty() << std::endl;
    std::cout << "Queue size: " << priorityShield.getSize() << std::endl;
    std::cout << "-- Incidents --" << std::endl;
    priorityShield.printQueue();
    std::cout << "---------------" << std::endl;
    Incident removedIncident = priorityShield.dequeue();
    std::cout << "Removing: " << removedIncident.toString() << std::endl;
    std::cout << "Next incident: " << priorityShield.peek().toString() << std::endl;
    std::cout << "-- Incidents --" << std::endl;
    priorityShield.printQueue();

    return 0;
}
// FREEZE CODE END
```
