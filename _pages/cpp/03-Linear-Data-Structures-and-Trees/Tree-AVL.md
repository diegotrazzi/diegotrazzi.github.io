---
title: "Tree-AVL"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-AVL.webp" alt="AVL" height="350">
</div>

AVL trees are self-balancing binary search trees named after Adelson-Velsky and Landis. They maintain balance after insertions and deletions using rotations, ensuring operations (insert, delete and search) remain efficient $O(log_n)$.

 Space complexity remains O(n), with only a small constant overhead per node for storing height. Even in worst-case scenarios, AVL trees avoid becoming skewed, which makes them efficient for large datasets.

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
    Node *left, *right;

    Node(int v) : value(v), height(0), left(nullptr), right(nullptr) {}
};
```

## Public Methods

```cpp
class AVLTree {

public:
    AVLTree() : root(nullptr) {}

    void insert(int value) {
        root = insert(root, value);
    }

    void deleteValue(int value) {
        root = deleteNode(root, value);
    }
```

### Helper Methods

To maintain balance in AVL trees, rotations are used to restructure the tree when insertions create imbalance. Each node tracks its height to calculate the balance factor, which determines if a rotation is needed.

#### Height

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

#### Balance Factor

```cpp
private:
    int balanceFactor(Node* node) {
        return height(node->left) - height(node->right);
    }
```

#### Min Value

```cpp
    Node* minValueNode(Node* node) {
        Node* current = node;

        while (current->left != nullptr) 
            current = current->left;
            
        return current;
    }
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

### Left Rotation - S → S → R

🧠 **Visual Memory Hook:**

```ascii
    X                     Y
   / \\                 // \
 (A)  Y      ==>        X   (C)
    // \               / \\
   (B) (C)           (A) (B)
```

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
    Node* rightChild = node->right; // extract right child (Y)
    node->right = rightChild->left; // extract (Y->L) subGraph & attach it to head (X->R)
    rightChild->left = node; // reatach the head as L child 

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

## Insertion

```cpp
private:
    Node* insert(Node* node, int value) {
        if (node == nullptr)
            return (new Node(value));

        if (value < node->value)
            node->left = insert(node->left, value);
        else if (value > node->value)
            node->right = insert(node->right, value);
        else 
            return node; // becomes nullptr when we find the value

        updateHeight(node);

        return rebalance(node);
    }
};
```

## Rebalance

```cpp
    Node* rebalance(Node* node) {
        int balanceFactor = this->balanceFactor(node);

      // Left-heavy
        if (balanceFactor > 1) {
            if (this->balanceFactor(node->left) > 0) {
                // Case 1: Left-Left
                node = rotateRight(node);
            } else {
                // Case 2: Left-Right
                node->left = rotateLeft(node->left);
                node = rotateRight(node);
            }
        }
                // Right-heavy
        else if (balanceFactor < -1) {
            if (this -> balanceFactor(node->right) < 0) {
                // Case 3: Right-Right
                node = rotateLeft(node);
            } else {
                // Case 4: Right-Left
                node->right = rotateRight(node->right);
                node = rotateLeft(node);
            }
        }
        return node;
    }   
```

## Deletion

```cpp
    Node* deleteNode(Node* root, int value) {
        if (root == nullptr) {
            return root;
        }

        if (value < root->value) {
            root->left = deleteNode(root->left, value);
        }
        else if (value > root->value) {
            root->right = deleteNode(root->right, value);
        } else {
            if (root->left == nullptr || root->right == nullptr) {
                Node* temp = root->left ? root->left : root->right;
                if (temp == nullptr) {
                    return nullptr;
                } else {
                    return temp;
                }
            } else {
                Node* temp = minValueNode(root->right);
                root->value = temp->value;
                root->right = deleteNode(root->right, temp->value);
            }
        }

        updateHeight(root);
        return rebalance(root);
    }

```
