---
title: "Quick Sort"
---

<div style="text-align: center;">
  <img src="/images/cpp/02-Algorithms/Quicksort-example.gif" height="150">
</div>

Quick sort is based on the divide-and-conquer approach based on the idea of choosing one element as a pivot element and partitioning the array around it such that: Left side of pivot contains all the elements that are less than the pivot element Right side contains all elements greater than the pivot

It reduces the space complexity and removes the use of the auxiliary array that is used in merge sort. Selecting a random pivot in an array results in an improved time complexity in most of the cases.

## Steps

#### Step 1: Partitioning

- Choose a pivot element from the array.
- Rearrange the array such that elements less than the pivot are on the left, and elements greater than the pivot are on the right.
- The pivot is now in its final position.

#### Step 2: Recursive Sorting

- Recursively apply the above steps to the subarrays of elements with smaller and larger values.

#### Full Implementation | Lomuto's Partitioning

```c++
class QuickSort {
private:
    // Partition function to place pivot in correct position
    int partition(int arr[], int low, int high) {
        int pivot = arr[high]; // Choosing the last element as pivot
        int i = low - 1; // Index of smaller element

        for (int j = low; j <= high - 1; j++) {
            // If current element is smaller than or equal to pivot
            if (arr[j] <= pivot) {
                i++; // Increment index of smaller element
                std::swap(arr[i], arr[j]); // Swap elements
            }
        }
        std::swap(arr[i + 1], arr[high]); // Swap pivot with element at i+1
        return i + 1;
    }

public:
    // Main method that sorts arr[low..high] using quickSort()
    void sort(int arr[], int low, int high) {
        if (low < high) {
            // pi is partitioning index, arr[pi] is now at right place
            int pi = partition(arr, low, high);

            // Recursively sort elements before partition and after partition
            sort(arr, low, pi - 1);
            sort(arr, pi + 1, high);
        }
    }
};
```

#### Hoare Partition Scheme

There are two common partitioning schemes used in QuickSort: **Lomuto** and **Hoare**. The Lomuto scheme (used in most simple implementations) uses a single pointer and typically chooses the last element as the pivot. It is easy to implement but can result in more swaps. The Hoare scheme, on the other hand, uses two pointers that start at both ends of the array and move toward each other. It usually selects the first element as the pivot and performs fewer swaps, making it more efficient in practice. However, Hoare’s partition does not necessarily place the pivot in its final position immediately, so recursive calls must be handled carefully.

```cpp
int hoarePartition(int arr[], int low, int high) {
    int pivot = arr[low];
    int i = low - 1;
    int j = high + 1;

    while (true) {
        do {
            i++;
        } while (arr[i] < pivot);

        do {
            j--;
        } while (arr[j] > pivot);

        if (i >= j)
            return j;

        std::swap(arr[i], arr[j]);
    }
}
```

## Quick Sort - $O(n \log_2 n)$

Cost: $\mathcal{O}(n \log_2 n)$ on average, but can degrade to $\mathcal{O}(n^2)$ in the worst case (e.g., when the smallest or largest element is always chosen as the pivot).

### Time Complexity

- **Best Case:** $O(n \log n)$
- **Average Case:** $O(n \log n)$
- **Worst Case:** $O(n^2)$ (can be mitigated with good pivot selection strategies)

### Space Complexity

Quick sort is an in-place sorting algorithm, resulting in a space complexity of $O(\log n)$ due to the recursion stack.

### Stability

Quick sort is **not stable**, meaning it does not necessarily preserve the relative order of equal elements.

### Advantages

- **In-Place Sorting:** Requires minimal additional space.
- **Efficient for Large Datasets:** Generally faster than merge sort for large arrays.

### Disadvantages

- **Unstable Sort:** Does not preserve the order of equal elements.
- **Poor Performance on Sorted Data:** Can degrade to $O(n^2)$ if not implemented with good pivot strategies.

### Importance of the pivot

The choice of pivot in QuickSort significantly impacts performance. A poor pivot can lead to unbalanced partitions and degrade time complexity. Common pivot selection strategies include picking the last element, a random index (to avoid worst-case scenarios), the first element, or using the **median-of-three** method (choosing the median of the first, middle, and last elements) for better balance. Each strategy modifies the partition logic slightly to place the chosen pivot in its correct position efficiently.

### Conclusion

Quick sort is a fast and efficient in-place sorting algorithm with average-case performance of $O(n \log n)$. However, users should be cautious of its worst-case performance and consider using strategies like randomizing pivot selection to mitigate this risk.

## REFERENCES

- [Quick Sort visualizer](https://youtu.be/WprjBK0p6rw?si=Ty9uai-cyNh2J9mx)
