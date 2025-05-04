# Sorting Even and Odd

You are tasked to find a number in an array. You know the person that hid the number has a preference for odd numbers. Meaning they are more likely to hide the number at an odd index. In this search algorithm, you should first check all odd indices for the search target, and, if not found, then check all even indices. Basically, we are cutting down our search radius by half.
> Create the method `evenOrOdd` that takes an unsorted array of integers and a target (also an integer). The method should return an integer representing the index of the target in the array. If the target is not found, return -1.

```c++
// FREEZE CODE BEGIN
#include <iostream>
// FREEZE CODE END

// Pass the array and its size
int evenOrOdd(int unsortedArray[], int size, int target) {
    for (int i = 1; i < size; i+=2) { // Odds
        if (unsortedArray[i] == target) {
            return i;
          }
        }

        for (int i = 0; i < size; i+=2) { // EVENs
          if (unsortedArray[i] == target) {
            return i;
          }
        }

        return -1; // Placeholder
}

// FREEZE CODE BEGIN
int main(int argc, char *argv[]) {
    if (argc < 2) {
        std::cout << "Usage: ./program <target>" << std::endl;
        return 1;
    }

    int target;
    std::sscanf(argv[1], "%d", &target);

    int arr[] = {20, -45, 7, 3325, -1};
    int size = sizeof(arr) / sizeof(arr[0]);
    int result = evenOrOdd(arr, size, target);

    if (result != -1) {  
        std::cout << "The target " << target << " was found at index: " << result << std::endl;
    } else {
        std::cout << "The target " << target << " was not found in the array." << std::endl;
    }

    return 0;
}
// FREEZE CODE END

```