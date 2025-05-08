---
title: "Iterators"
---

C++ iterators are part of the Standard Template Library (STL) and are used similarly to pointers. The key operations they support are:

* `bool operator!=(const iterator&)`: Returns true if there are more elements in the iteration.
* `iterator& operator++()`: Advances the iterator to the next element.
* `T& operator*()`: Returns a reference to the current element in the iteration.
* `void erase(iterator position)`: Removes the element at the specified position (supported in some containers). **After the `erase` the iterator points to the next element.**

## Iterating over a list

```cpp
int main() {
    std::list<std::string> names = {"Alice", "Bob", "Charlie"};

    // auto == std::list<std::string>::iterator
    for (auto it = names.begin(); it != names.end(); it++) { 
        std::cout << *it << std::endl;
    }

    return 0;
}
```

## Erasing

`iterator erase(iterator pos);`
`iterator erase(iterator first, iterator last);`

> :point_right:  **`const auto&`** is useful when you don’t want to modify the original objects and avoid copying

```cpp
int main() {
    std::list<int> numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

    for (auto it = numbers.begin(); it != numbers.end(); it++) {
        if (*it % 2 != 0) {
            it = numbers.erase(it);
        }
    }

    for (const auto& number : numbers) {
        std::cout << number << " ";
    }

    return 0;
}
```

## Bidirectional Iterator

**`iterator& operator++();`**
**`iterator& operator--();`**

A bidirectional iterator supports both:

* `++` (move forward)
* `--` (move backward)

A basic (input or forward) iterator only supports moving forward (`++`).

> :bulb: Alternatevly, we can use the `std::advance(listIterator, n);` method to move bidirectionally through a list.

Exmaple of iterating in reverse direction:

```cpp
    std::cout << "Forward iteration:" << std::endl;
    for (auto it = names.begin(); it != names.end(); it++) {
        std::cout << *it << std::endl;
    }

    std::cout << "\nBackward iteration:" << std::endl;
    for (auto it = names.rbegin(); it != names.rend(); it++) {
        std::cout << *it << std::endl;
    }

    return 0;
```

## Dereferencing Operator 

**`T& operator*() const;`**

The dereference operator `*` is used to access the value that an iterator is pointing to in a container. When we dereference an iterator, we can modify the underlying object that the iterator is pointing to. The method signature for the dereference operator in an iterator is `T& operator*()`, which returns a reference to the current element in the collection, allowing modifications.

For example:

```cpp
int main() {
    std::list<std::string> names = {"alice", "Bob", "charlie"};
    for (auto it = names.begin(); it != names.end(); ++it) {
        char firstLetter = (*it)[0];
        if (std::islower(firstLetter)) {
            (*it)[0] = std::toupper(firstLetter); // Dereference and modify the element
        }
    }
    std::cout << "{ ";
    for (const auto& name : names) {
        std::cout << name << " ";
    }
    std::cout << "}" << std::endl;

    return 0;
}
```

## Instert Operator

**`iterator insert(const_iterator pos, const T& value);`**

The insert method is used to add elements to a container at a specified position. The insert method takes an iterator that points to the position after where the new element will be inserted. The element can be inserted as a single element, or a range of elements can be inserted. It returns an iterator that points to the newly inserted element (or the first element in case of a range insertion).

Example:

```cpp
#include <iostream>
#include <list>

int main() {
    std::list<int> numbers = {1, 3, 5};

    // Create an iterator
    auto it = numbers.begin();

    // Insert 2 between 1 and 3
    std::advance(it, 1); // Move iterator to the position of 3
    numbers.insert(it, 2); // Insert 2

    // Insert 4 between 3 and 5
    std::advance(it, 1); // Move iterator to the position of 5
    numbers.insert(it, 4); // Insert 4

    // Output the updated list
    std::cout << "{ ";
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << "}" << std::endl;

    return 0;
}
```

Output is `{ 1 2 3 4 5 }`

Explanation of Code:

* We first create a list of integers: {1, 3, 5}.
* We then create an iterator and move it using std::advance() to the correct position in the list.
* The insert method is used to add the elements 2 and 4 at the appropriate positions.
* Finally, we output the updated list, which is now { 1 2 3 4 5 }.

> :warning: The key points: In a std::list, **insert operations don't invalidate existing iterators.**

## Example: Implementing a Custom Iterator for a Singly Linked List

Another benefit to creating custom iterators in C++ is that you can use range-based for loops, which are more concise and easier to read than traditional loops.
So after implementing the iterator you can also call a for loop (see alternative main() below)

```cpp
class Node {
public:
    std::string data;
    Node* next;

    Node(const std::string& data) : data(data), next(nullptr) {}
};

class LinkedList {
    Node* head;

public:
    LinkedList() : head(nullptr) {}

    void add(const std::string& data) {
        Node* newNode = new Node(data);

        if (head == nullptr) {
            head = newNode;
        } else {
            Node* temp = head;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            temp->next = newNode;
        }
    }

    class Iterator {
        Node* currentNode;

    public:
        Iterator(Node* start) : currentNode(start) {}

        // Overloading != operator to compare two iterators
        bool operator!=(const Iterator& other) const {
            return currentNode != other.currentNode;
        }

        // Overloading ++ operator to advance the iterator
        Iterator& operator++() {
            if (currentNode != nullptr) {
                currentNode = currentNode->next;
            }
            return *this;
        }

        // Overloading * operator to dereference the iterator
        std::string& operator*() {
            return currentNode->data;
        }
    };

    // Returns an iterator pointing to the first element of the list
    Iterator begin() {
        return Iterator(head);
    }

    // Returns an iterator pointing to the past-the-end element (nullptr)
    Iterator end() {
        return Iterator(nullptr);
    }
};

int main() {
    LinkedList names;
    names.add("Alice");
    names.add("Bob");
    names.add("Charlie");

    for (auto it = names.begin(); it != names.end(); ++it) {
        std::cout << *it << std::endl;
    }

    return 0;
}
```

Alternative `main()`:

```cpp
int main() {
    LinkedList names;
    names.add("Alice");
    names.add("Bob");
    names.add("Charlie");

    for (const auto& name : names) {
        std::cout << name << std::endl;
    }

    return 0;
}
```

## Handling Concurrent Modifications and Multi-Threading with Iterators

When iterating over C++ collections, modifying the collection during iteration (concurrent modification) can cause undefined behavior, especially in multi-threaded environments where multiple threads access or modify shared data. To ensure thread safety, you should use synchronization tools like **mutexes** or thread-safe collections. The provided example uses a mutex and atomic flag to synchronize access, allowing threads to safely add and read data without conflicts or data corruption.

```cpp
int main() {
    std::vector<std::string> list;
    list.push_back("item1");
    std::mutex mtx;
    std::atomic<bool> done{false};  // Flag to signal when t1 is done

    // Thread 1: Add items to the vector
    std::thread t1([&list, &mtx, &done]() {
        for (int i = 0; i < 3; i++) {
            {
                std::lock_guard<std::mutex> lock(mtx);
                list.push_back("item" + std::to_string(i + 2));
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
        done = true;  // Signal that t1 is finished
    });

    // Thread 2: Print items from the vector
    std::thread t2([&list, &mtx, &done]() {
        while (!done) {  // Check if t1 is still running
            std::vector<std::string> current_items;
            {
                std::lock_guard<std::mutex> lock(mtx);
                current_items = list;  // Make a copy while holding the lock
            }
            
            // Process the copied items without holding the lock
            for (const auto& item : current_items) {
                std::cout << item << std::endl;
            }
            
            std::this_thread::sleep_for(std::chrono::milliseconds(50));
        }
        
        // One final check after t1 is done to ensure we get all items
        std::lock_guard<std::mutex> lock(mtx);
        for (const auto& item : list) {
            std::cout << item << std::endl;
        }
    });

    t1.join();
    t2.join();

    return 0;
}
```

On Apple Silicon devices we can use Apple's Grand Central Dispatch (GCD) to ensure thread safe operations.
For example: 

```cpp
#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <chrono>
#include <dispatch/dispatch.h> // GCD header

int main() {
    std::vector<std::string> list;
    list.push_back("item1");

    // Dispatch queue to handle synchronization
    dispatch_queue_t queue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);

    // Thread 1: Add items to the vector
    std::thread t1([&list, queue]() {
        for (int i = 0; i < 3; i++) {
            // Dispatch block to ensure thread-safe modification of vector
            dispatch_sync(queue, ^{
                list.push_back("item" + std::to_string(i + 2));
            });
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
    });

    // Thread 2: Print items from the vector
    std::thread t2([&list, queue]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(50));

        for (const auto& item : list) {
            // Dispatch block to ensure thread-safe access to vector for reading
            dispatch_sync(queue, ^{
                std::cout << item << std::endl;
            });
            std::this_thread::sleep_for(std::chrono::milliseconds(50));
        }
    });

    t1.join();
    t2.join();

    return 0;
}
```

Key Changes:

* GCD Queue: We use `dispatch_queue_t` queue to create a concurrent queue (`DISPATCH_QUEUE_CONCURRENT`). This queue will ensure thread-safe access and synchronization between the two threads.
* `dispatch_sync`: The dispatch_sync(queue, block) function is used to execute a block of code (modifying or reading from the vector) synchronously on the GCD queue. This prevents simultaneous access to the vector, thus ensuring thread safety.
