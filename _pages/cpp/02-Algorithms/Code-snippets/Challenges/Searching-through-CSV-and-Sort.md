# Searching through CSV and Sort

You have been provided with a CSV file containing several columns: accountNumber, firstName, lastName, and money. Create the method sort that takes a vector of strings and sorts the records in ascending order based on the last name column.
Please use comments in your code. Ensure your solution considers the efficiency of the sort operation.
> Hint: You have been given the readCSV method which reads a given CSV file and returns the contents as a vector of strings, with each element representing the account number, first name, last name, and money. The strings look something like this:
"1234,John,Doe,1234.56". You will need to parse these strings to get the information you need, as well as typecast the information into the appropriate data type. Only then can you begin to sort the information.


```c++
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>
#include "CSVreader.h"

using namespace std;

// Function to split a string based on a delimiter
vector<string> split(const string& str, char delimiter) {
    vector<string> tokens;
    string token;
    istringstream tokenStream(str);
    while (getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

// Sort function to sort based on last name
void sort(vector<string>& data) {
    std::sort(data.begin(), data.end(), [](const string& a, const string& b) {
        vector<string> tokensA = split(a, ',');
        vector<string> tokensB = split(b, ',');
        return tokensA[2] < tokensB[2]; // Compare by lastName (3rd column)
    });
}

int main(int argc, char* argv[]) {
    std::string path = argv[1];
    std::vector<std::string> data = readCSV(path);

    sort(data);

    // Print the first and last elements after sorting
    std::cout << data.front() << std::endl;
    std::cout << data.back() << std::endl;

    return 0;
}
```