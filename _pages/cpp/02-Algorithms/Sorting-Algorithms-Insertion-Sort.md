---
title: "Insertion Sort"
---

Insertion Sort is a simple and intuitive sorting algorithm that builds the final sorted array one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort. However, it has several advantages, such as simplicity, efficiency on small data sets, and the ability to sort a list as it receives it.

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Insertion-sort-example-300px.gif" height="150">
</div>

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Insertion-sorting.png" height="150">
</div>

### How Insertion Sort Works

1. **Iterate through the array:** Start from the second element (index 1) and iterate through each element in the array.

2. **Select the current element:** Consider the current element as the key element that needs to be inserted into the sorted portion of the array.

3. **Compare and shift elements:** Compare the key element with the elements in the sorted portion of the array (to its left). Shift all elements that are greater than the key element one position to the right to make space for the key element.

4. **Insert the key element:** Insert the key element into its correct position in the sorted portion of the array.

5. **Repeat:** Continue this process for all elements in the array.

### Example

Initial array:
[23, 1, 10, 5, 2]

⸻

Step 1 (i = 1, key = 1)

Compare 23 > 1 → shift 23 right → insert 1

Result: [1, 23, 10, 5, 2]

⸻

Step 2 (i = 2, key = 10)

Compare 23 > 10 → shift 23 right
Compare 1 < 10 → stop → insert 10

Result: [1, 10, 23, 5, 2]

⸻

Step 3 (i = 3, key = 5)

Compare 23 > 5 → shift 23
Compare 10 > 5 → shift 10
Compare 1 < 5 → stop → insert 5

Result: [1, 5, 10, 23, 2]

⸻

Step 4 (i = 4, key = 2)

Compare 23 > 2 → shift 23
Compare 10 > 2 → shift 10
Compare 5 > 2 → shift 5
Compare 1 < 2 → stop → insert 2

Final result: [1, 2, 5, 10, 23]

```c++
void sort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i]; // key is the first value that need to be sorted {1}
        int j = i - 1; // J is the element on the left of the key {23}

        // Push every element on the left of the key where the element is > than key to the right of the key
        // Best case: this loop will never execute
        
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--; // jumps left (while loop)
        }
        arr[j + 1] = key; // restores the key to j + 1
    }
}
```

### Characteristics of Insertion Sort

- **Time Complexity:**
  - **Best Case:** $O(n)$ when the array is already sorted.
  - **Average and Worst Case:** $O(n^2)$ when the array is sorted in reverse order or randomly ordered.
  
- **Space Complexity:** $O(1)$ because it is an in-place sorting algorithm.

- **Stability:** Stable. It maintains the relative order of equal elements.

- **Efficiency:** Efficient for small data sets or arrays that are already partially sorted. It performs well on nearly sorted data.

### Conclusion

Insertion Sort is a straightforward and efficient algorithm for small data sets or arrays that are already partially sorted. Its simplicity and adaptive nature make it a popular choice for educational purposes and small-scale applications. However, for larger datasets, more efficient algorithms like quicksort or merge sort are preferred due to their better average and worst-case time complexities.