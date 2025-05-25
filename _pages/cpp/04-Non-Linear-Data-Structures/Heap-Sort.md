---
title: "Heap Sort"
---

<div style="text-align: center;">
  <img src="/images/cpp/04-Non-Linear-Data-Structures/Max-Heap-new.png" alt="CLL" height="500">
</div>

> :bulb: **Any array can be interpreted as a complete binary tree, and that structural mapping is what makes the heap algorithm both elegant and efficient.**

**Heap sort** is efficient because it maintains the max-heap property, ensuring that the largest element is always at the root of the heap. This allows for **constant-time access to the maximum element and logarithmic-time removal and reordering using heapify-down operations**. The algorithm operates in two main phases: **heap construction + sorting**.

<div style="text-align: center;">
  <img src="/images/cpp/04-Non-Linear-Data-Structures/Heap-sorting.gif" alt="CLL" height="250">
</div>

**Heap construction builds** a max-heap from an unsorted array in $O(n)$ time using a bottom-up approach. This is done by applying heapify-down starting from the last non-leaf node up to the root. Once the heap is built, the sorting phase begins. In each iteration, the root element (maximum value) is swapped with the last element of the unsorted portion of the array. The heap size is then reduced by one, and the new root is heapified down to maintain the heap property.

This results in an in-place, comparison-based sort with $O(nlog_n)$ worst-case time complexity and **$O(1)$ space complexity** because heap sort does not require auxiliary storage and avoids performance degradation on specific input patterns, it is a robust and predictable algorithm for sorting large datasets.
