---
title: "String"
---

* C++ Basics: Selection and Iteration.
* C++ Basic Structures: Vectors, [Pointers](./01-Hands-on-Introduction/Code-snippets/Pointers-vs-references.md), **[Strings](./01-Hands-on-Introduction/Code-snippets/Strings.md)**, and Files.
* C++ Object Basics: Functions, Recursion, and Objects:
  * [Constructor](./01-Hands-on-Introduction/Code-snippets/Constructor.md)
* Object-Oriented C++: Inheritance and Encapsulation.


## Using size_t for Position Tracking

* In C++, the `size_t` type is commonly used for holding the position of elements in containers or strings.
* Using `std::string::find()` for Searching in Strings. It returns the index (position) of the first occurrence of : in the string. If `:` is not found, it returns std::string::npos.
* Extracting Substrings with `std::string::substr()`. It takes the substring starting at index 0 and ends.
* Using try-catch for Exception Handling: when converting a string to an integer (or another numeric type), there can be errors if the string doesn’t represent a valid number. In C++, this can be handled using std::stoi() inside a try-catch block.

Example:

```cpp
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
```