---
title: "Tree-B"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-B.png" alt="B-Tree" height="150">
</div>

A B-tree is a self-balancing search tree optimized for systems that read and write large blocks of data, like databases and file systems. It maintains sorted data and allows searches, insertions, and deletions in logarithmic time.

* **Degree:** minimum number of **children** per node (except root)
* **Order:** maximum number of **children** per node. **$Order = 2 × degree (t)$**
* A non-leaf node with **$k$ children** contains **$k-1$ keys**.
* So, nodes have between degree and order children, and **$MaxKeys = (order−1)$**.

**All leaves are at the same level**, keeping the tree balanced.

Each internal node (except the root) has at least $⌈m⁄2⌉$ children. Keys within nodes are kept in sorted order, and child pointers separate key ranges to maintain the search property.

## B-Tree Node

```cpp
class BTreeNode {
public:
    std::vector<int> keys;              // Stored keys (sorted)
    std::vector<BTreeNode*> children;   // Child pointers
    bool leaf;                          // True if node is a leaf

    BTreeNode(bool isLeaf) : leaf(isLeaf) {}
};
```

## B-Tree Class

```cpp
class BTree {
private:
    BTreeNode* root;   // Pointer to the root node
    int degree;        // Minimum degree (t), minimum children per node except root
    int order;         // Maximum number of children per node = 2 * degree
    int maxKeys;       // Maximum number of keys per node = order - 1

public:
    BTree(int d) {
        degree = d;           // Set minimum degree (t)
        order = degree * 2;   // Max children per node = 2 * t
        maxKeys = order - 1;  // Max keys = max children - 1
        root = new BTreeNode(true);  // Start with an empty leaf root
    }

    void print();
};
```

## Print

```cpp
public:
  void print() {
      if (root == nullptr) {
          std::cout << "The tree is empty." << std::endl;
          return;
      }

      std::queue<BTreeNode*> q;
      q.push(root);

      while (!q.empty()) {
          int levelSize = q.size();

          for (int i = 0; i < levelSize; ++i) {
              BTreeNode* currentNode = q.front();
              q.pop();

              // Print keys in the current node
              for (int key : currentNode->keys) {
                  std::cout << key << " ";
              }
              std::cout << "| ";

              // Enqueue child nodes
              for (BTreeNode* child : currentNode->children) {
                  if (child != nullptr) {
                      q.push(child);
                  }
              }
          }

          std::cout << std::endl; // Move to the next level
      }
  }
```

## Insertion

B-Tree Insertion Summary:

* Start at the root and traverse to the correct **leaf.**
* If the leaf has space $(m-1)$, insert the key in sorted order.
* If full, insert and split the node:
  * Promote the **middle key to the parent**.
  * If the parent is full, split recursively.
  * If the root splits, create a new root with the promoted key.

This keeps the tree balanced, with all leaves at the same level.

### Insertion | Public

If `root` reaches `maxKeys` we Create a new root. Then, we attach the full old root (r) as its child.
Then we call splitChild(newRoot, 0) to: split r, promote its middle key to newRoot and make room for inserting the new key properly.

```cpp
public:
    void insert(int key) {
        BTreeNode* r = root;
        if (r->keys.size() == maxKeys) {
            BTreeNode* newRoot = new BTreeNode(false);
            root = newRoot;
            newRoot->children.push_back(r);
            splitChild(newRoot, 0); // Index 0 refers to the first child of newRoot
            insertNonFull(newRoot, key);
        } else {
            insertNonFull(r, key);
        }
    }
```

### Insertion | insertNonFull

Public `insert()` starts at the root and calls `insertNonFull()`, which recursively walks down the tree to insert the key at the proper leaf.

```cpp
private:
    void insertNonFull(BTreeNode* node, int key) {
        int i = node->keys.size() - 1;

        if (node->leaf) {
            // Find position to insert key in sorted order by moving backward
            while (i >= 0 && key < node->keys[i]) {
                i--;
            }
            // Insert key at correct position, shifting existing keys right
            node->keys.insert(node->keys.begin() + i + 1, key);

        } else {
            // Find child index to descend by moving backward through keys
            while (i >= 0 && key < node->keys[i]) {
                i--;
            }
            i++; // Move to child after found key position. If a node has k keys, it has k+1 children
            // If child is full, split it before inserting
            if (node->children[i]->keys.size() == maxKeys) {
                splitChild(node, i);
                // After split, decide correct child to descend into
                if (key > node->keys[i]) {
                    i++;
                }
            }
            // Recursive insert into child node that is guaranteed not full
            insertNonFull(node->children[i], key);
        }
    }
```

### Insertion | splitChild

`splitChild(parent, i)` splits `parent->children[i]` and promotes its middle key to the parent at index `i`. This method takes a B-Tree node and an index. This B-Tree node is the parent of the child that is to be split. Create the temporary node `fullChild`, which is the node that needs to be split since it is full. We also need a new child node that is empty. Add the new, empty child node to the children list in the parent node. Find the median node in the child that is full and add it to the keys list in the parent node.

```cpp
private:
    void splitChild(BTreeNode* parentNode, int i) {
        // full child that can't take another value
        BTreeNode* fullChild = parentNode->children[i];

        // new, empty child
        BTreeNode* newChild = new BTreeNode(fullChild->leaf);

        // add new child as a child to the parent
        parentNode->children.insert(parentNode->children.begin() + i + 1, newChild);

        // add median value from the full child to the parent
        parentNode->keys.insert(parentNode->keys.begin() + i, fullChild->keys[degree - 1]); // median key

        // new child gets the second half of the full child
        newChild->keys.insert(newChild->keys.end(), fullChild->keys.begin() + degree, fullChild->keys.end());

        // clear the second half of the full child
        fullChild->keys.erase(fullChild->keys.begin() + degree - 1, fullChild->keys.end());

        // if the child that was split is not a leaf update the children
        if (!fullChild->leaf) {
            newChild->children.insert(newChild->children.end(), fullChild->children.begin() + degree, fullChild->children.end());
            fullChild->children.erase(fullChild->children.begin() + degree, fullChild->children.end());
        }
    }
```

## Searcing

```cpp
public:
    bool search(int key) {
            return search(root, key);
        }
```

```cpp
private:
    bool search(BTreeNode* node, int key) {
        int left = 0;
        int right = node->keys.size() - 1;

        // Binary search within the current node's keys
        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (key == node->keys[mid]) {
                return true; // Key found in this node
            }

            if (key < node->keys[mid]) {
                right = mid - 1; // Search left half
            } else {
                left = mid + 1;  // Search right half
            }
        }

        // If not found, check if child exists to continue searching
        if (left < node->children.size()) {
            return search(node->children[left], key); // Search child at index 'left'
        }

        return false; // Key not found in the tree
    }
```

## References

* [B-Tree Visualizer](https://www.cs.usfca.edu/~galles/visualization/BTree.html)
