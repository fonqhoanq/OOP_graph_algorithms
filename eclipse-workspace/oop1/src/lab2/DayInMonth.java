package lab2;

public class DayInMonth {
	private int month;
	private int year;
	public void setYear(int year) {
		this.year = year ;
	}
	public int getYear() {
		return this.year ;
	}
	public void setMonth(int month) {
		this.month = month ;
	}
	public int getMonth() {
		return this.month ;
	}
	public boolean check(int arr[],int k) {
		for (int i = 0; i < arr.length ; i++)
			if (arr[i] == k) return true ;
		return false;
	}
	public String resolve() {
		int[] arr= {1,3,5,7,8,10,12};
		if (year % 4 == 0 && month == 2 )
		{
			if (year % 100 != 0 || year % 400 == 0)
				return ("29 days");
		}
		else if (month == 2) return ("28 days");
		if (check(arr,month) == true ) return ("31 days");
		else return ("30 days");
		
	}
}
