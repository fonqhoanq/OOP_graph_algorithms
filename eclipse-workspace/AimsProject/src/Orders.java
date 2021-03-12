
public class Orders {
	public static final int MAX_NUMBERS_ORDERED = 10 ;
	private DigitalVideoDisc itemsOrdered[] = new DigitalVideoDisc[MAX_NUMBERS_ORDERED];
	private int qtyOrdered =0 ;
	public int getQtyOrdered() {
		return qtyOrdered;
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
