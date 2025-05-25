---
title: "Heap"
---

<div style="text-align: center;">
  <img src="/images/cpp/04-Non-Linear-Data-Structures/Max-Heap-new.png" alt="CLL" height="500">
</div>

## Heap Summary

* A **heap** is a tree-based data structure that satisfies the **heap property**:
  * **Max-heap**: Every parent node is ≥ its children; root holds the maximum.
  * **Min-heap**: Every parent node is ≤ its children; root holds the minimum.

### Array representation (compact and efficient)

* Left child: `2 * i + 1`
* Right child: `2 * i + 2`
* Parent: `(i - 1) / 2` (floored)

## Heap Applications

* **Priority Queues:**
  * Max-heap: access highest priority element quickly.
  * Min-heap: access lowest priority element quickly.
* **Heap Sort:**
  * Build max-heap, repeatedly remove root to sort.
* **Kth Largest/Smallest Element**
  * Use a heap of size K to track top K elements.
* **Median Finding (Streaming Data)**
  * Use two heaps:
    * Max-heap for lower half
    * Min-heap for upper half
  * Balance sizes to find median efficiently.
* **Graph Algorithms**
  * Dijkstra’s: min-heap for shortest path.
  * Prim’s: min-heap for minimum spanning tree.

Heaps offer efficient solutions for priority-based access, sorting, selection, and real-time processing.

### Core operations

* **Insertion**: Add element at the end, bubble up to restore heap property.
* **Deletion**: Remove root, replace with last element, bubble down.
* **Heapify**: Transform a tree or array into a valid heap.

* **Use cases**: **Priority queues**, **Heap sort**, **Graph algorithms**.

### Heap Implementation

```cpp
class HeapImplementation {
private:
    int* heap;
    int size;
    int capacity;

public:
    HeapImplementation(int capacity) {
        heap = new int[capacity];
        this->capacity = capacity;
        size = 0;
    }
};
```

#### Insert

```cpp
    void insert(int value) {
        if (size == capacity) {
            resize();
        }
        heap[size] = value;
        heapifyUp();
        size++;
    }
```

##### Resize

```cpp
    void resize() {
        int* resizedHeap = new int[capacity * 2];
        for (int i = 0; i < capacity; i++) {
            resizedHeap[i] = heap[i];
        }
        delete[] heap;
        heap = resizedHeap;
        capacity *= 2;
    }
```

##### Heapify-Up

```cpp
    void heapifyUp() {
        int index = size;
        while (hasParent(index) && parent(index) < heap[index]) {
            swap(getParentIndex(index), index);
            index = getParentIndex(index);
        }
    }

    bool hasParent(int i) { return getParentIndex(i) >= 0; }
    int parent(int i) { return heap[getParentIndex(i)]; }
    int getParentIndex(int i) { return (i - 1) / 2; }

    void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }
```

#### Delete

```cpp
    int deleteRoot() {
        if (size == 0) {
            throw std::logic_error("Heap is empty");
        }

        int root = heap[0];
        heap[0] = heap[size - 1];
        size--;

        heapifyDown();

        return root;
    }
```

##### Heapify-Down

```cpp
    void heapifyDown() {
        int index = 0;
        while (hasLeftChild(index)) {
            int largerChildIndex = getLeftChildIndex(index);
            if (hasRightChild(index) && rightChild(index) > leftChild(index)) {
                largerChildIndex = getRightChildIndex(index);
            }

            if (heap[index] < heap[largerChildIndex]) {
                swap(index, largerChildIndex);
            } else {
                break;
            }

            index = largerChildIndex;
        }
    }

    bool hasLeftChild(int i) { return getLeftChildIndex(i) < size; }
    bool hasRightChild(int i) { return getRightChildIndex(i) < size; }
    int leftChild(int i) { return heap[getLeftChildIndex(i)]; }
    int rightChild(int i) { return heap[getRightChildIndex(i)]; }
    int getLeftChildIndex(int i) { return 2 * i + 1; }
    int getRightChildIndex(int i) { return 2 * i + 2; }
```

#### Search

```cpp
    bool search(int value) {
        for (int i = 0; i < size; i++) {
            if (heap[i] == value) {
                return true;
            }
        }
        return false;
    }
```

#### Print

```cpp
    void printHeap() {
        for (int i = 0; i < size; i++) {
            std::cout << heap[i] << " ";
        }
        std::cout << std::endl;
    }
```
