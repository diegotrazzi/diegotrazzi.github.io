# Detecting Intrusion

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <queue>
#include <string>

class TreeNode {
public:
    std::string value;
    TreeNode* left;
    TreeNode* right;

    TreeNode(const std::string& value) : value(value), left(nullptr), right(nullptr) {}
};

class Tree {
public:
    TreeNode* root;
    bool targetFound;

    Tree() : root(nullptr), targetFound(false) {}

    void insert(const std::string& value) {
        root = insert(root, value);
    }

private:
    TreeNode* insert(TreeNode* node, const std::string& value) {
        if (node == nullptr) {
            return new TreeNode(value);
        }
        if (value < node->value) {
            node->left = insert(node->left, value);
        } else {
            node->right = insert(node->right, value);
        }
        return node;
    }
// FREEZE CODE END

public:
 void search(const std::string& target) {
    std::queue<TreeNode*> queue;
    queue.push(root);

    while (!queue.empty()) {
        int size = queue.size();
        for (int i = 0; i < size; i++) {
            TreeNode* currentNode = queue.front();
            queue.pop();

            std::cout << currentNode->value;

            if (currentNode->value == target) {
                targetFound = true;
                return;
            } else {
                std::cout << " -> ";
            }

            if (currentNode->left != nullptr) queue.push(currentNode->left);
            if (currentNode->right != nullptr) queue.push(currentNode->right);

        }
    }
 }


// FREEZE CODE BEGIN
};

int main(int argc, char* argv[]) {
    Tree tree;
    const char* files[] = {
        "FireDeptAudit.txt", "CrimeReport.csv", "TransportationSurvey.txt", "TownHallPresentation.ppt", 
        "Budget.xls", "EmployeeContactInfo.xls", "ElectionResults.doc", "CampaignContributions.xls", 
        "LibraryBudget.doc", "HealthDeptReport.doc", "PublicSafetySurvey.csv", "EmergencyPlans.doc", 
        "BudgetMeetingMinutes.txt"
    };
    std::string target = argv[1];

    for (const char* file : files) {
        tree.insert(file);
    }

    std::cout << "Simulating Cypher's potential path..." << std::endl;
    tree.search(target);

    return 0;
}
// FREEZE CODE END
```
