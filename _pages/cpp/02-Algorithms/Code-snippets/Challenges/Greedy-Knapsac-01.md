---
title: "Greedy | Knapsack Problem 01"
---

The basic idea of the greedy approach is to calculate the value per unit weight for each item, then choose items based on their value-to-weight ratio, starting with the item that has the highest ratio.

```c++
#include <iostream>
#include <algorithm>

// Define a class to represent items
class Item {
public:
    int weight;
    int value;

    // Constructor to initialize weight and value of an item
    Item(int weight = 0, int value = 0) : weight(weight), value(value) {}
};

class FractionalKnapsack {
private:
    // Method to sort items based on their value-to-weight ratio
    static bool compare(Item a, Item b) {
        return (double)a.value / a.weight > (double)b.value / b.weight;
    }

public:
double fractionalKnapsack(int W, Item arr[], int n) {
    // Sort items based on value-to-weight ratio
    std::sort(arr, arr + n, compare);

    double totalValue = 0;
    for (int i = 0; i < n; i++) {
        // Add item if it does not exceed capacity
        if (W - arr[i].weight >= 0) {
            W -= arr[i].weight;
            totalValue += arr[i].value;
        } else { // Else add a fraction of it
            double fraction = (double)W / arr[i].weight;
            totalValue += arr[i].value * fraction;
            W = 0;
            break;
        }
    }

    return totalValue; // Return total value of items in knapsack
 }

};

int main() {
    int W = 50;
    Item arr[] = {Item(10, 60), Item(20, 100), Item(30, 120)};
    int n = sizeof(arr) / sizeof(arr[0]);

    FractionalKnapsack knapsackSolver;
    std::cout << "Maximum value in knapsack = " << knapsackSolver.fractionalKnapsack(W, arr, n) << std::endl;

    return 0;
};```