---
title: "Coin Change Greedy"
---

## Greedy Algorithms

Greedy algorithms build up a solution piece by piece, always choosing the next piece that offers the most immediate benefit or profit. This approach is mainly used to solve optimization problems: Efficiency, Simplicity and Optimality.

The coin change problem is a problem where you have a certain amount of money and you need to find the minimum number of coins that you need to make up that amount of money. The greedy algorithm for the coin change problem works by choosing the largest coin that does not exceed the amount of money that you need.

Given different coin denominations and a total amount, find the minimum number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

```c++
#include <iostream>
#include <algorithm>
class CoinChangeGreedy {
    public:  
    int coinChange(int coins[], int n, int amount) {
        // Sort the coins in ascending order
        std::sort(coins, coins + n);
        int count = 0;

        // Starting from the largest coin denomination
        for (int i = n - 1; i >= 0 && amount > 0; i--) {
            while (amount >= coins[i]) {  // while we can still use coin[i]
                amount -= coins[i];
                count++;
            }
        }

        return amount == 0 ? count : -1;
    }
};

int main() {
    int coins[] = {1, 5, 10, 25};  // US coin denominations
    int n = sizeof(coins) / sizeof(coins[0]);  // number of coins
    int amount = 63;
    CoinChangeGreedy coinCG;
    int result = coinCG.coinChange(coins, n, amount);

    if (result != -1) {
        std::cout << "Minimum coins needed: " << result << std::endl;
    } else {
        std::cout << "The amount cannot be represented using the given denominations." << std::endl;
    }

    return 0;
}
```
