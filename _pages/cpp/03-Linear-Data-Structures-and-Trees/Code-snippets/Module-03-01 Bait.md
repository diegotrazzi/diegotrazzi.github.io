# Bait

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <queue>
#include <string>
#include <cstring>
// FREEZE CODE END
using namespace std;

class Node {
public:
  string value;
  Node* left;
  Node* right;
  Node(string value) : value(value)  {}
};

class BSTree {
public:
    Node* root;
    BSTree() : root(nullptr) {}

    void insert(const std::string& fileName) {
      // cout << fileName << endl;
      root = insertRec(root, fileName);
    }

private:
    Node* insertRec(Node* root, const std::string& fileName) {
      if (root == nullptr) {
        return new Node(fileName);
      }
      
      // sort using substring that starts at the fifth character
      string fileSub = fileName.substr(4);
      string nodeSub = root->value.substr(4);

      if (fileSub < nodeSub) {
        root->left = insertRec(root->left, fileName);
      } else if (fileSub > nodeSub) {
        root->right = insertRec(root->right, fileName);
      }
      return root;
    }
};



// FREEZE CODE BEGIN
char** parseArgs(char* arguments[], int argc, int &resultSize) {
    int recordsCount = 0;
    char** records = new char*[argc];

    std::string sb;

    for (int i = 0; i < argc; ++i) {
        if (strcmp(arguments[i], ":") != 0) {
            sb += arguments[i];
            sb += " ";

            if (i + 1 == argc) {
                records[recordsCount] = new char[sb.length() + 1];
                strcpy(records[recordsCount], sb.c_str());
                recordsCount++;
            }
        } else {
            records[recordsCount] = new char[sb.length() + 1];
            strcpy(records[recordsCount], sb.c_str());
            recordsCount++;
            sb.clear();
        }
    }

    resultSize = recordsCount;
    return records;
}

void printLevels(BSTree& tree) {
    if (tree.root == nullptr) {
        return;
    }

    std::queue<Node*> queue;
    queue.push(tree.root);

    int level = 0;

    while (!queue.empty()) {
        int nodeCount = queue.size();
        std::cout << "Level " << level << ": ";

        while (nodeCount > 0) {
            Node* node = queue.front();
            queue.pop();
            std::cout << node->value << " ";

            if (node->left != nullptr) {
                queue.push(node->left);
            }

            if (node->right != nullptr) {
                queue.push(node->right);
            }

            nodeCount--;
        }

        level++;
        std::cout << std::endl;
    }
}

int main(int argc, char* argv[]) {
    BSTree tree;
    int fileNamesCount;
    char** fileNames = parseArgs(argv + 1, argc - 1, fileNamesCount);
    for (int i = 0; i < fileNamesCount; ++i) {
        tree.insert(std::string(fileNames[i]));
        delete[] fileNames[i];
    }
    delete[] fileNames;
    printLevels(tree);
    return 0;
}

// FREEZE CODE END
```
