# Merging Trees

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <vector>
#include <queue>
#include <sstream>

struct TreeNode {
    int value;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int value) : value(value), left(nullptr), right(nullptr) {}
};

class Tree {
public:
    TreeNode* root;

    Tree() : root(nullptr) {}

    void mergeTrees(Tree& otherTree) {
        root = mergeTrees(root, otherTree.root);
    }
// FREEZE CODE END

private:
    TreeNode* mergeTrees(TreeNode* n1, TreeNode* n2) {
        if (!n1) return n2;
        if (!n2) return n1;

        TreeNode* merged = new TreeNode(std::min(n1->value, n2->value));
        merged->left = mergeTrees(n1->left, n2->left);
        merged->right = mergeTrees(n1->right, n2->right);
        return merged;
    }

// FREEZE CODE BEGIN
};

class Helper {
public:
    static std::vector<std::string> parseTrees(char* args[], int size, int treeNum) {
        std::vector<std::string> treeNodes;
        int index = -1;

        for (int i = 1; i < size; ++i) {
            if (std::string(args[i]) == "!") {
                index = i;
                break;
            }
        }

        if (index == -1) {
            std::cerr << "Error: No '!' separator found in the input." << std::endl;
            return treeNodes;
        }

        if (treeNum == 1) {
            for (int i = 1; i < index; ++i) {
                if (std::string(args[i]).empty()) continue;  
                treeNodes.push_back(args[i]);
            }
        } else {
            for (int i = index + 1; i < size; ++i) {
                if (std::string(args[i]).empty()) continue; 
                treeNodes.push_back(args[i]);
            }
        }
        return treeNodes;
    }

    static Tree parseNodes(const std::vector<std::string>& nodes) {
        Tree tree;

        if (nodes.empty()) {
            return tree;
        }

        for (const std::string& node : nodes) {
            std::stringstream ss(node);
            std::string position_str, value_str;
            std::getline(ss, position_str, ':');
            std::getline(ss, value_str, ':');

            if (position_str.empty() || value_str.empty()) {
                std::cerr << "Error: Invalid argument for position or value: " << node << std::endl;
                continue;
            }

            try {
                int position = std::stoi(position_str);
                int value = std::stoi(value_str);

                switch (position) {
                    case 0:
                        tree.root = new TreeNode(value);
                        break;
                    case 1:
                        tree.root->left = new TreeNode(value);
                        break;
                    case 2:
                        tree.root->right = new TreeNode(value);
                        break;
                    case 3:
                        tree.root->left->left = new TreeNode(value);
                        break;
                    case 4:
                        tree.root->left->right = new TreeNode(value);
                        break;
                    case 5:
                        tree.root->right->left = new TreeNode(value);
                        break;
                    case 6:
                        tree.root->right->right = new TreeNode(value);
                        break;
                    default:
                        std::cerr << "Warning: Invalid position " << position << std::endl;
                }
            } catch (const std::invalid_argument& e) {
                std::cerr << "Error: Invalid argument for position or value: " << node << std::endl;
            } catch (const std::out_of_range& e) {
                std::cerr << "Error: Value out of range for position or value: " << node << std::endl;
            }
        }
        return tree;
    }

    static void print(Tree& tree) {
        if (tree.root == nullptr)
            return;

        std::queue<TreeNode*> q;
        q.push(tree.root);
        int level = 0;

        while (!q.empty()) {
            int levelSize = q.size();
            std::cout << "Level " << level << ": ";

            for (int i = 0; i < levelSize; ++i) {
                TreeNode* current = q.front();
                q.pop();
                std::cout << current->value << " ";

                if (current->left != nullptr) {
                    q.push(current->left);
                }

                if (current->right != nullptr) {
                    q.push(current->right);
                }
            }

            std::cout << std::endl;
            ++level;
        }
    }
};

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <tree nodes separated by space> ! <tree nodes separated by space>" << std::endl;
        return 1;
    }
    std::vector<std::string> treeNodes1 = Helper::parseTrees(argv, argc, 1);
    std::vector<std::string> treeNodes2 = Helper::parseTrees(argv, argc, 2);
    Tree tree1 = Helper::parseNodes(treeNodes1);
    Tree tree2 = Helper::parseNodes(treeNodes2);

    tree1.mergeTrees(tree2);
    std::cout << "Merged Trees:" << std::endl;
    std::cout << "-------------" << std::endl;
    Helper::print(tree1);

    return 0;
}
// FREEZE CODE END
```
