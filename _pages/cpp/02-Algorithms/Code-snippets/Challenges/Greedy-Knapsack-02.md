---
title: "Greedy | Knapsack Problem 02"
---

Create the struct `Item` that has the following members:
weight - a double that represents the weight of the item.
value - a double that represents the weight of the item.
Create the function maximizeValue that takes a vector of Item structs and a double representing the capacity of the knapsack. The function returns a double, representing the largest value that can be placed in the knapsack. Use the following type signature to help you write the function:

```c++
double maximizeValue(std::vector<Item> items, double capacity)
```

This is a fractional knapsack problem. Add as many items (including partial items) into the knapsack as you can.

To solve the fractional knapsack problem using a greedy approach, we need to maximize the total value of items that can fit into the knapsack. The key idea is to prioritize items based on their value-to-weight ratio, adding as much of each item as possible until the knapsack is full.

```c++
// FREEZE CODE BEGIN
#include <iostream>
#include <vector>
#include <algorithm>
// FREEZE CODE END

// Define the Item struct
struct Item {
    double weight;
    double value;

    Item(double w, double v) : weight(w), value(v) {}
};

// Function to calculate the maximum value that can be placed in the knapsack
double maximizeValue(std::vector<Item> items, double capacity) {
    // Sort items by value-to-weight ratio in descending order
    std::sort(items.begin(), items.end(), [](const Item& a, const Item& b) {
        return (a.value / a.weight) > (b.value / b.weight);
    });

    double totalValue = 0.0;
    double remainingCapacity = capacity;

    for (const auto& item : items) {
        if (remainingCapacity == 0) {
            break;
        }

        if (item.weight <= remainingCapacity) {
            // If the item can fit entirely, take it
            totalValue += item.value;
            remainingCapacity -= item.weight;
        } else {
            // Otherwise, take the fraction of the item that fits
            totalValue += item.value * (remainingCapacity / item.weight);
            remainingCapacity = 0;
        }
    }

    return totalValue;
}

// FREEZE CODE BEGIN
std::vector<Item> parseItems(char* argv[], int argc) {
    std::vector<Item> items;

    for (int i = 1; i < argc - 1; i += 2) {
        double weight = std::stod(argv[i]);
        double value = std::stod(argv[i + 1]);
        items.emplace_back(Item(weight, value));
    }

    return items;
}

int main(int argc, char* argv[]) {
    int testCase = std::stoi(argv[1]);
    std::vector<Item> items = parseItems(argv, argc);

    double result = maximizeValue(items, 50);
    std::cout << "Total value: " << result << std::endl;
    
    return 0;
}
// FREEZE CODE END
```