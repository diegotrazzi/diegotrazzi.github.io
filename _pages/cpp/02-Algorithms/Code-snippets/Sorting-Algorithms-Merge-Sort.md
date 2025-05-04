---
title: "Merge Sort Algorithm (With Recursion)"
---

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Merge-sort.gif" height="200">
</div>

## Steps

#### Step 1: Divide (Recursive Splitting)

The `sort` method divides the array:

- If `left < right`, compute the midpoint: `mid = (left + right) / 2`.
- Recursively call `sort` on the left half (`left` to `mid`) and right half (`mid + 1` to `right`).
- The array is split until each subarray has one element (base case: single elements are sorted).

#### Step 2: Conquer (Merging)

- Create two temporary arrays `leftArray` and `rightArray` to hold the subarrays.
- Compare elements from both arrays, picking the smaller one and placing it back into the original array `arr`.
- Copy any remaining elements from either array.
- Free the temporary arrays.

#### Full Implementation

```c++
class MergeSort {
private:
    // Merges two subarrays of arr[].
    // First subarray is arr[left..mid].
    // Second subarray is arr[mid+1..right].
    void merge(int arr[], int left, int mid, int right) {
        int n1 = mid - left + 1;
        int n2 = right - mid;

        // Create temporary arrays to store the two subarrays
        int* leftArray = new int[n1];
        int* rightArray = new int[n2];

        // Copy data to temporary arrays
        for (int i = 0; i < n1; ++i)
            leftArray[i] = arr[left + i];
        for (int j = 0; j < n2; ++j)
            rightArray[j] = arr[mid + 1 + j];

        // Merge the two temporary arrays back into arr[left..right]
        int i = 0, j = 0; // Initialize pointers for the two temporary arrays
        int k = left; // Initialize pointer for the merged array

        // Compare elements from leftArray and rightArray and put the smaller one into arr
        while (i < n1 && j < n2) {
            if (leftArray[i] <= rightArray[j]) {
                arr[k] = leftArray[i];
                i++;
            } else {
                arr[k] = rightArray[j];
                j++;
            }
            k++;
        }

        // Copy remaining elements from leftArray, if any
        while (i < n1) {
            arr[k] = leftArray[i];
            i++;
            k++;
        }

        // Copy remaining elements from rightArray, if any
        while (j < n2) {
            arr[k] = rightArray[j];
            j++;
            k++;
        }

        // Free memory allocated for temporary arrays
        delete[] leftArray;
        delete[] rightArray;
    }

public:
    // Main method that sorts arr[left..right] using merge()
    void sort(int arr[], int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2;
            // Sort the first half and the second half separately
            sort(arr, left, mid);
            sort(arr, mid + 1, right);

            // Merge the sorted halves
            merge(arr, left, mid, right);
        }
    }
};
```

## Merge Sort - $O(n \log_2 n)$

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Merge-sort-O.png" height="250">
</div>

Cost: $\mathcal{O}(n \log_2 n)$ because each sort is half of the previous

### Time Complexity

- **Best Case:** $O(n \log n)$
- **Average Case:** $O(n \log n)$
- **Worst Case:** $O(n \log n)$

### Space Complexity

Merge sort requires additional space for temporary arrays during the merge step, resulting in a space complexity of $O(n)$. This makes it less space-efficient compared to in-place sorting algorithms.

### Stability

Merge sort is **stable**, meaning it preserves the relative order of equal elements. This property is crucial in scenarios requiring multiple sorting criteria or when data integrity is important.

### Advantages

- **Consistent Performance:** Offers predictable performance regardless of initial data order.
- **Stability:** Maintains the order of equal elements.
- **Suitability for External Sorting:** Efficiently handles large datasets that don't fit into memory.

### Disadvantages

- **High Space Usage:** Additional space requirement can be a concern for large arrays.
- **Not Ideal for Small Datasets:** May be slower than simpler algorithms like insertion sort for small lists due to overhead.

### Conclusion

Merge sort is a reliable and stable sorting algorithm with consistent performance, making it a standard choice for many applications. However, users should consider the size of the dataset, available memory, and the need for stability when selecting a sorting algorithm.
