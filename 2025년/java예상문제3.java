public class Soojebi{
    public static void main(String[] args){
        int[] a = {56, 4, 3, 65, 78};
        int temp;
        for (int i = 0; i < 1; i++) {
            for(int j = 0; j < a.length-i-1; j++) {
                if(a[j] > a[j + 1]) {
                    temp = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = temp;
                }
            }
        }
        for(int i = 0; i < a.length; i++) {
            System.out.print(a[i] + " ");
        }
    }
}