package lab2;
import lab2.DayInMonth;
import lab2.VerifyMonth;
public class testDay {

	public static void main(String[] args) {
		DayInMonth dim = new DayInMonth();
		
		VerifyMonth vm = new VerifyMonth();
		
		vm.Scan();
		
		dim.setYear(vm.getYear());
		dim.setMonth(vm.getMonth());
		
		System.out.println(dim.resolve());
	}

}
