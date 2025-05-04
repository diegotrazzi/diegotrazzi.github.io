---
title: "Linear Search"
---

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/linear-search.gif" height="400">
</div>

Linear search is the simplest search algorithm. It checks each element of a list sequentially until the desired element is found or the list ends.

> It does not require the array to be sorted and works on any data structure that can be iterated.

## Steps

#### Step 1: Iterate

- Start from the first element.
- Compare each element with the target.

#### Step 2: Return Result

- If a match is found, return the index.
- If the loop ends with no match, return -1 (or a "not found" indicator).

## Full Implementation

```c++
int linearSearch(int arr[], int size, int target) {
    for (int i = 0; i < size; ++i) {
        if (arr[i] == target)
            return i;
    }
    return -1; // Not found
}
```

## Linear Search - $O(n)$

### Time Complexity

* Best Case: $O(1)$ (first element match)
- Average Case: $O(n)$
- Worst Case: $O(n)$

### Space Complexity

* $O(1)$ – Constant space; no extra memory used

## Stability

- Not applicable – searching, not sorting

### Advantages

* Simple to implement
- No need for sorted data
- Works on any iterable structure

### Disadvantages

* Inefficient for large datasets
- Linear time in the worst case

### Use Cases

* Small datasets
- Unsorted data
- When simplicity is preferred over performance

## REFERENCES

	• Linear Search visualizer
