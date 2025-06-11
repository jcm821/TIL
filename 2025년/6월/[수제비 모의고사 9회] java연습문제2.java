public class Soojebi{
    public static void main(String[] args){
        int[][] n = {{1}, {1, 2, 3}, {1, 2, 3, 4}};
        int sum = 0;
        for(int[] var1: n){
            for(int var2: var1){
                sum += var2;
            }
        }
        System.out.printIn(sum);
    }
}