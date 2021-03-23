package aim ;

public class Orders {
	public static final int MAX_NUMBERS_ORDERED = 10 ;
	private DigitalVideoDisc itemsOrdered[] = new DigitalVideoDisc[MAX_NUMBERS_ORDERED];
	private int qtyOrdered =0 ;
	private MyDate dateOrdered ;
	private static int nbOrders = 0;
	//public Orders(MyDate dateOrdered) {
	//	super();
	//	this.dateOrdered = dateOrdered;
	//}

	public int getQtyOrdered() {
		return qtyOrdered;
	}
	
	public void setQtyOrdered(int qtyOrdered) {
		this.qtyOrdered = qtyOrdered;
	}

	public void addDigitalVideoDisc(DigitalVideoDisc disc) {
		if (qtyOrdered == MAX_NUMBERS_ORDERED) {
			System.out.println("order was full");
		}
		else {
			qtyOrdered ++ ;
			itemsOrdered[qtyOrdered-1] = disc ;
		}
	}
	public void addDigitalVideoDisc(DigitalVideoDisc[] dvdList) {
		int n = dvdList.length;
		for (int i = 0; i < n ; i++) {
			if (qtyOrdered <= MAX_NUMBERS_ORDERED) {
				itemsOrdered[qtyOrdered] = dvdList[i] ;
				qtyOrdered ++;
			}
			else {
				System.out.println("order was full");
			}
		}
	}
	public void addDigitalVideoDisc(DigitalVideoDisc dvd1,DigitalVideoDisc dvd2) {
		if (qtyOrdered <= MAX_NUMBERS_ORDERED) {
			itemsOrdered[qtyOrdered] = dvd1 ;
			qtyOrdered ++;
		}
		else {
			System.out.println("order was full");
		}
		if (qtyOrdered <= MAX_NUMBERS_ORDERED) {
			itemsOrdered[qtyOrdered] = dvd2 ;
			qtyOrdered ++;
		}
		else {
			System.out.println("order was full");
		}
	}
	public void removeDigitalVideoDisc(DigitalVideoDisc disc) {
		int i,c;
		for (c=i=0; i<qtyOrdered; i++) {
			if (itemsOrdered[i].getTitle() != disc.getTitle()) {
				itemsOrdered[c] = itemsOrdered[i] ;
				c++;
			}
		}
		qtyOrdered = c;
		System.out.println("remove successfully");
	}
	public float totalCost() {
		float sum = 0;
		for (int i = 0; i <qtyOrdered ; i++) {
			sum += itemsOrdered[i].getCost() ;
		}
		return sum;
	}
}
