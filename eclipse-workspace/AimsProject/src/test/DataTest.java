package test;
import	utils.*;
import 	aim.*;
public class DataTest {
	public static void main(String[] args) {
        MyDate date1 = new MyDate(20, 2, 2000);
        MyDate date2 = new MyDate("20", "Feb", "2002");
        MyDate date3 = new MyDate(21, 2, 2000);
        MyDate arr[] = new MyDate[3];
        arr[0] = date1;
        arr[1] = date2;
        arr[2] = date3;
        for(int i = 0; i < arr.length; i++) {
            arr[i].print();
        }
        DateUtils.sortDate(arr);
        for(int i = 0; i < arr.length; i++) {
            arr[i].print();
        }
    }
}
