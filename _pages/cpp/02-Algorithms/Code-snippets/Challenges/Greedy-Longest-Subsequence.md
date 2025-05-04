# Recursion | Minimum Bills

Create the method `lcs` that takes two strings and returns an integer that represents the length of the longest common subsequence. Your algorithm should include dynamic programming and should be case sensitive.

```c++
// FREEZE CODE BEGIN
#include <iostream>
#include <string>
#include <algorithm>
// FREEZE CODE END

// WRITE YOUR CODE HERE
class LongestCommonSubsequence {
    public:
        static int lcs(std::string A, std::string B){
            // initiate a 2D array with len A and B
            int m = A.length();
            int n = B.length();
            int dp[m + 1][n + 1];

            // Loop through each cell ?
            for (int i = 0; i <= m; i++) {
                for (int j = 0; j <= n; j++) {
                    // base case
                    if (i == 0 || j == 0) {
                        dp[i][j] = 0;
                    }
                    // if the corresponding chars are equal
                    else if(A[i-1] == B[j-1]) {
                        dp[i][j] = dp[i-1][j-1] + 1;
                    }
                    else {
                        dp[i][j] = std::max(dp[i-1][j], dp[i][j-1]);
                    }
                }
            }
            return dp[m][n];
        }
};


// FREEZE CODE BEGIN          
int main() {
    std::string sequence1 = "AB13cD90azK";
    std::string sequence2 = "zAB173QdK80";

    int lengthOfLCS = LongestCommonSubsequence::lcs(sequence1, sequence2);
    std::cout << "The length of the Longest Common Subsequence is: " << lengthOfLCS << std::endl;

    return 0;
}
// FREEZE CODE END
```