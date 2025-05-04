---
title: "Longest Common Subsequence (LCS)"
---

Suppose we are trying to find the length of the longest common subsequence between two strings A and B. A subsequence is a sequence of characters that appear in the same order in the string, but not necessarily consecutively. For example, look at the following strings:

    "BACBDAB"
    "BDCAB"

By using a 2D array, we have eliminated the need for redundant calculations, and this program will run in $O(m*n)$ time, which is much more efficient than the naive recursive approach.

```c++
#include <iostream>
#include <string>
#include <algorithm>

int longestCommonSubsequence(std::string A, std::string B) {
    // Get the length of each input string.
    int m = A.length();
    int n = B.length();
    
    // Initialize a 2D array to store the LCS lengths.
    // dp[i][j] will contain the length of LCS of prefixes A[0..i-1] and B[0..j-1].
    int dp[m + 1][n + 1];
    
    // Loop through each cell in the 2D array.
    for(int i = 0; i <= m; i++) {
        for(int j = 0; j <= n; j++) {
            // Base case: If either of the strings is empty, LCS length is 0.
            if(i == 0 || j == 0) {
                dp[i][j] = 0;
            }
            // If the corresponding characters in A and B are equal,
            // then we can extend the LCS for A[0..i-2] and B[0..j-2] by 1.
            else if(A[i-1] == B[j-1]) {
                dp[i][j] = dp[i-1][j-1] + 1;
            }
            // If the corresponding characters in A and B are different,
            // take the maximum LCS length between A[0..i-1] & B[0..j-2] or A[0..i-2] & B[0..j-1].
            else {
                dp[i][j] = std::max(dp[i-1][j], dp[i][j-1]);
            }
        }
    }
    
    // The value at dp[m][n] contains the length of LCS for A and B.
    return dp[m][n];
}

int main() {
    // Example strings A and B.
    std::string A = "BACBDAB";
    std::string B = "BDCAB";
    
    // Calculate and print the length of LCS.
    std::cout << "Length of LCS: " << longestCommonSubsequence(A, B) << std::endl;
    
    return 0;
}
```