---
title: "Tree-B"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-B.png" alt="B-Tree" height="150">
</div>

Each Child $Ci$ **holds values between $Ki-1$ and $Ki$**.

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

## Searching

Summary:

1. Start at the root and perform binary search on the keys in the node.
2. If the key is found, return true:
   1. If not found and the node is a leaf, return false.
   2. If not a leaf, recurse into the appropriate child, based on where the key would fit.

### Searching | Public

```cpp
public:
    bool search(int key) {
            return search(root, key);
        }
```

### Searching | Private

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

## Deletion

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-B-Delete.webp" alt="B-Tree" height="600">
</div>

The deleteNode method deletes key `k` from a B-tree starting at node:

1. **Locating the key** by traversing from the root.
2. **Deleting from a leaf**: Remove the key if the node has enough keys.
3. **Deleting from an internal node**: Replace the key with its **in-order predecessor or successor**, then delete that key.
4. **Handling underflow**: If a node falls below the minimum keys, fix by:
   1. Merging: Combine with a sibling and pull down a parent key.
   2. Borrowing: Take a key from a sibling and adjust the parent.

> :bulb: NOTE: **In a leaf, the minimum number of keys is degree - 1**, not the number of children, since leaf nodes have no children. This ensures leaves can safely lose one key if they start with at least 'degree' keys.

### Deletion | Main Delete | Public

```cpp
public:
    void deleteKey(int key) {
        deleteNode(root, key);
    }
```

### Deletion | Main Delete | Private

```cpp
private:
    void deleteNode(BTreeNode* node, int k) {
        // Find the index i where key k should be or is located
        int i = findKey(node, k);

        // If node is a leaf
        if (node->leaf) {
            // If key k is found at index i, remove it
            if (i < node->keys.size() && node->keys[i] == k) {
                node->keys.erase(node->keys.begin() + i);
                // should also call shrink_to_fit() for memory performance
            }
            return; // Finished deletion in leaf
        }

        // If node is internal and key k is at index i
        if (i < node->keys.size() && node->keys[i] == k) {
            // Handle deletion inside internal node
            deleteInternalNode(node, k, i);
        } else {
            // Key k not found in current node; check child at index i
            // If child has fewer keys than degree, fix underflow
            if (node->children[i]->keys.size() < degree) {
                handleUnderflow(node, i);
                // Update i if underflow handling changed children
                if (i >= node->children.size()) {
                    i = node->children.size() - 1;
                }
            }
            // Recursively delete key k in child node at updated index i
            deleteNode(node->children[i], k);
        }
    }
```

### Deletion | Helper Methods | deletePredecessor

Deletes the largest key in the subtree rooted at the given node. If internal, ensures the rightmost child has enough keys or merges before recursing.

If the node is not a leaf, deleting the predecessor involves:

1. Identifying the left child of the key’s position.
2. Recursing into the rightmost child path of that subtree to find the largest key (i.e., the predecessor).
3. Before recursing, ensure the child has at least degree keys:
   1. If it has enough, call **deleteSibling** to balance.
   2. If not, call **deleteMerge** to merge with a sibling.

Each recursion step maintains B-Tree properties by ensuring the subtree has enough keys to delete from.

```cpp
private:
    // Deletes and returns the predecessor key (largest in left subtree)
    int deletePredecessor(BTreeNode* node) {
        // Base case: if leaf, just remove and return the last key
        if (node->leaf) {
            int lastKey = node->keys.back();
            node->keys.pop_back();
            return lastKey;
        }

        // Recurse into the rightmost child to find the predecessor (case 2a)
        // We use n as the left ponter of the node to delete!
        int n = node->keys.size() - 1;

        // Ensure the child has enough keys before recursion
        if (node->children[n]->keys.size() >= degree) {
            deleteSibling(node, n + 1, n); // Balance with right sibling if needed
        } else {
            deleteMerge(node, n, n + 1);   // Merge if underflow would occur
        }

        // Continue recursion
        return deletePredecessor(node->children[n]);
    }
```

### Deletion | Helper Methods | deleteSuccessor

This method deletes the successor key, which is the smallest key in the right subtree. Here’s what it does:

* If node is a leaf: Remove and return the first key (smallest key in this node).
* If node is internal:
  * The successor lives in the leftmost path of the right child.
  * Ensure children[0] (left child of successor’s parent) has enough keys:
    * If children[1] (right sibling) has enough, call deleteSibling(0, 1).
    * Else, deleteMerge(0, 1) to combine siblings.
  * Then recurse into children[0] to find and delete the actual successor.

💡 This is typically used after swapping a key in an internal node with its successor, to remove that key from the leaf.

```cpp
private:
    int deleteSuccessor(BTreeNode* node) {
        if (node->leaf) {
            int firstKey = node->keys.front();
            node->keys.erase(node->keys.begin());
            return firstKey;
        }
        if (node->children[1]->keys.size() >= degree) {
            deleteSibling(node, 0, 1);
        } else {
            deleteMerge(node, 0, 1);
        }
        return deleteSuccessor(node->children[0]);
    }
```

### Deletion | Helper Methods | deleteInternalNode

Deletes a key from an internal node. Uses predecessor or successor if possible; otherwise merges children and recurses.

* Leaf case: If the node is a leaf and contains the key k at index i, simply erase it.
* Internal node case. We need to replace it with a valid key from children while maintaining B-tree rules:
  * Left child has enough keys → Replace the key with its predecessor using deletePredecessor.
  * Right child has enough keys → Replace the key with its successor using deleteSuccessor.
  * Neither has enough keys → Merge the children, then recursively delete in the merged node.

This ensures the tree stays balanced and all nodes maintain minimum key constraints.

```cpp
private:
    void deleteInternalNode(BTreeNode* node, int k, int i) {
        if (node->leaf) {
            if (node->keys[i] == k) {
                node->keys.erase(node->keys.begin() + i);
            }
            return;
        }
        if (node->children[i]->keys.size() >= degree) {
            node->keys[i] = deletePredecessor(node->children[i]);
            return;
        } else if (node->children[i + 1]->keys.size() >= degree) {
            node->keys[i] = deleteSuccessor(node->children[i + 1]);
            return;
        } else {
            deleteMerge(node, i, i + 1);
            deleteInternalNode(node->children[i], k, degree - 1);
        }
    }
```

### Deletion | Helper Methods | deleteSibling

This method borrows a key from a sibling to fix an underflow in the child node cnode at index i.

* If i < j (borrow from right sibling):
  * Move the parent’s key at i down to cnode.
  * Replace that parent’s key with the first key of the right sibling (rsnode).
  * Move the leftmost child of rsnode to cnode if exists.
  * Remove that first key and child from rsnode.
* Else (borrow from left sibling):
  * Move the parent’s key at i-1 down to the front of cnode’s keys.
  * Replace that parent’s key with the last key of the left sibling (lsnode).
  * Move the rightmost child of lsnode to the front of cnode’s children if exists.
  * Remove that last key and child from lsnode.

Here’s a simple example to illustrate how deleteSibling works when borrowing from a sibling. B-Tree of degree 3 (max 5 keys, min 2). Initial structure:

```ascii
        [30]
       /    \
   [10,20]  [40,50,60]
```

Now suppose we delete 20 from the left child [10,20], leaving it with only one key [10]. This is below the minimum (which is 2), so we must fix the underflow.

We call:

deleteSibling(parent, i = 0, j = 1);  // Left child (index 0) borrows from right sibling (index 1)

⸻

What happens:
 • cnode = children[0] = [10]
 • rsnode = children[1] = [40,50,60]
 • Parent key at index 0 is 30

Now we do:
 1. Move 30 from parent to end of cnode: [10, 30]
 2. Replace parent key 30 with 40 from right sibling
 3. Remove 40 from rsnode

After operation:

```ascii
        [40]
       /    \
 [10,30]  [50,60]
```

✅ Underflow fixed by borrowing from right sibling.

```cpp
private:
void deleteSibling(BTreeNode* node, int i, int j) {
    
    // i is the index of the child needing balancing (underflowing).
    // j is the index of the sibling used to balance it (either left or right).
    
    BTreeNode* cnode = node->children[i];  // Current node - Underflowing child needing keys

    if (i < j) {  // Borrow from right sibling
        BTreeNode* rsnode = node->children[j];  // Right sibling with extra keys

        // Move parent's key[i] down to cnode keys (append at end)
        cnode->keys.push_back(node->keys[i]);

        // Replace parent's key[i] with first key from right sibling
        node->keys[i] = rsnode->keys.front();

        // If right sibling has children, move its leftmost child to cnode
        if (!rsnode->children.empty()) {
            cnode->children.push_back(rsnode->children.front());
            rsnode->children.erase(rsnode->children.begin());
        }

        // Remove the first key from right sibling (moved up to parent)
        rsnode->keys.erase(rsnode->keys.begin());

    } else {  // Borrow from left sibling
        BTreeNode* lsnode = node->children[j];  // Left sibling with extra keys

        // Move parent's key[i-1] down to cnode keys (insert at front)
        cnode->keys.insert(cnode->keys.begin(), node->keys[i - 1]);

        // Replace parent's key[i-1] with last key from left sibling
        node->keys[i - 1] = lsnode->keys.back();

        // Remove last key from left sibling (moved up to parent)
        lsnode->keys.pop_back();

        // If left sibling has children, move its rightmost child to cnode front
        if (!lsnode->children.empty()) {
            cnode->children.insert(cnode->children.begin(), lsnode->children.back());
            lsnode->children.pop_back();
        }
    }
}
```

### Deletion | Helper Methods | deleteMerge

Merges two child nodes (i and j) when one has too few keys after deletion.

* If merging with the right sibling (j > i):
  * Move key[i] from parent down into child[i].
  * Append all keys and children from child[j] to child[i].
  * Remove key[i] and child[j] from parent.
* If merging with the left sibling (j < i):
  * Move key[j] from parent down into child[j].
  * Append all keys and children from child[i] to child[j].
  * Remove key[j] and child[i] from parent.
  * If parent becomes empty and is root, promote merged child as new root.

```cpp
private:
    void deleteMerge(BTreeNode* node, int i, int j) {
        BTreeNode* cnode = node->children[i];  // Child at index i (left child in merge)
        BTreeNode* newNode;

        if (j > i) {
            // Merge with right sibling
            BTreeNode* rsnode = node->children[j];  // Right sibling

            // Move parent's key[i] down to cnode keys
            cnode->keys.push_back(node->keys[i]);

            // Append all keys from right sibling to cnode
            for (int k = 0; k < rsnode->keys.size(); ++k) {
                cnode->keys.push_back(rsnode->keys[k]);

                // If right sibling has children, append corresponding child
                if (!rsnode->children.empty()) {
                    cnode->children.push_back(rsnode->children[k]);
                }
            }

            // Append last child of right sibling if exists
            if (!rsnode->children.empty()) {
                cnode->children.push_back(rsnode->children.back());
                rsnode->children.pop_back();
            }

            newNode = cnode;

            // Remove parent's key and right sibling after merge
            node->keys.erase(node->keys.begin() + i);
            node->children.erase(node->children.begin() + j);

        } else {
            // Merge with left sibling
            BTreeNode* lsnode = node->children[j];  // Left sibling

            // Move parent's key[j] down to left sibling keys
            lsnode->keys.push_back(node->keys[j]);

            // Append all keys from cnode to left sibling
            for (int k = 0; k < cnode->keys.size(); ++k) {
                lsnode->keys.push_back(cnode->keys[k]);

                // If cnode has children, append corresponding child
                if (!cnode->children.empty()) {
                    lsnode->children.push_back(cnode->children[k]);
                }
            }

            // Append last child of cnode if exists
            if (!cnode->children.empty()) {
                lsnode->children.push_back(cnode->children.back());
                cnode->children.pop_back();
            }

            newNode = lsnode;

            // Remove parent's key and cnode after merge
            node->keys.erase(node->keys.begin() + j);
            node->children.erase(node->children.begin() + i);
        }

        // If the root is empty after merge, update root pointer
        if (node == root && node->keys.empty()) {
            root = newNode;
        }
    }
```

### Deletion | Helper Methods | findKey

The findKey method returns the index of the first key in the node that is not less than the given key k. If the key exists, the index points to it; if not, it shows where k would be inserted or searched next in the children.

```cpp
private:
    // Finds the index of the first key in node >= k
    // Returns index where k should be or is located
    int findKey(BTreeNode* node, int k) {
        int idx = 0;
        while (idx < node->keys.size() && node->keys[idx] < k) {
            ++idx;
        }
        return idx;
    }
```

### Deletion | Helper Methods | handleUnderflow

`handleUnderflow` manages a child node with fewer keys than allowed by:

* Borrowing from the left sibling if it has enough keys (deleteSibling).
* Borrowing from the right sibling if it has enough keys (deleteSibling).
* Merging with the left sibling if it exists but lacks keys (deleteMerge), adjusting the index.
* Merging with the right sibling if the node is the leftmost child and siblings lack keys (deleteMerge).

```cpp
private:
  void handleUnderflow(BTreeNode* node, int idx) {
        // idx is the index of the child in the parent’s children array that is currently underflowing (has too few keys). It indicates which child node needs borrowing or merging to fix the underflow.

        // Try to borrow a key from the left sibling if it exists and has enough keys
        if (idx != 0 && node->children[idx - 1]->keys.size() >= degree) {
            deleteSibling(node, idx, idx - 1);
        }
        // Otherwise, try to borrow from the right sibling if it exists and has enough keys
        else if (idx + 1 < node->children.size() && node->children[idx + 1]->keys.size() >= degree) {
            deleteSibling(node, idx, idx + 1);
        }
        // If siblings don't have enough keys, merge with the left sibling if possible
        else if (idx != 0) {
            deleteMerge(node, idx - 1, idx);
            idx--; // Adjust idx because merged node moves left
        }
        // Otherwise, merge with the right sibling
        else {
            deleteMerge(node, idx, idx + 1);
        }
    }
```

### Deletion | Example

Initial B-Tree (order 3):

```ascii
              [2010]
           /          \
     [1998]         [2012, 2016]
     /    \         /     |     \
[1996] [1999]  [2011] [2015] [2023]
```

Delete key 2015:

* 2015 is in a leaf node [2015] (middle child of [2012, 2016]).
* After deletion, [2015] becomes empty → underflow.
* Underflow must be fixed.

Step-by-step:

* Check siblings of empty node [ ]:
  * Left sibling: [2011] has only 1 key → cannot lend.
  * Right sibling: [2023] has only 1 key → cannot lend.
* Merge with a sibling:
  * Merge [2011], 2012 (from parent), and [ ] (was [2015]).
* Result: [2011, 2012]
* Parent [2012, 2016] becomes [2016] and now has only two children: [2011, 2012] and [2023].

Final tree:

```ascii
              [2010]
           /          \
     [1998]           [2016]
     /    \           /     \
[1996] [1999]  [2011, 2012] [2023]
```

## B-Tree Complexity

### Search, Insert, Delete

Time complexity is $O(log n)$ — due to logarithmic height and binary/key search at each node.
  
### Space Complexity

$O(n)$ — total space grows linearly with number of keys.

### Efficiency

Balanced height and node capacity make B-Trees ideal for large datasets in databases and file systems.

## References

* [B-Tree Visualizer](https://www.cs.usfca.edu/~galles/visualization/BTree.html)
