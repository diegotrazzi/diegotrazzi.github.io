---
title: "Dynamic Array-Based Implementation (std::vector)"
---

- Fast random access $O(1)$.
- Less memory overhead than linked lists.
- Slower insertions and deletions $O(n)$ due to element shifting.
- Fixed-size arrays limit capacity; dynamic arrays incur resizing costs.

## List operations

### Subslits (using constructor)

```cpp
// New vector constructor, copying the range
std::vector<std::string> sub(v.begin(), v.begin() + 3);
```

### Sorting

```cpp
std::sort(v.begin(), v.end());
```

```cpp
// Reverse the vector in place 
std::reverse(v.begin(), v.end());
std::reverse(v.rbegin(), v.rend());
```

### Find

```cpp
auto it = std::find(v.begin(), v.end(), "Alice");
  if (it != v.end()) {
      std::cout << "Found at index: " << std::distance(v.begin(), it) << std::endl;
  }
```

### Erase

```cpp
v.erase(std::remove_if(v.begin(), v.end(),
    [](const std::string& s) { return s[0] == 'J'; }),
    v.end());
```

✅ erase → actually removes elements from the container. Is a member function of `std::list` (and `std::vector`).
✅ remove → reorders elements, moves unwanted ones to the end, does not shrink the container (needs erase to finalize). It’s a function in the `<algorithm>` header.
