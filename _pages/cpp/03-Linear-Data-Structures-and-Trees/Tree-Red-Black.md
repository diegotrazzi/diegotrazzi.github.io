---
title: "Tree-Red-Black"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Red-Black.webp" alt="R/B" height="200">
</div>

Red-Black Trees are balanced binary search trees that use node colors (red or black) and strict rules to maintain balance. Each tree has a black root, black NIL leaves, and no consecutive red nodes. All paths from a node to its leaves contain the same number of black nodes. To preserve these properties during insertions and deletions, red-black trees use rotations and recoloring. This structure guarantees $O(log_n)$ time for search, insert, and delete.

> :bulb: **AVL trees are better for read-heavy** workloads due to stricter balancing (faster lookups). **Red-Black trees are better for write-heavy** workloads (insert/delete) as they rebalance less aggressively.

1. **Node Color**: Each node is colored either red or black.
2. **Root Property**: The root node is always black.
3. **Leaf Property**: Every NIL leaf is black.
4. **Red Node Property**: Red nodes cannot have red children (**no two red nodes occur consecutively**). Also, remember that new nodes are always Red.
5. **Black Depth Property**: All paths from a node to its leaf descendants contain the same number of black nodes.

## Red-Black Node

Notice how a node for a red-black tree also has attributes for the parent node and the color.

```cpp
class Node {
public:
    int value;
    Node *parent, *left, *right;
    int color; // 0 for black, 1 for red

    Node(int v) : value(v), parent(nullptr), left(nullptr), right(nullptr), color(1) {
        // New nodes are always red!!
    }
};
```

---

## Rotations

In Red-Black Trees, coloring and rotations are used to maintain balance after insertions and deletions.

* New nodes are red by default.
* Violations of red-black properties (like two red nodes in a row) are corrected using:
  * Left Rotation: Typically when a red right child has a red child.
  * Right Rotation: Typically when a red left child has a red child.
  * After rotation, recoloring restores proper coloring rules.
  * These adjustments keep the tree balanced with logarithmic height, ensuring efficient operations.

### Left Rotation

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Red-Black-L-Rotaiton.png" alt="R/B L" height="200">
</div>

🧠 **Visual Memory Hook:**

```ascii
    X                     Y
   / \\                 // \
 (A)  Y      ==>        X   (C)
    // \               / \\
   (B) (C)           (A) (B)
```

```cpp
Node* leftRotate(Node* x) {
        Node* y = x->right; // save the right connection as new node
        Node* newSubtree = y->left; // save the right child left connection as new node

        y->left = x; // attach new node L the old head
        x->right = newSubtree; // attach to the old head right the subtree

        y->parent = x->parent; // relink the parent of old head as new head

        if (x->parent == nullptr) { // reattach the rotation to the tree above, either as root, L/R 
            root = y;
        } else if (x == x->parent->left) {
            x->parent->left = y;
        } else {
            x->parent->right = y;
        }

        x->parent = y;

        return y; // Return the new root of the rotated subtree
```

### Right Rotation

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Red-Black-R-Rotaiton.png" alt="R/B L" height="200">
</div>

🧠 **Visual Memory Hook:**

```ascii
      X                 Y
    // \              /  \\
    Y  (C)   ==>    (A)   X
   / \\                 // \
 (A) (B)              (B)  (C)
```

```cpp
Node* rightRotate(Node* x) {
        Node* y = x->left; // New head Y
        Node* newSubtree = y->right; // Save R subtree 

        y->right = x; // swap R subtree with previous head
        x->left = newSubtree; // swap attachement of the subtree

        y->parent = x->parent; // set Y parent to match X parent

        if (x->parent == nullptr) { // reconnect the previous tree to the Y
            root = y;
        } else if (x == x->parent->right) { // if previous parent right was X reconnect Y
            x->parent->right = y;
        } else {
            x->parent->left = y;
        }

        x->parent = y; // finally recoonect X parent to Y

        return y; // Return the new root of the rotated subtree
    }
```

### Left-Right Rotation

🧠 **Visual Memory Hook:**

```ascii
      X                   X                    Z
     / \\                //                   / \\
    Y  (D)   ==>        Z     ==>           Y    X
   / \\                 / \                / \  / \\
 (A)  Z               (Y) (B)            (A)(B)(C)(D)
     / \\
   (B) (C)
```

```cpp
```

### Right-Left Rotation

🧠 **Visual Memory Hook:**

```ascii
    X                      X                      Z
   / \\                   //                     / \\
 (A)  Y       ==>         Z        ==>         X     Y
     / \\                / \                 / \\   / \\
   (C) Z              (C)(Y)              (A)(C)(D)(E)
        / \\
      (D) (E)
```

```cpp
```

---

## Insertion

Red-Black Tree Insertion Summary:

> :bulb: **Public insert** → **private insert** → **fix-tree** (+black root) → **rotation** (if needed)

Process:

1. Insert node per BST rules and **color it red** (constructor of public insert method).
2. **If parent is black, done.**

Fixing Violations:

**If parent is red**, fix **TWO-RED** violation:

   1. Case 1: **Uncle red** → Recolor **parent & uncle black**, **grandparent red** → **re-evaluate from grandparent**.
   2. Case 2: **Uncle black + triangle** → **Rotate at parent** → becomes line.
   3. Case 3: **Uncle black + line** → **Rotate at grandparent**, **recolor parent (BLACK) /grandparent (RED)**.

🧠 **Visual Memory Hook:**

```ascii
      G               ← Grandparent (G)
     / \
    P   U             ← Parent (P) & Uncle (U)
   /    
  N                   ← New node (N)
```

### Insertion | Public method

```cpp
public:
    void insert(int value) {
        Node* newNode = new Node(value);
        root = insert(root, nullptr, newNode);
        fixTree(newNode); // Fix violations after insertion
        root->color = 0; // Ensure the root is always black
    }
```

### Insertion | Private Method

```cpp
private:
    Node* insert(Node* node, Node* parent, Node* newNode) { 
        // node is root, parent is null, and newNode is newNode to insert (instead of value)
        if (node == nullptr) { // case we reach the leaf, node is null, but has a parent
            newNode->parent = parent;
            return newNode;
        }

        if (newNode->value < node->value) {
            node->left = insert(node->left, node, newNode);
        } else if (newNode->value > node->value) {
            node->right = insert(node->right, node, newNode);
        }

        return node;
    }
```

### Insertion | Fix Tree

#### Case 1: TWO-RED violation | Uncle is Red

Recolor **parent & uncle black**, **grandparent red** → **re-evaluate from grandparent**.

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Red-Black-Uncle-Red.gif" alt="R/B" height="200">
</div>

#### Case 2+3: TWO-RED violation | Uncle black + triangle || line

**Rotate at parent** → **becomes line** → **Rotate at grandparent** → **parent BLACK + grandparent RED**.

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/Tree-Red-Black-Uncle-Black.gif" alt="R/B" height="200">
</div>

> :bulb: **If the uncle is nullptr, it is treated as black in red-black tree logic.**

> :bulb: **If the UNCLE is RED, also the PARENT is RED because we only check the uncle’s color during violation fixing, and that violation only happens when the parent is red.**

```cpp
private:
    void fixTree(Node* node) {
        Node* parent = node->parent;

        if (parent == nullptr) {
            node->color = 0;
            return; // Parent is null, we've reached the root, no changes made
        }

        if (parent->color == 0) {
            return; // Parent is black, no changes made
        }

        Node* grandparent = parent->parent;
        if (grandparent == nullptr) {
            parent->color = 0; // No grandparent means the parent is the root. Set to black.
            return;
        }

        Node* uncle = getUncle(parent);
        if (uncle != nullptr && uncle->color == 1) { 
            // Case 1 uncle is red. Implies parent is red
            // Case 2+3: we treat nullptr same as black
            parent->color = 0;
            grandparent->color = 1;
            uncle->color = 0;
            fixTree(grandparent); // Call recursively for grandparent
        // Left-right triangle
        } else if (parent == grandparent->left) { // Parent is left child of grandparent
            if (node == parent->right) { // Case 2 "<" triangle formation
                leftRotate(parent); // Rotate to "/" line formation
                /*
                // Before:
                    G
                   /
                  P
                   \
                    N (node)

                // After leftRotate(P):
                      G
                    /
                   N (now in place of P)
                 /
                P
                */
                parent = node; // for clarity so we can color parent BLACK
            }
            rightRotate(grandparent); // Case 3 "/" line formation
            parent->color = 0;
            grandparent->color = 1;
        // Right-left triangle
        } else { // Parent is right child of grandparent
            if (node == parent->left) { // Case 2 ">" triangle formation
                rightRotate(parent); // Rotate to "\" line formation
                parent = node;
            }
            leftRotate(grandparent); // Case 3 "\" line formation
            parent->color = 0;
            grandparent->color = 1;
        }
    }
```

#### Insertion | Fix Tree | Uncle Node

```cpp
private:
    Node* getUncle(Node* parent) {
        Node* grandparent = parent->parent;

        if (grandparent->left == parent) {
            return grandparent->right; // return the other side (uncle)
        } else {
            return grandparent->left;
        }
    }
```

---

## Deletion

Deletion in red-black trees removes a node and then fixes violations to keep tree properties.

> :bulb: **Public delete** → **search node** → **private delete** → **fix violations**

Process:

1. Find the node using BST rules.
2. If it has **two children**, swap with in-order successor/predecessor, then remove.
3. **If removed node is RED, no violation**; if **BLACK, fix black-height violations**.

> :bulb: A black-height violation occurs when a black node is deleted, it reduces the black-height on that path by 1, violating the red-black property that all paths from a node to its leaves must contain the same number of black nodes.

If removed node is BLACK, fix **"black-height violations"**:

* Case 1: **Sibling RED** → rotate and recolor to transform into other cases.
* Case 2: **Sibling and children BLACK** → repaint sibling red, move double BLACK up.
* Case 3: **Sibling BLACK with RED child** → rotate and recolor to fix double BLACK.

### Deletion | Public Method

```cpp
public:
    void deleteNode(int value) {
        Node* nodeToDelete = search(root, value); // Find the node to delete
        if (nodeToDelete != nullptr) {
            deleteNode(nodeToDelete);
        }
    }
```

### Deletion | Private Method

1. Locate the node to delete.
2. If node has **≤1 child**: replace node with its child (or nullptr) via transplant.
3. If node has **2 children**: find in-order successor (min in right subtree), **replace node with successor**.
4. Adjust pointers and colors to maintain tree structure.
5. **If deleted node was black**, call **fixDelete** to restore red-black properties.

#### Case 1: Node has 1 child

```ascii
   N              R1
  / \    --->    / \
 NIL R1         NIL R22
```

#### Case 2: Node has 2 children (replace with successor)

```ascii
       N                  S
      / \                /  \
     L   R   --->       L    R
         /                  /
        S                  NIL
```

* N is deleted.
* S is the in-order successor (smallest node in N’s right subtree).
* S replaces N with its subtrees adjusted.

> :bulb: **IMPORTANT NOTE**: **logically deleted** node vs **physically deleted**

**In RB Trees when deleting there is a distinction between logically deleted node and physically deleted node:**

* The **logically deleted** node is the one you **intended to delete** (e.g., the node with the value you passed in).
* The **physically deleted** node is often **the successor**, especially when the original node has two children.
* Therefore, the **replacement is the node that fills the physical spot of the removed node** (typically the successor->right), to maintain tree structure.



```cpp
private:
    void deleteNode(Node* node) {
                Node* replacement = nullptr; // The node that takes the PHYSICALLY-deleted node’s place.
                Node* toFix = nullptr; // where fix-up starts (needed if a black node is deleted).
                int originalColor = node->color; // saved to know if fix-up is needed (only when deleting black nodes).

                if (node->left == nullptr) { // node to delete has right child ONLY
                    replacement = node->right;
                    toFix = replacement;
                    transplant(node, node->right);
                } else if (node->right == nullptr) { // node to delete has left child ONLY
                    replacement = node->left;
                    toFix = replacement;
                    transplant(node, node->left);
                } else { // node to delete has two children
                    Node* successor = findMin(node->right);
                    
                    // The successor is moved to replace the node being deleted, and then its original position is vacated — that’s the spot from which a node is physically removed.
                    originalColor = successor->color; 
                    
                    // The successor may have a right child (it can’t have a left one, since it’s the minimum). That right child will replace the successor
                    replacement = successor->right;

                    // If replacement is not null, it’s the point of fix-up; otherwise, we start from the successor’s parent
                    toFix = replacement != nullptr ? replacement : successor->parent;

                    // Reconnecting the successor in place of the node being deleted
                    if (successor->parent == node) {
                        if (replacement != nullptr) {
                            replacement->parent = successor; // this is redundant because replacement = successor->right (?)
                        }
                    } else {
                        // This block handles the case when the successor is not the direct child of the node being deleted. Physically removes successor from its original position by replacing it with its right child (if any)
                        transplant(successor, successor->right);
                        successor->right = node->right;
                        if (successor->right != nullptr) {
                            successor->right->parent = successor;
                        }
                    }

                    transplant(node, successor);
                    successor->left = node->left;
                    successor->left->parent = successor;
                    successor->color = node->color;
                }

                if (originalColor == 0) {
                    fixDelete(toFix);
                }
            }
```

### Deletion | Utilities | Search

```cpp
private:
    Node* search(Node* node, int value) {
        if (node == nullptr || node->value == value) {
            return node;
        }

        if (value < node->value) {
            return search(node->left, value);
        } else {
            return search(node->right, value);
        }
    }
```

### Deletion | Utilities | FindMin

```cpp
private:
    Node* findMin(Node* node) {
        Node* current = node;

        while (current->left != nullptr)
            current = current->left;

        return current;
    }
```

### Deletion | Utilities | Transplant

Before transplant:

```ascii
      P
     / \
    D   S
   / \
  A   B
```

* P = parent of node to delete
* D = node to delete
* S = sibling/subtree unaffected
* A, B = children of D

If we transplant D with B (replace D with B):

After transplant:

```ascii
      P
     / \
    B   S
```

* B takes D’s place as the child of P
* A is no longer connected here (handled separately)

The transplant method updates pointers:

* P’s left child pointer now points to B instead of D
* B’s parent pointer is updated to P

This allows the deletion code to then handle the subtree under B correctly.

```cpp
private:
    void transplant(Node* nodeToDelete, Node* nodeToMove) {
        if (nodeToDelete->parent == nullptr) {
            root = nodeToMove;
        } else if (nodeToDelete == nodeToDelete->parent->left) {
            nodeToDelete->parent->left = nodeToMove;
        } else {
            nodeToDelete->parent->right = nodeToMove;
        }

        if (nodeToMove != nullptr) {
            nodeToMove->parent = nodeToDelete->parent;
        }
    }
```

---

### Deletion | Fix-Deletion

After physically deleting a node, the tree may violate red-black properties (especially black-height). The fixDelete function restores these properties by starting from a given node toFix.

* Key idea: Move up the tree fixing violations until the root or no more problems.
* `toFix = (replacement != nullptr) ? replacement : successor->parent;` It can be the replacement node or the parent of the physically removed node.

General flow inside fixDelete:

1. While node is not root and is black (double-black violation):
   1. Identify the sibling of node depending if node is left or right child.
2. If sibling is red:
   1. Recolor sibling black, parent red.
   2. Rotate (left or right) around parent to bring a black sibling closer.
3. If sibling’s children are both black:
   1. Recolor sibling red.
   2. Move fix point up to parent (continue fixing).
4. Otherwise:
   1. If sibling’s far child is black and near child is red:
      1.  Recolor children and sibling.
      2.  Rotate around sibling.
   2.  Recolor sibling to parent’s color.
   3.  Set parent black.
   4.  Set sibling’s far child black.
   5.  Rotate around parent.
   6.  Set fix point to root (fix complete).
5.  After loop, if node exists, recolor it black.

⸻

Summary of fixDelete operations:

| Condition                                  | Action                                | Rotation            |
|-------------------------------------------|----------------------------------------|----------------------|
| Sibling RED                               | Recolor + rotate parent               | Left or right rotate |
| Sibling BLACK + sibilng's children BLACK  | Sibling RED + move up                 | None                 |
| Sibling BLACK, far child BLACK            | Recolor children + rotate sibling     | Rotate sibling       |
| Otherwise                                 | Recolor sibling and parent + rotate parent | Rotate parent   |

#### Condition | Sibling RED

```cpp
if (sibling->color == 1) {
    sibling->color = 0;
    node->parent->color = 1;
    leftRotate(node->parent);
    sibling = node->parent->right;
}
```

Scenario:

You delete a black node and the fix-up starts. Assume:

```ascii
        10(B)
       /    \
     5(B)   15(R)
           /   \
        13(B) 20(B)
```

Let’s say node = 5 was deleted (a black leaf). Now, the sibling of the deleted node is 15(R).

To fix:

1. **Sibling (15) is RED → we recolor it BLACK, parent (10) becomes RED.**
2. **Rotate left around parent 10.**

Now the tree becomes:

```ascii
       15(B)
      /    \
   10(R)   20(B)
     \
    13(B)
```

We now update **sibling = node->parent->right because node is still under 10**, and its new sibling is now 13.

#### Condition | Sibling BLACK + Sibling's children are BLACK

Tree before deletion (node to delete = 10):

```ascii
        20(B)
       /     \
   10(B)     30(B)
           /     \
        25(B)   35(B)
```

Steps:

1. Delete node 10 (black leaf).
2. `toFix = nullptr`, so fixDelete is called with node = nullptr.
3. Node is considered black (null leaf).
4. sibling = 30 (black).
5. Both sibling->left (25) and sibling->right (35) are black.

So this block executes:

```cpp
if (sibling->left->color == 0 && sibling->right->color == 0) {
    sibling->color = 1;
    node = node->parent; // moves up to 20
}
```

This redistributes the “extra black” up to the parent (20), fixing the black height violation without rotation.

#### Condition | Sibling BLACK + Sibling's far child is BLACK

Example:

```ascii
       P(B)
      /    \
   N(B)   S(B)
          /   \
       SL(R)  SR(B)
```

* P = parent (black)
* N = node to fix (black), left child of P
* S = sibling (black)
* SL = sibling’s left child (red)
* SR = sibling’s right child (black)

Fix steps:

1. Recolor S red, SL black.
2. Right rotate on S, making SL the new sibling of N.
3. Then recolor new sibling with P’s color, P black, and S’s right child black.
4. Left rotate on P.

This rotation fixes the red-black property violations caused by N’s blackness.

```cpp
void fixDelete(Node* node) {
        while (node != root && node->color == 0) {
            Node* sibling;
            if (node == node->parent->left) { // node is the left child
                sibling = node->parent->right;
                // This handles the case when: Sibling is red
                if (sibling->color == 1) {
                    sibling->color = 0;
                    node->parent->color = 1;
                    leftRotate(node->parent);
                    sibling = node->parent->right;
                }
                // Assumes sibling is black (color 0), because if sibling were red (color 1), it would have been handled in the earlier if
                if (sibling->left->color == 0 && sibling->right->color == 0) {
                    sibling->color = 1; 
                    node = node->parent;
                } else {
                // This handles the case when: Sibling is black
                    // Sibling’s right child is black (far child black) + Sibling’s left child is red (near child red).
                    if (sibling->right->color == 0) {
                        sibling->left->color = 0;
                        sibling->color = 1; // RED sibling then 
                        rightRotate(sibling);
                        sibling = node->parent->right;
                    }
                    
                    sibling->color = node->parent->color;
                    node->parent->color = 0;
                    sibling->right->color = 0;
                    leftRotate(node->parent);
                    node = root;
                }
            } else { // node is the right child
                sibling = node->parent->left;
                if (sibling->color == 1) {
                    sibling->color = 0;
                    node->parent->color = 1;
                    rightRotate(node->parent);
                    sibling = node->parent->left;
                }
                if (sibling->right->color == 0 && sibling->left->color == 0) {
                    sibling->color = 1;
                    node = node->parent;
                } else {
                    if (sibling->left->color == 0) {
                        sibling->right->color = 0;
                        sibling->color = 1;
                        leftRotate(sibling);
                        sibling = node->parent->left;
                    }
                    sibling->color = node->parent->color;
                    node->parent->color = 0;
                    sibling->left->color = 0;
                    rightRotate(node->parent);
                    node = root;
                }
            }
        }
        // Ensures the final node checked is black, restoring the red-black tree property that the root or the fix point must be black.
        if (node != nullptr) {
            node->color = 0;
        }
    }
```

If you want to treat nullptr as black, you need helper checks like:

```cpp
bool isBlack(Node* n) {
    return n == nullptr || n->color == 0;
}
```

## Time and Space Complexity

Time Complexity:

* Search: O(log n) — always logarithmic due to balanced height.
* Insertion: O(log n) — search plus constant rotations and recoloring.
* Deletion: O(log n) — search plus up to three rotations to fix violations.

Space Complexity:

* O(n) — each node stores value, pointers (left, right, parent), and a color bit.

Red-black trees maintain balanced height, ensuring efficient O(log n) operations and linear space usage.

> Rotations and recoloring involve only a fixed number of pointer changes and color updates on a few nodes (typically 2 or 3). These operations do not depend on the tree size, so they run in constant time $O(1)$.

## References

* [Red-Black Tree Visualizer](https://www.cs.usfca.edu/~galles/visualization/RedBlack.html)