package lab2;
import lab2.HeightOfNstars;
import java.util.Scanner;
public class testnstars {

	public static void main(String[] args) {
		HeightOfNstars hos = new HeightOfNstars() ;
		Scanner keyboard = new Scanner(System.in);
		System.out.println("moi nhap n:");
		int n = keyboard.nextInt();
		hos.setN(n);
		hos.printNstars();

	}

}
