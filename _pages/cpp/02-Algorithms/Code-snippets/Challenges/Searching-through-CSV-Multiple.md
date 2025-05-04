# Searching through CSV Multiple

You have been provided with a CSV file containing several columns: accountNumber, firstName, lastName, and money. Create the method search that takes a vector of strings and a search target (also a string). The method should search by money and return all of the record (std::vector<std::string>) that match the search target. If the target is not found, the method should return an empty vector.


```c++
// FREEZE CODE BEGIN
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "CSVreader.h"

// FREEZE CODE END

// WRITE YOUR CODE HERE

using namespace std;

vector<string> search(vector<string> &data, string target) {
    vector<string> matches;
    for (auto &s : data) {
        stringstream ss(s);
        string field;
        int col = 0;
        while (getline(ss, field, ',')) {
            if (col == 3 && field == target) { // money column
                matches.push_back(s);
                break;
            }
            col++;
        }
    }
    return matches;
}

// FREEZE CODE BEGIN
int main(int argc, char* argv[]) {
    std::string path = argv[1];
    std::string target = argv[2];
    std::vector<std::string> data = readCSV(path);
    std::vector<std::string> results = search(data, target);

    if (results.empty()) {
        std::cout << "No matching records found." << std::endl;
    } else {
        std::cout << "Matching Records:" << std::endl;
        for (const std::string& record : results) {
            std::istringstream iss(record);
            std::string token;
        
            while (std::getline(iss, token, ',')) {
                std::cout << token << " ";
            }
            std::cout << std::endl;
        }
    }

    return 0;
}
// FREEZE CODE END

```