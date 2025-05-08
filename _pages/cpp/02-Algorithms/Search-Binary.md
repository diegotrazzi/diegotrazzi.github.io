---
title: "Binary Search"
---

#### Binary Search

<div style="text-align: center">
  <img src="/images/cpp/02-Algorithms/Binary-search-work.gif" height="150">
</div>

Binary search is a fast search algorithm that works on **sorted arrays** by repeatedly dividing the search interval in half. It compares the target value to the middle element and eliminates half of the remaining elements each time.

It is significantly faster than linear search for large datasets, but requires the input to be sorted.

## Steps

#### Step 1: Initialization

- Set two pointers: `low = 0`, `high = size - 1`.

#### Step 2: Search Loop

- While `low <= high`:
  - Compute `mid = low + (high - low) / 2`.
  - If `array[mid] == target`, return `mid`.
  - If `target < array[mid]`, set `high = mid - 1`.
  - Else, set `low = mid + 1`.

#### Step 3: Not Found

- If the loop ends, return -1.

## Binary Search | For loop

```c++
int binarySearch(int arr[], int size, int target) {
    int low = 0, high = size - 1;

    while (low <= high) {
        int mid = low + (high - low) / 2;

        if (arr[mid] == target)
            return mid;
        else if (arr[mid] < target)
            low = mid + 1;
        else
            high = mid - 1;
    }

    return -1; // Not found
}
```

## Binary Search | Recursion

 The base case is when the array is empty (right < left) or when you have found the search target (target == array[mid]). In all other cases, we are going to recurse. However, we want to ignore the half of the list that we know cannot contain the search target. When you call binarySearch with left and mid - 1, you are ignoring the right half of the array. When you call the method with mid + 1 and right, you are ignoring the left half.

```c++
int binarySearch(int array[], int target, int left, int right) {
    if (right < left)
        return -1;

    int mid = left + (right - left) / 2;

    if (target == array[mid])
        return mid;
    else if (target < array[mid])
        return binarySearch(array, target, left, mid - 1);
    else
        return binarySearch(array, target, mid + 1, right);
}
```

## Binary Search - $O(\log_2 n)$

This approach is significantly faster than a linear search, especially for larger datasets. For a list with *n* elements, **Binary Search** can find an element in about $O(log_2(n))$ steps, whereas **linear search** would take, on average, $O(n/2)$ steps.

### Time Complexity

* Best Case: $O(1)$ (middle element match)
- Average/Worst Case: $O(\log n)$

### Space Complexity

* $O(1)$ for iterative version
- $O(\log n)$ for recursive version (due to call stack)

### Advantages

* Very fast on large, sorted datasets
- Simple and efficient

### Disadvantages

* Requires sorted input
- Harder to implement correctly than linear search
