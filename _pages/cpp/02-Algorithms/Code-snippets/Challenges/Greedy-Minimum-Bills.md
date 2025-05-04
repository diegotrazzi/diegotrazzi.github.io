# Recursion | Minimum Bills

Create the function minMoney that implements a greedy algorithm to determine the minimum number of bills needed to make up the displayed amount. 

The functon should take an unsorted vector of integer objects and an integer representing the desired amount. You must sort the vector in order first. 

The function should return the minimum number of bills (an integer) it takes to make the desired amount. If you cannot make the desired amount with the given denominations, return -1.


```c++
// FREEZE CODE BEGIN
#include "Reader.h"
#include <iostream>
#include <vector>
#include <algorithm>
// FREEZE CODE END

// WRITE YOUR CODE HERE
using namespace std;

int minMoney(std::vector<int>& money, int amount) {
        std::sort(money.begin(), money.end());
        int result = 0;
        for (int i = money.size() - 1; i >= 0; i--) {
            while (amount >= money[i]) {
                amount -= money[i];
                result++;
            }
        }
        if (amount == 0) {
            return result;
        } else {
            return -1;
        }
    }


// FREEZE CODE BEGIN
int main(int argc, char* argv[]) {
    if (argc < 4) {
        std::cerr << "Usage: " << argv[0] << " <path> <index> <amount>" << std::endl;
        return 1;
    }

    std::string path = argv[1];
    int index = std::stoi(argv[2]);
    int amount = std::stoi(argv[3]);

    std::vector<int> moneyArr = Reader::parseIntArray(path, index);

    int result = minMoney(moneyArr, amount);

    if (result != -1) {
        std::cout << "Minimum bills required: " << result << std::endl;
    } else {
        std::cout << "Cannot make exact change with given denominations" << std::endl;
    }

    return 0;
}
// FREEZE CODE END

```