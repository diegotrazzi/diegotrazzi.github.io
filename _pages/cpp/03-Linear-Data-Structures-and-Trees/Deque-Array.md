---
title: "Deque Array"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Deque.webp" alt="CLL" height="150">
</div>

A **deque (double-ended queue)** allows adding/removing elements at both ends, combining stack and queue behavior. It can be implemented with arrays, linked lists, or hybrids.

Core operations:

* **addFront, addRear**
* **removeFront, removeRear**
* **peekFront, peekRear**
* **isEmpty, size**

Use cases: Flexible data handling, e.g., **sliding windows**, **palindrome checks**.

## Representing a Circular Deque with an Array

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Deque-Array-Circular.svg" alt="CLL" height="250">
</div>

An array-based deque uses a circular array for **constant-time** element access and supports adding/removing from both ends by **wrapping pointers with modulo**.

```cpp
class ArrayDeque {
private:
    int capacity;
    int size;
    int front;
    int rear;
    int* dequeArray;

public:
    // Constructor
    ArrayDeque(int c) {
        capacity = c;
        size = 0;
        front = 0;
        rear = -1;
        dequeArray = new int[capacity];
    }

    // Add element to the front
    void addFront(int value) {
        if (isFull()) {
            throw std::overflow_error("Deque is full");
        }

        // Using substraction we also add capacity because % needs to wrap around the array
        front = (front - 1 + capacity) % capacity;
        dequeArray[front] = value;
        size++;
    }

    // Add element to the rear
    void addRear(int value) {
        if (isFull()) {
            throw std::overflow_error("Deque is full");
        }

        rear = (rear + 1) % capacity;
        dequeArray[rear] = value;
        size++;
    }
    
    // Remove element from the front
    int removeFront() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        int temp = dequeArray[front];
        front = (front + 1) % capacity;
        size--;
        return temp;
    }
    
    // Remove element from the rear
    int removeRear() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        int temp = dequeArray[rear];
        rear = (rear - 1) % capacity;
        size--;
        return temp;
    }

    // Peek at the front element
    int peekFront() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        return dequeArray[front];
    }

    // Peek at the rear element
    int peekRear() {
        if (isEmpty()) {
            throw std::underflow_error("Deque is empty");
        }

        return dequeArray[rear];
    }  

    // Check if the deque is empty
    bool isEmpty() {
        return (size == 0);
    }

    bool isFull() {
        return (size == capacity);
    }

    int getSize() {
        return size;
    }

    // Destructor
    ~ArrayDeque() {
        delete[] dequeArray;
    }
};
```

Main method:

```cpp
int main() {
    ArrayDeque myDeque(5);

    myDeque.addFront(1);
    myDeque.addFront(2);
    std::cout << "Front element: " << myDeque.peekFront() << std::endl;

    myDeque.addRear(3);
    myDeque.addRear(4);
    std::cout << "Rear element: " << myDeque.peekRear() << std::endl;

    std::cout << "Removed from front: " << myDeque.removeFront() << std::endl;
    std::cout << "Removed from rear: " << myDeque.removeRear() << std::endl;

    std::cout << "Is deque empty? " << (myDeque.isEmpty() ? "true" : "false") << std::endl;
    std::cout << "Size of deque: " << myDeque.getSize() << std::endl;

    return 0;
}
```
