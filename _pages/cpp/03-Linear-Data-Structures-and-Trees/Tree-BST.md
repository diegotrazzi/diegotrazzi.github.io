---
title: "Tree"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-BST.webp" alt="CLL" height="350">
</div>

A Binary Search Tree (BST) is a hierarchical, node-based structure where:

* Each node has at most two children.
* The left child < node < right child, ensuring ordered data.
* Subtrees must also follow BST rules.

Key Benefits:

* Efficient search, insertion, deletion in O(h), where h is the height.
* In-order traversal yields sorted data.
* Dynamically resizable, unlike arrays.
* Self-balancing variants (AVL, Red-Black) ensure optimal performance.

```cpp
struct TreeNode {
    int value;
    TreeNode* left;
    TreeNode* right;

    // Constructor
    TreeNode(int value) : value(value), left(nullptr), right(nullptr) {}
};
```

## Insertion

Helper method (withouth root)

```cpp
public:
void insert(int value) {
        root = insertRecursive(root, value);
    }
```

Private implementation:

```cpp
class BinarySearchTree {
private:
    TreeNode* root; // The root node of our BST

public:
    // Constructor
    BinarySearchTree() : root(nullptr) {
        // Start with an empty tree
    }

    void insert(int value) {
        root = insertRecursive(root, value);
    }

    // Public method to get the root (added for demonstration)
    TreeNode* getRoot() const {
        return root;
    }

private:
    TreeNode* insertRecursive(TreeNode* node, int value) {
        if (node == nullptr) {
            return new TreeNode(value);
        }

        if (value < node->value) {
            node->left = insertRecursive(node->left, value);
        } else if (value > node->value) {
            node->right = insertRecursive(node->right, value);
        }

        return node;
    }
};
};
```

## Deleteion

Deleting a node in a Binary Search Tree (BST) maintains the BST property and involves three cases:

1. **No Children (Leaf)**: Simply remove the node.
2. **One Child**: Replace the node with its child.
3. **Two Children**:
   1. Find the **in-order successor** (smallest in the right subtree).
   2. Replace the node’s value with the successor’s.
   3. Recursively delete the successor.

```cpp
private:
    TreeNode* minValNode(TreeNode* node) {
        // Find the leftmost leaf
        while (node->left != nullptr) {
            node = node->left;
        }
        return node;
    }

    TreeNode* deleteNode(TreeNode* node, int value) {
        // If the tree is empty, return the same node
        if (node == nullptr) return node;
        // Otherwise, recurse down the tree
        if (value < node->value) {
            node->left = deleteNode(node->left, value);
        } else if (value > node->value) {
            node->right = deleteNode(node->right, value);
        } else {
            // Node with only one child or no child
            if (node->left == nullptr) {
                return node->right;
            } else if (node->right == nullptr) {
                return node->left;
            }
            // Node with two children: Get the in-order successor (smallest in the right subtree)
            node->value = minValNode(node->right)->value;
            // Delete the in-order successor
            node->right = deleteNode(node->right, node->value);
        }
        return node;
    }
```

## Traversal

Binary Search Trees can be printed in two ways:

*	**In-order traversal** (left-root-right) prints nodes in sorted order. This is done recursively by visiting left subtree, printing the node, then visiting the right subtree.
* **Level-order traversal** prints nodes level by level using a queue (FIFO). Nodes are enqueued level by level and dequeued to print their values, showing the hierarchical tree structure.

```cpp

```
