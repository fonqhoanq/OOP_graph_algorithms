package hust.soict.hedspi.aims.utils;

public class DateUtils {
	public static int convertToMonth(String month) {
		String[] monthArr = { "January", "February", "March", "April", "May", "June", "July", "August", "September",
				"October", "November", "December" };

		String[] abbreviation = { "Jan.", "Feb.", "Mar.", "Apr.", "May", "June", "July", "Aug.", "Sept.", "Oct.",
				"Nov.", "Dec." };
		String[] in3Letters = { "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
		String[] number = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };

		var i = 0;

		for (i = 0; i < 12; i++)
			if (month.equals(monthArr[i]) || month.equals(abbreviation[i])
					|| month.equals(in3Letters[i]) || month.equals(number[i])) {
				return i + 1;
			}
		
		return 0;

	}
	
	public static boolean isNumeric(String str) { 
		  try {  
		    Integer.parseInt(str);  
		    return false;
		  } catch(NumberFormatException e){  
		    return true;
		  }  
		}
	
	public static int convertToYear(String year) {
		if(isNumeric(year)) {
			System.out.println("year not valid");
			return 0;
		}
		return Integer.parseInt(year);
	}
	
	public static int convertToDay(String day) {
		if(isNumeric(day)) {
			System.out.println("day not valid");
			return 0;
		}
		return Integer.parseInt(day);
	}
	
	
	
	public static int compareTwDate(MyDate date1, MyDate date2) {
		String dateStr1 = date1.viewDate("yyyy-mm-dd");
		String dateStr2 = date2.viewDate("yyyy-mm-dd");
		return dateStr1.compareTo(dateStr2);
	}

	public static void sortDate(MyDate []dateArr) {
		for(int i = 0; i < dateArr.length - 1; i++) {
			for(int j = i + 1; j < dateArr.length; j++) {
				if(compareTwDate(dateArr[i], dateArr[j]) > 0) {
					MyDate tg = dateArr[i];
					dateArr[i] = dateArr[j];
					dateArr[j] = tg;
				}
			}
		}
	}
}