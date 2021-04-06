package hust.soict.hedspi.aims.order;

import java.util.ArrayList;

import hust.soict.hedspi.aims.media.DigitalVideoDisc;
import hust.soict.hedspi.aims.media.media;
import hust.soict.hedspi.aims.utils.MyDate;
public class Orders {
	private ArrayList<media> itemsOrdered = new ArrayList<media>();
	public static final int MAX_LIMITTED_ORDERED = 4;
	public static final int MAX_NUMBERS_ORDERED = 10 ;
	private int qtyOrdered =0 ;
	private MyDate dateOrdered ;
	private static int nbOrders = 0;
	//public Orders(MyDate dateOrdered) {
	//	super();
	//	this.dateOrdered = dateOrdered;
	//}
	public void printOrder() {
		for (int i=0 ; i < itemsOrdered.size(); i++)
			itemsOrdered.get(i).displayInformation();
	}
	public void addMedia(media med) {
		if (itemsOrdered.contains(med) == false) {
			itemsOrdered.add(med);
			System.out.println("add successfully");		
		}
	}
	public void removeMedia(media med) {
		if (itemsOrdered.isEmpty()) {
			System.out.println("Order is empty");
		} 
		for (int i = 0 ; i < itemsOrdered.size() ; i++) {
			if (itemsOrdered.get(i).getTitle() == med.getTitle() ) {
				itemsOrdered.remove(i);
				System.out.println("remove successfully");
			}
		}
	}
	public static boolean checkLimitedOrdered() {
		return nbOrders < MAX_LIMITTED_ORDERED;
	}
	public Orders(MyDate today) {
		Orders.nbOrders++;
		this.dateOrdered = today;
	}
	public Orders() {
		
	}
	public int getQtyOrdered() {
		return qtyOrdered;
	}
	
	public void setQtyOrdered(int qtyOrdered) {
		this.qtyOrdered = qtyOrdered;
	}

	public float totalCost() {
		float sum = 0;
		for (int i = 0 ; i < itemsOrdered.size() ; i++) {
			sum += itemsOrdered.get(i).getCost();
		}
		return sum ;
	}
	/*public void print() {
		System.out.println("***********************Order***********************");
		System.out.print("Date: ");
		dateOrdered.viewDate("yyyy-mm-dd");
		System.out.println();
		System.out.println("Ordered Items");
		if(qtyOrdered != 0) {
			for(int i = 0; i < qtyOrdered; i++) {
				this.itemsOrdered[i].viewDVD();
			}
		}
		System.out.println("Total cost: " + totalCost());
		System.out.println("**************************************************");
	}
	public DigitalVideoDisc getALuckyItem() {
		double randomDouble = Math.random();
		randomDouble = randomDouble * 1000;
		int randomInt = (int) randomDouble % qtyOrdered;
		return itemsOrdered[randomInt];
	}
	public void setFreeItems() {
		DigitalVideoDisc freeItem = getALuckyItem();
		freeItem.setCost(0f);
	}*/
}
