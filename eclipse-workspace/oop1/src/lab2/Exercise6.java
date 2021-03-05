package lab2;
import java.util.*;
public class Exercise6 {
	public static int sum(int arr[]) {
		int sum = 0;
		for (int i = 0 ;i < arr.length ; i++)
			sum += arr[i];
		return sum;
	}
	public static double average(int arr[]) {
		return sum(arr)/arr.length ;
	}
	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in);
		System.out.println(" Input the length of array :");
		int n = keyboard.nextInt();
		int[] arr = new int[n] ;
		System.out.println("Input elements of array ");
		for (int i = 0 ; i < n ; i++)
			arr[i] = keyboard.nextInt();
		Arrays.sort(arr);
		System.out.println(Arrays.toString(arr));
		System.out.println("Sum = " +sum(arr));
		System.out.println("Average = "+average(arr));
	}
}
