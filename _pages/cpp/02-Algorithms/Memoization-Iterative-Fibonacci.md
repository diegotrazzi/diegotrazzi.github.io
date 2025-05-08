---
title: "Iterative Fibonacci with Memoization"
---

An iterative approach also stands to benefit from implementing dynamic programming.
Compared to the recursive counterpart, the iterative fib() function is a more efficient algorithm. The time complexity is still $O(n)$, but the space complexity is reduced. You still have a memoization table with a space complexity of $O(n)$, but there is no recursive call stack. The iterative fib() is only called one time.

```c++
int fib(int n) {
    if (n <= 1) {
        return n;
    }

    int memo[n + 1];
    memo[0] = 0;
    memo[1] = 1;

    for (int i = 2; i <= n; i++) {
        memo[i] = memo[i - 1] + memo[i - 2];
    }

    return memo[n];
}
```
