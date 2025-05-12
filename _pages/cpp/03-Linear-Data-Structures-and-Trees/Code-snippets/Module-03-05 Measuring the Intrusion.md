# Measuring the Intrusion

```cpp
// FREEZE CODE BEGIN
#include <iostream>
// FREEZE CODE END
#include <queue>

class Node {
public:
    int value;
    Node* left;
    Node* right;
    Node* parent;
    Node(int value) : value(value), left(nullptr), right(nullptr), parent(nullptr) {}
};

class BSTree {
public:
    Node* root;
    BSTree() : root(nullptr) {}

    void insert(int num) {
       root = insertRecursive(root, num);
     }

     int measureIntrusion(int target) {
        return measureIntrusion(root, target, 0);
    }

private:
    Node* insertRecursive(Node* current, int num) {
        if (current == nullptr) {
            Node* newNode = new Node(num);
            return newNode;
        }
        if (num < current->value) {
            current->left = insertRecursive(current->left, num);
            current->left->parent = current;
        } else if (num > current->value) {
            current->right = insertRecursive(current->right, num);
            current->right->parent = current;
        }
        return current;
    }

    int getDepth(Node* node) {
        if (node == nullptr || node == root) {
            return 0;
        }
        return 1 + getDepth(node->parent);
    }

    int measureIntrusion(Node* node, int target, int count) {
        if (node == nullptr) {
            return count;
        }
        if (getDepth(node) < target) {
            count++;
        }
        count = measureIntrusion(node->left, target, count);
        count = measureIntrusion(node->right, target, count);
        return count;
    }

    
};


// FREEZE CODE BEGIN
int main(int argc, char* argv[]) {
    BSTree tree;
    int target = std::stoi(argv[1]);

    for (int i = 2; i < argc; i++) {
        tree.insert(std::stoi(argv[i]));
    }
    std::cout << tree.measureIntrusion(target) << std::endl;

    return 0;
}
// FREEZE CODE END

```
