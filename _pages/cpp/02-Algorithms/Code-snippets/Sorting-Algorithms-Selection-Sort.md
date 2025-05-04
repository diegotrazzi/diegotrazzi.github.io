---
title: "Selection Sort"
---

Selection sort is a simple comparison-based sorting algorithm. It works by repeatedly selecting the smallest (or largest, depending on sorting order) element from the unsorted portion of the list and swapping it with the first unsorted element. Here's a step-by-step explanation of how selection sort works in C++:

<div style="text-align: center">
  <img src="/images/cpp/02-Algorithms/Selection-Sort-Animation.gif" height="350">
</div>

### Steps of Selection Sort:

1. **Initialize**: Start with the first element of the array as the current position.
2. **Find Minimum**: Scan the rest of the array to find the smallest element.
3. **Swap**: Swap the smallest found element with the element at the current position.
4. **Move to Next Position**: Move to the next position in the array.
5. **Repeat**: Repeat steps 2-4 until the entire array is sorted.

```cpp
#include <iostream>
#include <vector>

// Function to perform selection sort on a vector
void selectionSort(std::vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; ++i) {
        // Assume the minimum is the first element
        int minIndex = i;
        // Test against elements after i to find the smallest
        for (int j = i + 1; j < n; ++j) {
            // If this element is less, then it is the new minimum
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        // Swap the found minimum element with the first element
        std::swap(arr[minIndex], arr[i]);
    }
}

int main() {
    std::vector<int> arr = {64, 25, 12, 22, 11};

    std::cout << "Original array: ";
    for (int num : arr) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    selectionSort(arr);

    std::cout << "Sorted array: ";
    for (int num : arr) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    return 0;
}
```

### Explanation:

- **Outer Loop**: Iterates over each element of the array, treating it as the current position.
- **Inner Loop**: Searches for the smallest element in the unsorted portion of the array.
- **Swap**: Exchanges the smallest found element with the element at the current position.
- **Complexity**: Selection sort has a time complexity of $O(n^2)$ due to the nested loops, making it inefficient on large lists, but it has the advantage of being simple and having performance advantages over more complicated algorithms (like quicksort) in certain scenarios (e.g., when memory write is a costly operation).

This implementation sorts the array in ascending order. If you need to sort in descending order, you can simply modify the comparison condition in the inner loop.