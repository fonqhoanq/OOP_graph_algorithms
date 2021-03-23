
public class Aims {
	public static void main(String[] args) {
		Orders anOrder = new Orders() ;
		DigitalVideoDisc dvd1 = new DigitalVideoDisc("The Lion King", "Animaton", "Roger Allers", 87, 19.95f);
		
		anOrder.addDigitalVideoDisc(dvd1);
		
		DigitalVideoDisc dvd2 = new DigitalVideoDisc("Star war", "Science", "George Lucas", 87, 24.95f);
		
		anOrder.addDigitalVideoDisc(dvd2);
		
		DigitalVideoDisc dvd3 = new DigitalVideoDisc("Aladin", "Anmation", 18.99f);
		anOrder.addDigitalVideoDisc(dvd3);
		anOrder.removeDigitalVideoDisc(dvd1);		
		System.out.print("Total Cost is: ");
		System.out.print(anOrder.totalCost());
	}
}
