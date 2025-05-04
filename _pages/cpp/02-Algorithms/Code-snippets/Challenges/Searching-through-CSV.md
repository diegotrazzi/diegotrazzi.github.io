# Searching through CSV

You have been provided with a CSV file containing several columns: accountNumber, firstName, lastName, and money. Create the method search that takes a vector of strings and a search target (also a string). The method should search by account number. It should return the elements from the vector that contains the search target. If the target is not found, the method should return an empty string.


```c++
// FREEZE CODE BEGIN
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "CSVreader.h"
using namespace std;

string search(vector<string> &data, string target) {
    for (auto &s : data) {
        stringstream ss(s);
        string accountNumber;
        getline(ss, accountNumber, ',');
        if (accountNumber == target) {
            return s;
        }
    }
    return "";
}

int main(int argc, char *argv[]) {
    std::string path = argv[1];
    std::string target = argv[2];

    std::vector<std::string> data = readCSV(path);
    std::string result = search(data, target);

    if (!result.empty()) {
        std::cout << "Account Details:" << std::endl;
        std::stringstream ss(result);
        std::string item;

        while (std::getline(ss, item, ',')) {
            std::cout << item << " ";
        }
        std::cout << std::endl;
    } else {
        std::cout << "An account with " << target << " is not found." << std::endl;
    }

    return 0;
}
```