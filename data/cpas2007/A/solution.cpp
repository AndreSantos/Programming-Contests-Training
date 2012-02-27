#include<iostream>
using namespace std;

int main() {
    string s;
    cin >> s;
    
    int t = s[0] - '0' + (s[1] - '0') * 3 + (s[2] - '0') * 5;
    cout << s[0] << s[1] << s[2] << (t % 7) << endl;
    return 0;
}
