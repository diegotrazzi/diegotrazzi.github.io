---
title: "Recursion"
---

## Recursion, Greedy Algorithms, Dynamic Programming

> :warning: **Tail recurion:** many compilers and interpreters can optimize tail recursive calls to reuse the current method’s stack frame for the next call, effectively transforming the recursion into iteration and dramatically reducing space requirements.

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