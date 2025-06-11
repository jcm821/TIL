#include <stdio.h>
int Soojebi(int num) {
    int i;
    for(i=2; i<num; i++){
        if(num % i == 0)
            return 0;
    }
    return 1;
}
int main() {
    int num=10, cnt=0,i;
    for(i=2, i<num; i++)
        cnt += Soojebi(i);
    printf("%d\n", cnt);
}