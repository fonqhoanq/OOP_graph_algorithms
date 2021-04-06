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
		Orders anOrder = null  ;
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
				System.out.println("Create new order successfully");
				anOrder = new Orders();
				break;
			case 2:
				DigitalVideoDisc dvd1 = new DigitalVideoDisc("The Lion King", "Animation", "Roger Allers", 87, 19.95f);
				book book1 = new book("math4","science",18.70f);
				book1.addAuthor("pham hoang anh");
				book1.addAuthor("hoang trung phong");
				
				ArrayList<String> authors = new ArrayList<String>();
				authors.add("nguyen du");
				authors.add("ho chi minh");
				book book2 = new book("truyen kieu","van chuong" ,authors,20.5f);
				DigitalVideoDisc dvd2 = new DigitalVideoDisc("Star Wars", "SF", "George Lucas", 87, 24.95f);

				anOrder.addMedia(dvd1);
				anOrder.addMedia(book1);
				anOrder.addMedia(book2);
				anOrder.addMedia(dvd2);
				anOrder.printOrder();
				
				break;
			case 3:
				DigitalVideoDisc dvd21 = new DigitalVideoDisc("Star Wars", "SF", "George Lucas", 87, 24.95f);
				anOrder.removeMedia(dvd21);
				anOrder.printOrder();
				break;
			case 4 :
				anOrder.printOrder();
				break;
			}
			
		} while (id != 0);
	}
}


