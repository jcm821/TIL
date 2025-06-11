public class Soojebi {
    public static void main(String[] args){
        int[] arr = {3, 4, 10, 2, 5}; // 5개의 정수로 이루어진 배열 선언
        int tmp; // 임시로 값을 저장할 변수

        // 배열을 정렬하는 이중 for문
        for(int i=0; i<=3; i++) { // i는 0~3까지 반복
            for(int j=i+1; j=4; j++) { // j는 i+1부터 4까지 반복 (오타 있음)
                if(arr[i] < arr[j]){ // arr[i]가 arr[j]보다 작으면
                    temp = arr[i]; // temp에 arr[i] 저장 (오타: 변수명 일치 X)
                    arr[i] = arr[j]; // arr[i]에 arr[j]값 저장
                    arr[j] = temp; // arr[j]에 temp값 저장
                }
            }
        }

        // 정렬된 배열 출력
        for(int i=0; i<5; i++)
            System.out.print(arr[i] + " ");
    }
}

