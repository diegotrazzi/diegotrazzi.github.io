---
title: "Heap DEPQ"
---

## Structure and Design

The **DoubleEndedPriorityQueue** maintains two separate heaps: a max-heap and a min-heap. The max-heap is used to quickly find and remove the maximum element, while the min-heap is used for the minimum element.

## Insertion

When add(int element) is called, the value is inserted into both the max-heap and the min-heap. This ensures both heaps always contain the same elements.

## Deletion

To remove the maximum (removeMax), the root of the max-heap is removed $O(log n)$, and the same value is then removed from the min-heap by scanning for it linearly $O(n)$. The reverse happens in removeMin.

## Synchronization

The remove operations ensure that both heaps remain synchronized by deleting the same value from both.

## Performance Consideration

Accessing min and max is efficient $O(1)$ for access, $O(log n)$ for deletion, but the linear scan in the opposite heap during deletion introduces inefficiency $O(n)$. More optimal structures like interval heaps can avoid this cost.

### Implementation

```cpp
// Base HeapImplementation class
class HeapImplementation {
protected:
    int* heap;
    int size;
    int capacity;

public:
    HeapImplementation(int capacity) : size(0), capacity(capacity) {
        heap = new int[capacity];
    }

protected:
    void resize() {
        capacity *= 2;
        int* resizedHeap = new int[capacity];
        for (int i = 0; i < size; i++) {
            resizedHeap[i] = heap[i];
        }
        delete[] heap;
        heap = resizedHeap;
    }

public:
    void insert(int value) {
        if (size == capacity) {
            resize();
        }
        heap[size] = value;
        heapifyUp();
        size++;
    }

    virtual void heapifyUp() {
        int index = size;
        while (hasParent(index) && parent(index) < heap[index]) {
            swap(getParentIndex(index), index);
            index = getParentIndex(index);
        }
    }

public:
    int deleteRoot() {
        if (size == 0) {
            throw std::out_of_range("Heap is empty");
        }
        int root = heap[0];
        heap[0] = heap[size - 1];
        size--;
        heapifyDown();
        return root;
    }

    virtual void heapifyDown() {
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

    void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

    bool hasParent(int i) { return getParentIndex(i) >= 0; }
    int parent(int i) { return heap[getParentIndex(i)]; }
    int getParentIndex(int i) { return (i - 1) / 2; }
    bool hasLeftChild(int i) { return getLeftChildIndex(i) < size; }
    bool hasRightChild(int i) { return getRightChildIndex(i) < size; }
    int leftChild(int i) { return heap[getLeftChildIndex(i)]; }
    int rightChild(int i) { return heap[getRightChildIndex(i)]; }
    int getLeftChildIndex(int i) { return 2 * i + 1; }
    int getRightChildIndex(int i) { return 2 * i + 2; }

public:
    bool remove(int element) {
        for (int i = 0; i < size; i++) {
            if (heap[i] == element) {
                swap(i, size - 1);
                size--;
                heapifyDown();
                return true;
            }
        }
        return false;
    }

    void printHeap() {
        for (int i = 0; i < size; i++) {
            std::cout << heap[i] << " ";
        }
        std::cout << std::endl;
    }
};

// MaxHeap class
class MaxHeap : public HeapImplementation {
public:
    MaxHeap(int capacity) : HeapImplementation(capacity) {}

    void heapifyUp() override {
        HeapImplementation::heapifyUp(); // optional but explicit
    }

    void heapifyDown() override {
        HeapImplementation::heapifyDown(); // optional but explicit
    }
};

// MinHeap class
class MinHeap : public HeapImplementation {
public:
    MinHeap(int capacity) : HeapImplementation(capacity) {}

    void heapifyUp() override {
        int index = size;
        while (hasParent(index) && parent(index) > heap[index]) {
            swap(getParentIndex(index), index);
            index = getParentIndex(index);
        }
    }

    void heapifyDown() override {
        int index = 0;
        while (hasLeftChild(index)) {
            int smallerChildIndex = getLeftChildIndex(index);
            if (hasRightChild(index) && rightChild(index) < leftChild(index)) {
                smallerChildIndex = getRightChildIndex(index);
            }
            if (heap[index] > heap[smallerChildIndex]) {
                swap(index, smallerChildIndex);
            } else {
                break;
            }
            index = smallerChildIndex;
        }
    }
};

// DoubleEndedPriorityQueue class
class DoubleEndedPriorityQueue {
private:
    MaxHeap maxHeap;
    MinHeap minHeap;

public:
    DoubleEndedPriorityQueue(int capacity) : maxHeap(capacity), minHeap(capacity) {}

    void add(int element) {
        maxHeap.insert(element);
        minHeap.insert(element);
    }

    int removeMax() {
        int max = maxHeap.deleteRoot();
        minHeap.remove(max);
        return max;
    }

    int removeMin() {
        int min = minHeap.deleteRoot();
        maxHeap.remove(min);
        return min;
    }

    void printHeaps() {
        std::cout << "MaxHeap: ";
        maxHeap.printHeap();
        std::cout << "MinHeap: ";
        minHeap.printHeap();
    }
};

int main() {
    DoubleEndedPriorityQueue depq(10);
    depq.add(30);
    depq.add(20);
    depq.add(50);
    depq.add(15);
    depq.add(10);

    std::cout << "Added elements: 30, 20, 50, 15, 10" << std::endl;
    std::cout << "Max Element Removed: " << depq.removeMax() << std::endl;
    std::cout << "Min Element Removed: " << depq.removeMin() << std::endl;

    std::cout << "Remaining elements in MaxHeap:" << std::endl;
    depq.printHeaps();

    return 0;
}
```
