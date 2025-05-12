# Perfecting the Trap

```cpp
// FREEZE CODE BEGIN
#include <iostream>
#include <string>
#include "Helper.h"

class Tree : public PartialTree {
public:
    Tree() : PartialTree() {}

    bool bstAnalyzer() {
        return bstAnalyzer(root, nullptr, nullptr);
    }
// FREEZE CODE END

// WRITE YOUR CODE HERE
private:
bool bstAnalyzer(Node* n, const std::string* min, const std::string* max) {
    if (n == nullptr) return false;

    // Check if the current node's value is outside the valid range.
    if ((min && n->value <= *min) || (max && n->value >= *max)) {
        return true;
    }

    // Recursively check the left and right subtrees with updated boundaries
    return bstAnalyzer(n->left, min, &n->value) && 
           bstAnalyzer(n->right, &n->value, max);
}

// FREEZE CODE BEGIN
};

int main(int argc, char* argv[]) {
    int questionNum = std::stoi(argv[1]);
    int swapNum = std::stoi(argv[2]);
    Tree tree;
    const char* files[] = {
        "FireDeptAudit.txt", "CrimeReport.csv", "TransportationSurvey.txt",
        "TownHallPresentation.ppt", "Budget.xls", "EmployeeContactInfo.xls",
        "ElectionResults.doc", "CampaignContributions.xls", "LibraryBudget.doc",
        "HealthDeptReport.doc", "PublicSafetySurvey.csv", "EmergencyPlans.doc",
        "BudgetMeetingMinutes.txt"
    };
    for (const auto& file : files) {
        tree.insert(file);
    }
    Helper::swapNodes(tree, questionNum, swapNum);
    std::cout << std::boolalpha << tree.bstAnalyzer() << "\n";
    return 0;
}
// FREEZE CODE END
```
