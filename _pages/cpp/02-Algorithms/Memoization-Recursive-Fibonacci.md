---
title: "Fibonacci with Memoization"
---

The use of dynamic programming principles means that the time complexity of fib() is now $O(n)$. The space complexity becomes a bit more complicated as we now introduce greater auxiliary space due to memoization. The space complexity for the memoization table is $O(n)$, and the space complexity for the recursive call stack is also $O(n)$.

```c++
#include <iostream>

int *memo; // Declaring memo as a pointer to int

int fib(int n) {
    if (memo[n] != -1) {
        return memo[n];
    }

    if (n <= 1) {
        memo[n] = n;
    } else {
        memo[n] = fib(n - 1) + fib(n - 2);
    }

    return memo[n];
}

int main() {
    int n = 40;
    memo = new int[n + 1]; // Allocating memory for memo

    for (int i = 0; i <= n; ++i) {
        memo[i] = -1; // Initializing memoization array with -1
    }

    // Print the 40th Fibonacci number
    std::cout << "Fibonacci number at position " << n << " is: " << fib(n) << std::endl;

    delete[] memo; // Free allocated memory

    return 0;
}
```