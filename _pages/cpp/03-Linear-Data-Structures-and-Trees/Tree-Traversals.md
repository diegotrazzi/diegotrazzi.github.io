---
title: "Tree Traversals"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree.gif" alt="CLL" height="350">
</div>

Trees are a fundamental type of non-linear data structure used to represent hierarchical relationships. Unlike linear structures like arrays or linked lists, trees organize data in parent-child relationships, starting from a root node and branching into subtrees. Each node can have multiple children, and nodes with no children are called leaves. Key concepts include the **root, leaf, edge (connection between nodes), depth (distance from root), and height (longest path to a leaf)**.

A **node’s height is the number of edges on the longest path from the node to a leaf**, while its **depth is the number of edges from the root to the node**. The level of a node reflects its depth, starting at 0 for the root. A **node’s degree is its number of children**. Tree types include **Binary Tree (max two children)**, **Binary Search Tree (left < parent < right)**, **Adelson-Velsky and Landis: AVL Tree (self-balancing)**, and **B-Tree (used in databases)**.

Properties:

* **Maximum number of nodes at level `l`**:
  * $Maximum Nodes = 2^{(i)}$, where level starts at 0.
* **Maximum number of nodes in a tree of height `h`**, assuming the tree is full and **height = number of nodes**, then:
  * $Maximum Nodes = 2^{h}-1$
* **Minimum height for a binary tree with `L` leaves**:  
  * $Internal Nodes = L-1$
* **Minimum height of a binary tree with `n` nodes**:  
  * $Minimum Height = log_2(n+1)$

To represent a tree we define a `TreeNode` class containing an integer value and **pointers to left and right children**. This forms the basis for a binary tree, where each node can have up to two children. A `BinaryTree` class manages the tree with a root node initialized in the constructor.

```cpp
class TreeNode {
public:
    int data; // data of the node
    TreeNode* left; // reference to the left child
    TreeNode* right; // reference to the right child
    
    // Constructor to initialize the node with data and null children
    TreeNode(int data) {
        this->data = data;
        this->left = nullptr;
        this->right = nullptr;
    }
};
```

```cpp
class BinaryTree {
public:
    TreeNode* root; // root of the tree
    
    BinaryTree(int data) {
        root = new TreeNode(data); // initialize the root
    }
    
};
```

## Iterating Over a Tree

Tree traversal involves visiting each node in a tree exactly once, using structured strategies. 
All three have the same time complexity: $O(n)$, where n is the number of nodes.

### Pre-order

Visit root → left → right. Good for copying trees

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-pre-order.png" alt="CLL" height="150">
</div>

```cpp
    void preOrderTraversal(TreeNode* node) {
        if (node != nullptr) {
            // Visit the root node
            std::cout << node->data << " ";
            // Traverse the left subtree in pre-order
            preOrderTraversal(node->left);
            // Traverse the right subtree in pre-order
            preOrderTraversal(node->right);
        }
    }
```

### In-order

Visit left → root → right. Useful for sorting (e.g., **binary search trees**). **Clockwise**

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-in-order.png" alt="CLL" height="150">
</div>

```cpp
    void inOrderTraversal(TreeNode* node) {
        if (node != nullptr) {
            // Traverse the left subtree in in-order
            inOrderTraversal(node->left);
            // Visit the root node
            std::cout << node->data << " ";
            // Traverse the right subtree in in-order
            inOrderTraversal(node->right);
        }
    }
```

### Post-order

Visit left → right → root. Ideal for deletions.  **Counter-clockwise**

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-post-order.png" alt="CLL" height="150">
</div>

```cpp
    void postOrderTraversal(TreeNode* node) {
        if (node != nullptr) {
            // Traverse the left subtree in post-order
            postOrderTraversal(node->left);
            // Traverse the right subtree in post-order
            postOrderTraversal(node->right);
            // Visit the root node
            std::cout << node->data << " ";
        }
    }
```

