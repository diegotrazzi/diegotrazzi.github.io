---
title: "Algorithms"
permalink: /cpp/02-Algorithms/
---

## Module 1 | Big(O)

If the running time of an algorithm is $O(f(n))$, it means that the running time grows at most linearly with $f(n)$. For example, if we say an algorithm has a time complexity of $O(n)$, it means that in the worst case, the algorithm’s running time increases linearly with the size of the input.

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/BigO.webp" alt="BigO" height="350">
</div>

### Recursion Cost

:warning: The general form of cost for a divide-and-conquer recurrence relation is:

$$
T(n) = a*T\left(\frac{n}{b}\right) + f(n)
$$

Where:

- $T(n)$ is the time complexity for an input size $n$.
- $a$ is the **number of subproblems** (how many times the problem is divided).
- $b$ is the **factor by which the problem size is reduced** for each subproblem.
- $O(n^d)$ represents the **cost of dividing the problem** and combining the solutions (this is the non-recursive work done).

## Module 2 | Recursion, Greedy Algorithms, Dynamic Programming

> :warning: **Tail recurion:** many compilers and interpreters can optimize tail recursive calls to reuse the current method’s stack frame for the next call, effectively transforming the recursion into iteration and dramatically reducing space requirements.

### Greedy Algorithms

Greedy algorithms build up a solution piece by piece, always choosing the next piece that offers the most immediate benefit or profit. This approach is mainly used to solve optimization problems: Efficiency, Simplicity and Optimality.

- Coin Change Example: [Code](./Code-snippets/Challenges/Greedy-Coin-Change.md)
- Knapsack 01: [Code](./Code-snippets/Challenges/Greedy-Knapsac-01.md)
- Knapsack 02: [Code](./Code-snippets/Challenges/Greedy-Knapsack-02.md)

### Dynamic Programming

Dynamic programming is a technique for solving problems by breaking them down into smaller subproblems, storing the solutions to the subproblems, and then using the stored solutions to solve the original problem. This allows us to solve the original problem more efficiently, since we do not have to repeat any calculations.

**Memoization** is an optimization technique used to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again. This is commonly referred to as a top-down approach.

- Recusive Fibonacci with Memoization: [Code](./Code-snippets/Memoization-Recursive-Fibonacci.md)
- Iterative Fibonacci Sequence with Memoization: [Code](./Code-snippets/Memoization-Iterative-Fibonacci.md)

**Tabulation**
Another way to implement dynamic programming is through tabulation. That is, we use a 2D array to store data in a table, where the elements are arranged into rows and columns. Each cell in the table contains solutions to all of the sub-problems that make up a larger problem. This is commonly referred to as a bottom-up approach.

- Longest Common Subsequence (LCS): [Code](./Code-snippets/Memoization-Longest-Common-Subsequence.md)

## Module 3 | Sorting Algorithms

- [Selection Sort](./Code-snippets/Sorting-Algorithms-Selection-Sort.md)
- [Bubble Sort](./Code-snippets/Sorting-Algorithms-Bubble-Sort.md)
- [Insertion Sort](./Code-snippets/Sorting-Algorithms-Insertion-Sort.md)
- Recursion (divide-and-conquer):
  - [Merge Sort](./Code-snippets/Sorting-Algorithms-Merge-Sort.md)
  - [Quick Sort](./Code-snippets/Sorting-Algorithms-Quick-Sort.md)

Not covered in this course:

- Heap Sort
- Counting Sort
- Radix Sort
- Bucket Sort
- Shell Sort

## Module 3 | Searching Algorithms

- [Linear Search](./Code-snippets/Search-Linear.md)
- [Binary Search](./Code-snippets/Search-Binary.md)
- [Jump Search](./Code-snippets/Search-Jump.md)

Not covered in this course:

- Interpolation Searc
- Exponential Search
- Fibonacci Search

## REFERENCES

- [Algorithms Visualization](https://www.hackerearth.com/practice/algorithms/sorting/merge-sort/visualize/)
- [Comparison Sorting Algorithms - USF](https://www.cs.usfca.edu/~galles/visualization/ComparisonSort.html)
