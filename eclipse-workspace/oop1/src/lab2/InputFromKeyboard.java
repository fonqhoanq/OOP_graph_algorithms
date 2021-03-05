package lab2;
import java.util.Scanner;
public class InputFromKeyboard {
	public static void main (String args[]) {
		Scanner keyboard = new Scanner(System.in);
		
		System.out.println("what is your name");
		String strname = keyboard.nextLine();
		System.out.println("how old");
		int iage = keyboard.nextInt();
		System.out.println("tall");
		double dheight = keyboard.nextDouble();
		System.out.println("mr/mrs" + strname + iage + "years old" + dheight );
	}
}
