package hust.soict.hedspi.aims.utils;
import hust.soict.hedspi.aims.utils.DateUtils;
public class MyDate {
	private int day;
	private int month;
	private int year;
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public MyDate() {
		
	};
	public MyDate(String day, String month, String year) {
		super();
		this.day = DateUtils.convertToDay(day);
		this.month = DateUtils.convertToMonth(month);
		this.year = DateUtils.convertToYear(year);
	}
	
	public MyDate(int day, int month, int year) {
		super();
		this.day = day;
		this.month = month;
		this.year = year;
	}
	public void print() {
		String dayStr;
		String monthStr;
		String yearStr;

		if(this.day == 0) {
			return;
		}

		switch (this.day) {
		case 1: {
			dayStr = "1st";
			break;
		}
		case 2: {
			dayStr = "2nd";
			break;
		}
		case 3: {
			dayStr = "3rd";
			break;
		}
		default:
			dayStr = String.valueOf(this.day) + "th";
		}
		
		String[] monthArr = { "January", "February", "March", "April", "May", "June", "July", "August", "September",
				"October", "November", "December" };
		monthStr = monthArr[this.month- 1];
		yearStr = String.valueOf(this.year);
		
		//System.out.println(monthStr + " " + dayStr + " " + yearStr);
		
	}
	public String viewDate(String format) {
		String output = new String();
		switch (format) {
			case "yyyy-mm-dd": {
				output = String.format("%d-%d-%d", year, month, day);
				System.out.println(output);
				break;
			}

			case "dd-mm-yyyy": {
				output = String.format("%d-%d-%d", day, month, year);
				break;
			}

			default:
			{
				System.out.println("format not valid");
				return null;
			}
		}
		return output;
	}
}
