package hust.soict.hedspi.aims;

import hust.soict.hedspi.aims.disc.DigitalVideoDisc;
import hust.soict.hedspi.aims.order.Orders;
import hust.soict.hedspi.aims.utils.MyDate;

public class Aims {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		if(Orders.checkLimitedOrdered()) {
			MyDate date1 = new MyDate(20, 02, 2000);
			Orders anOrder = new Orders(date1);
			DigitalVideoDisc disc1 = new DigitalVideoDisc("The Lion King", "Animation", "Roger Allers", 87, 19.95f);


			DigitalVideoDisc disc2 = new DigitalVideoDisc("Star Wars", "SF", "George Lucas", 87, 24.95f);
			DigitalVideoDisc disc3 = new DigitalVideoDisc("Aladin", "Animation", 18.99f);
			DigitalVideoDisc [] discArr = {disc1, disc2, disc3};
			anOrder.addDigitalVideoDisc(discArr);
			anOrder.print();
		}


	}


}
