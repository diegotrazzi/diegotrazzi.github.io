---
title: "Jump Search"
---

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/jump-search.gif" height="400">
</div>

Jump Search is an efficient algorithm for **sorted arrays**. It works by jumping ahead by fixed steps and then performing a **linear search** within the block where the target may lie.

Optimal step size is $\sqrt{n}$ for minimizing comparisons.

## Steps

#### Step 1: Choose Block Size

- Typically: `step = sqrt(n)`

#### Step 2: Jump in Steps

- Jump ahead by `step` until `arr[min(step, n)-1] >= target` or end of array.

#### Step 3: Linear Search in Block

- Perform linear search from previous index to current step.

## Full Implementation

```c++
#include <cmath> // for sqrt

int jumpSearch(int arr[], int size, int target) {
    int step = std::sqrt(size);
    int prev = 0;

    while (arr[std::min(step, size) - 1] < target) {
        prev = step;
        step += std::sqrt(size);
        if (prev >= size) return -1;
    }

    for (int i = prev; i < std::min(step, size); ++i) {
        if (arr[i] == target)
            return i;
    }

    return -1; // Not found
}
```

## Jump Search - $O(\sqrt{n})$

### Time Complexity

* Best Case: $O(1)$
- Average/Worst Case: $O(\sqrt{n})$

### Space Complexity

* $O(1)$
  
### Advantages

* Faster than linear search for sorted arrays
- Easy to implement

### Disadvantages

* Requires sorted data
- Slower than binary search

### Use Cases

* Sorted data where binary search is not ideal (e.g., high cost of index access)
- Memory-constrained systems needing low space overhead
