# Banking Framework

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <string>
#include <sstream>
// FREEZE CODE END
using namespace std;
// WRITE YOUR CODE HERE
class DLLNode {
  public:
    DLLNode* next;
    DLLNode* previous;
    string data;

    DLLNode(string data) : data(data), next(nullptr), previous(nullptr) {}
};

class DoublyLinkedList {
  DLLNode* head;
  DLLNode* tail;

public:
  DoublyLinkedList(){
    head = nullptr;
    tail = nullptr;
  }

  void insert(std::string transaction) {
    DLLNode* newNode = new DLLNode(transaction);
    
    // if head is null ?
    if (head == nullptr) {
      head = newNode;
      tail = newNode;
    } else {
      tail->next = newNode;
      newNode->previous = tail;
      tail = newNode;
    }
  }

  int total() {
    int totalAmount = 0;
    DLLNode* current = head;

    while (current != nullptr) {
        // Split the string by ":" to extract the transaction amount
        size_t pos = current->data.find(':');
        if (pos != std::string::npos) {
            std::string type = current->data.substr(0, pos);  // Transaction type
            std::string amountStr = current->data.substr(pos + 3);  // Amount part
            // Check if it's a Deposit transaction
            if (type == "Deposit") {
                // Convert the amount to an integer
                try {
                    int amount = std::stoi(amountStr);
                    totalAmount += amount;  // Add to total if it's a deposit
                } catch (const std::invalid_argument& e) {
                    std::cerr << "Invalid amount format: " << amountStr << "\n";
                }
            }
        }

        current = current->next;
    }
    return totalAmount;
  }

// FREEZE CODE BEGIN
void printList() {
    DLLNode* current = head;
    while (current != nullptr) {
        std::cout << "'" << current->data << "'";
        current = current->next;
        if (current != nullptr) {
            std::cout << " <-> ";
        }
    }
    std::cout << "\n";
}

};

int main(int argc, char* argv[]) {
    DoublyLinkedList transactionList;

    for (int i = 1; i < argc; i++) {
        transactionList.insert(argv[i]);
    }

    int total = transactionList.total();
    transactionList.printList();
    std::cout << "Total: $" << total << "\n";

    return 0;
}
// FREEZE CODE END
```
