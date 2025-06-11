class Soojebi{
    public static void main(String[] args){
        int [][]arr = new int[3][3];

        init(arr);
        hourGlass(arr);
        arrayPrint(arr);
    }
    public static void init(int arr[][]){
        for(int i=0; i<arr.length;i++){
            for(int j=0; j<arr[0].length; j++){
                arr[i][j] = 0;
            }
        }
    }
    public static void hourGlass(int arr[][]){
        int v = 0;
        for(int i=0; i<arr.length; i++){
            for(int j=i; j<arr[0].length; j++){
                arr[i][j] = ++v;
            }
        }
    }
    public static void arrayPrint(int arr[][]){
        for(int i=0; i<arr.length; i++){
            for(int j=0; j<arr[0].length; j++){
                if(arr[i][j] == 0){
                    System.out.print(" ");
                }else{
                    System.out.print(arr[i][j]);
                }
            }
            System.out.print("");
        }
    }
}