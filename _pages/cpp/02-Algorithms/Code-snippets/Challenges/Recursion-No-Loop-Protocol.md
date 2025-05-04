# Recursion | No Loop Protocol

Create the function linearSearch that implements a recursive version of the linear search to find the required element from a vector. You cannot use for or while loops. The function takes an unsorted vector of strings and an element (also string).

```c++
#include <iostream>
#include <vector>
#include <string>
#include "Reader.h"
using namespace std;

int linearSearch(std::vector<string> &data, int i, string target) {
  // read line by line
  int size = data.size();
  if (i==size) { // index reached end
    return -1;
  }
  if (data[i].find(target) != string::npos) {
    return i;
  }
  return linearSearch(data, i+1, target);
}

int main(int argc, char* argv[]) {
    if (argc < 4) {
        std::cerr << "Usage: " << argv[0] << " <path_to_csv> <target_element> <data_type>" << std::endl;
        return 1;
    }
    std::string path = argv[1];
    std::string target = argv[2];
    std::string type = argv[3];
    std::vector<std::string> data = Reader::parseCSV(path, type);

    int result = linearSearch(data, 0, target);
    if (result != -1) {
        std::cout << "Element " << target << " found at index: " << result << std::endl;
    } else {
        std::cout << "Element not found" << std::endl;
    }
    
    return 0;
}
```