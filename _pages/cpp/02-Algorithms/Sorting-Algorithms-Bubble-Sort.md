---
title: "Bubble Sort"
---

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Bubble-sort-example-300px.gif" height="150">
</div>

Bubble Sort is a simple comparison-based sorting algorithm that works by repeatedly swapping adjacent elements if they are in the wrong order. With each pass, the largest unsorted element "bubbles up" to its correct position.

## Steps

#### Step 1: Traverse and Compare
- Iterate through the array from start to end.
- For each pair of adjacent elements, compare them.

#### Step 2: Swap if Out of Order
- If the current element is greater than the next, swap them.
- Repeat the process for all elements except the last sorted ones.

#### Step 3: Optimize with Early Exit
- Use a flag to detect if any swaps were made during a pass.
- If no swaps occur, the array is already sorted—exit early.

#### Full Implementation
```cpp
class BubbleSort {
public:
    void sort(std::vector<int>& arr) {
        int n = arr.size();
        bool swapped;

        for (int i = 0; i < n - 1; ++i) {
            swapped = false;
            for (int j = 0; j < n - i - 1; ++j) {
                if (arr[j] > arr[j + 1]) {
                    std::swap(arr[j], arr[j + 1]);
                    swapped = true;
                }
            }
            if (!swapped)
                break;
        }
    }
};
```

## Bubble Sort - $O(n^2)$

Bubble Sort has quadratic time complexity in average and worst cases, making it inefficient for large datasets.

### Time Complexity
* Best Case (Already Sorted): $O(n)$
* Average Case: $O(n^2)$
* Worst Case: $O(n^2)$

### Space Complexity

Bubble Sort is an in-place algorithm with constant space complexity: $O(1)$.

### Stability

* Bubble Sort is stable, preserving the order of equal elements.

### Advantages
* Simple to Implement: Easy to understand and code.
* Stable Sort: Maintains the relative order of equal elements.
* Detects Sorted Input: Optimized version exits early if array is already sorted.

### Disadvantages
* Inefficient on Large Data: High time complexity makes it impractical for large arrays.
* Many Unnecessary Swaps: Compared to other algorithms, does more operations.

### Conclusion

Bubble Sort is best suited for small datasets or teaching purposes due to its simplicity and stable nature. For performance-critical applications, more efficient algorithms like Merge Sort or Quick Sort are preferred.