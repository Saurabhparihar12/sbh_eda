#include <iostream>
#include <vector>
using namespace std;

int main() 
{
    int n;
    cin >> n;

    vector<int> p(n + 1);
    for (int i = 0; i < n; i++)
    {
        int a, b;
        cin >> a >> b;
        p[i] = a;
        if (i == n - 1) p[i + 1] = b;
    }

    vector<vector<int>> dp(n, vector<int>(n, 0));

    for (int l = 2; l <= n; l++) 
    {
        for (int i = 0; i <= n - l; i++) 
        {
            int j = i + l - 1;
            dp[i][j] = 1e9;
            for (int k = i; k < j; k++) 
            {
                int cost = dp[i][k] + dp[k + 1][j] + p[i] * p[k + 1] * p[j + 1];
                if (cost < dp[i][j])
                    dp[i][j] = cost;
            }
        }
    }

    cout << dp[0][n - 1] << endl;
    return 0;
}
