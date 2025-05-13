---
title: "Algorithms"
permalink: /cpp/02-Algorithms/
---

### Dynamic Programming

Dynamic programming is a technique for solving problems by breaking them down into smaller subproblems, storing the solutions to the subproblems, and then using the stored solutions to solve the original problem. This allows us to solve the original problem more efficiently, since we do not have to repeat any calculations.

**Memoization** is an optimization technique used to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again. This is commonly referred to as a top-down approach.

- Recusive Fibonacci with Memoization: [Code](./Memoization-Recursive-Fibonacci.md)
- Iterative Fibonacci Sequence with Memoization: [Code](./Memoization-Iterative-Fibonacci.md)

**Tabulation**
Another way to implement dynamic programming is through tabulation. That is, we use a 2D array to store data in a table, where the elements are arranged into rows and columns. Each cell in the table contains solutions to all of the sub-problems that make up a larger problem. This is commonly referred to as a bottom-up approach.

- Longest Common Subsequence (LCS): [Code](./Memoization-Longest-Common-Subsequence.md)
