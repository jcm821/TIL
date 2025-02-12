class Book{
    String name = '수험서';
    void getPrice(String name){
        System.out.print('name : ' + name);
    }
}
class Price extends Book{
    String price = '10,000원';
    void getPrice(String name){
        super.getPrice(name);
        System.out.print('price : ' + price);
    }
}
class Soojebi{
    public static void main(String[] args){
        Book b = new Price();
        b.getPrice('정보처리기사');
    }
}