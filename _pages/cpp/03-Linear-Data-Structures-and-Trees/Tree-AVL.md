---
title: "Tree-AVL"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-AVL.webp" alt="AVL" height="350">
</div>

AVL trees are self-balancing binary search trees named after Adelson-Velsky and Landis. They maintain balance after insertions and deletions using rotations, ensuring operations remain efficient $O(log_n)$.

## Key Features

AVL trees maintain balance using the balancing factor and rotations.

* **Balance Factor: For each node, balance = height(left) - height(right), must be -1, 0, or 1**.
* Rotations:
  * LL (single right)
  * RR (single left)
  * LR (left-right)
  * RL (right-left)
  * Height: always $O(log_n)$ where $n$ is the number of nodes.
  * Benefit: Prevents worst-case skewed trees, ensuring consistent performance for insert, delete, and lookup.

## Node

Has an extra attribute, `height` which is used to calculate the balance factor of a node, which is essential for maintaining the AVL tree’s balance. It helps determine whether rotations are needed during **insertions** or **deletions**.

```cpp
class Node {
public:
    int value, height;
    Node* left;
    Node* right;

    Node(int v) : value(v), height(1), left(nullptr), right(nullptr) {}
};
```

## Insertion

```cpp
class AVLTree {

public:
    AVLTree() : root(nullptr) {}

    void insert(int value) {
        root = insert(root, value);
    }

    void preOrder() {
        preOrder(root);
    }

private:
    Node* root;

    Node* insert(Node* node, int value) {
        if (node == nullptr)
            return new Node(value);

        if (value < node->value)
            node->left = insert(node->left, value);
        else if (value > node->value)
            node->right = insert(node->right, value);

        return node;
    }

    void preOrder(Node* node) {
        if (node != nullptr) {
            std::cout << node->value << " ";
            preOrder(node->left);
            preOrder(node->right);
        }
    }


};
```

## Rotations

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Rebalancing.gif" alt="Rotations" height="600">
</div>

Rotaitons follow this sequence:

1. Copy a child node
2. Rotate the child and parent nodes
3. Update the height of the parent node
4. Update the height of the child node
5. Return the child node

### Helper Methods

To maintain balance in AVL trees, rotations are used to restructure the tree when insertions create imbalance. Each node tracks its height to calculate the balance factor, which determines if a rotation is needed.

> :bulb: The **height** of a node is the **number of edges in the longest path from that node to a leaf.**

**Why is nullptr height -1?**

```cpp
    A
   / \
  B   C
```

The key point is that we use -1 for nullptr because there is no child in that position. It’s a placeholder indicating that there’s nothing there, and it’s treated as one level deeper than an existing node with height 0 (such as a leaf node). This helps when calculating the height of the parent node.

```cpp
private:
    int height(Node* node) {
        return node ? node->height : -1;
    }
    void updateHeight(Node* node) {
        int leftChildHeight = height(node->left);
        int rightChildHeight = height(node->right);
        node->height = std::max(leftChildHeight, rightChildHeight) + 1;
    }
```

### Left Rotation - S → S → R

“Save → Shift → Reattach”

1. Save the right child → rightChild = node->right
2. Shift the subtree left → node->right = rightChild->left
3. Reattach node under right child → rightChild->left = node

```cpp
Node* rotateLeft(Node* node) {
    if (!node || !node->right) {
        return node;
    }
    // S → S → R
    Node* rightChild = node->right;
    node->right = rightChild->left;
    rightChild->left = node;

    updateHeight(node);
    updateHeight(rightChild);

    return rightChild;
}
```

### Right Rotation - S → S → R

```cpp
    Node* rotateRight(Node* node) {
        if (!node || !node->left) {
            return node;
        }
        // S → S → R
        Node* leftChild = node->left;
        node->left = leftChild->right;
        leftChild->right = node;

        updateHeight(node);
        updateHeight(leftChild);

        return leftChild;
    }
```
