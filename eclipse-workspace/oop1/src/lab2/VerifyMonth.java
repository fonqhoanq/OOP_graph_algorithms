package lab2;
import java.util.Scanner;
public class VerifyMonth {
	private int month ;
	private int year ; 
	String input ;
	public void Scan() {
		Scanner keyboard = new Scanner(System.in) ;
		
		System.out.println("Year :");
		input = keyboard.nextLine();
		year = Integer.parseInt(input);
		
		System.out.println("Month: ");
		input = keyboard.nextLine();
		if (isNumeric(input))  {
			month = Integer.parseInt(input);
		}
		else month = verify (input);
		
	}
	
	public boolean isNumeric(String str) {
		return str.matches("-?\\d+(\\.\\d+)?");
	}
	
	public int verify(String s) {
		String[] m = {"January","February","March","April","May","June","July","August",
				"September","October","November","December"};
		
		for (int i = 0 ;i < m.length ; i++) {
			if (m[i].contains(s) == true ) return i+1 ;
		}
		
		return 0 ;
		
	}
	public int getYear() {
		return this.year;
	}
	public int getMonth() {
		return this.month ;
	}
}
