package hust.soict.hedspi.aims;

import java.awt.List;
import java.util.ArrayList;
import java.util.Scanner;

import hust.soict.hedspi.aims.media.DigitalVideoDisc;
import hust.soict.hedspi.aims.media.book;
import hust.soict.hedspi.aims.media.media;
import hust.soict.hedspi.aims.order.Orders;

public class Aims {

	public static void main(String[] args) {
/*		// TODO Auto-generated method stub

		if(Orders.checkLimitedOrdered()) {
			MyDate date1 = new MyDate(20, 02, 2000);
			Orders anOrder = new Orders(date1);
			DigitalVideoDisc disc1 = new DigitalVideoDisc("The Lion King", "Animation", "Roger Allers", 87, 19.95f);


			DigitalVideoDisc disc2 = new DigitalVideoDisc("Star Wars", "SF", "George Lucas", 87, 24.95f);
			DigitalVideoDisc disc3 = new DigitalVideoDisc("Aladin", "Animation", 18.99f);
			DigitalVideoDisc [] discArr = {disc1, disc2, disc3};
			//anOrder.addDigitalVideoDisc(discArr);
			//anOrder.print();
			System.out.println(disc2.search("stark"));
		}

	}*/
		showMenu();
	}
	

	public static void showMenu() {
		int id ;
		Orders anOrder = new Orders();
		Scanner sc = new Scanner(System.in);
		do {
			System.out.println("Order Management Application: ");
			System.out.println("-----------------------------");
			System.out.println("1. Create new order");
			System.out.println("2.Add item to the order");
			System.out.println("3.Delete item by id");
			System.out.println("4.Display the items list of order");
			System.out.println("0.Exit");
			System.out.println("------------------------------");
			System.out.println("Please choose a number 0-1-2-3-4");
		
			id = sc.nextInt();
			switch (id) {
			case 1 :
				//Orders anOrder = new Orders();
				break;
			case 2:
				media dvd1 = new DigitalVideoDisc("The Lion King", "Animation", "Roger Allers", 87, 19.95f);
				media book1 = new book("math4","science");
				List<String> authors = new ArrayList<String>();
				author.add("luong the vinh");
				
				anOrder.addMedia(dvd1);
				anOrder.addMedia(book1);
				anOrder.printOrder();
				
				break;
			
				
				
				
			}
			
		} while (id != 0);
	}
}


