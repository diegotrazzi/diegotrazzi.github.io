---
title: "Heap Based Priority Queue"
---

Heaps make priority queues efficient and simple to implement.

The main difference with Heap-only and Heap Priority Queue is abstraction:

* The first version is just a heap.
* The second version wraps the heap inside a `PriorityQueueImplementation`, which exposes clearer enqueue / dequeue methods.

## Big(O)

* Insertion (enqueue): $O(log n)$ – insert at end, heapify up
* Deletion (dequeue): $O(log n)$ – remove root, heapify down
* Peek: $O(1)$ – direct access to root
* Heapify (up/down): $O(log n)$ – traverse tree height
* Space complexity: $O(n)$ – one array element per item

## Implementation

```cpp
class HeapImplementation {
private:
    int* heap;
    int size;
    int capacity;

    void resize() {
        capacity *= 2;
        int* newHeap = new int[capacity];
        for (int i = 0; i < size; ++i) {
            newHeap[i] = heap[i];
        }
        delete[] heap;
        heap = newHeap;
    }

    void heapifyUp(int index) {
        while (hasParent(index) && parent(index) < heap[index]) {
            swap(getParentIndex(index), index);
            index = getParentIndex(index);
        }
    }

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

    bool hasParent(int i) { return getParentIndex(i) >= 0; }
    int parent(int i) { return heap[getParentIndex(i)]; }
    int getParentIndex(int i) { return (i - 1) / 2; }
    bool hasLeftChild(int i) { return getLeftChildIndex(i) < size; }
    bool hasRightChild(int i) { return getRightChildIndex(i) < size; }
    int leftChild(int i) { return heap[getLeftChildIndex(i)]; }
    int rightChild(int i) { return heap[getRightChildIndex(i)]; }
    int getLeftChildIndex(int i) { return 2 * i + 1; }
    int getRightChildIndex(int i) { return 2 * i + 2; }

    void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

public:
    HeapImplementation(int capacity) : size(0), capacity(capacity) {
        heap = new int[capacity];
    }

    void insert(int value) {
        if (size == capacity) {
            resize();
        }
        heap[size] = value;
        heapifyUp(size);
        size++;
    }

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

    void printHeap() {
        for (int i = 0; i < size; ++i) {
            std::cout << heap[i] << " ";
        }
        std::cout << std::endl;
    }
};

class PriorityQueueImplementation {
private:
    HeapImplementation heap;

public:
    PriorityQueueImplementation(int capacity) : heap(capacity) {}

    void enqueue(int item) {
        heap.insert(item);
    }

    int dequeue() {
        return heap.deleteRoot();
    }

    void printQueue() {
        heap.printHeap();
    }
};

int main() {
    PriorityQueueImplementation pq(10);
    pq.enqueue(30);
    pq.enqueue(20);
    pq.enqueue(50);
    pq.enqueue(15);
    pq.enqueue(10);
    pq.enqueue(5);
    pq.enqueue(7);

    std::cout << "Priority Queue after enqueues:" << std::endl;
    pq.printQueue();

    std::cout << "Dequeued item: " << pq.dequeue() << std::endl;

    std::cout << "Priority Queue after dequeue:" << std::endl;
    pq.printQueue();

    return 0;
}
```