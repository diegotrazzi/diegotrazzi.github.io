# Recursion | Binary Search

Utilize the divide and conquer strategy to create the binarySearch function which implements a binary search algorithm. Your algorithm must include recursion.

```c++
#include <iostream>
#include <vector>
#include "Reader.h"
using namespace std;

int binarySearch(vector<int> &data, int begin, int end, int target) {
    if (begin > end) { // base case
        return -1;
    }
    int mid = begin + (end - begin) / 2;
    if ((data[mid]) == target) {
        return mid;
    }
    // if the target is smaller than mid, call recursion on left half
    if (target < data[mid]) {
        return binarySearch(data, begin, mid - 1, target);
    } else {
        return binarySearch(data, mid + 1, end, target);
    }
    return -1;
}

int main(int argc, char* argv[]) {
    // Check if the correct number of arguments are provided
    if (argc < 4) {
        std::cerr << "Usage: " << argv[0] << " <filename> <index> <target>" << std::endl;
        return 1;
    }

    // Parse command line arguments
    std::string path = argv[1];    // File name
    int index = std::stoi(argv[2]); // Index of the array in the file
    int target = std::stoi(argv[3]); // Target element to search for

    // Parse the array from the file
    std::vector<int> data = Reader::parseIntArray(path, index);

    // Perform binary search on the array
    int result = binarySearch(data, 0, data.size() - 1, target);

    // Print the result
    if (result != -1) {
        std::cout << "Element " << target << " is located at index: " << result << std::endl;
    } else {
        std::cout << "Element not found" << std::endl;
    }

    return 0;
}
```