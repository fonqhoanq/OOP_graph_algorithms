package aim;
public class TestPassingParameter {

	public static void main(String[] args) {
		DigitalVideoDisc jungleDVD = new DigitalVideoDisc("Jungle");
		DigitalVideoDisc cinderellaDVD = new DigitalVideoDisc("Cinderella");
		
		swap(jungleDVD,cinderellaDVD);
		System.out.println("jungle dvd title" + jungleDVD.getTitle());
		System.out.println("cinderella dvd title" + cinderellaDVD.getTitle());
		changeTitle(jungleDVD,cinderellaDVD.getTitle());
		System.out.println("jungle dvd title" + jungleDVD.getTitle());
		
	}
	public static void copyDiscData(DigitalVideoDisc discDes, DigitalVideoDisc disc) {
		discDes.setTitle(disc.getTitle());
		discDes.setCategory(disc.getCategory());
		discDes.setCost(disc.getCost());
		discDes.setDirector(disc.getDirector());
		discDes.setLength(disc.getLength());
	}

	public static void swap(DigitalVideoDisc o1, DigitalVideoDisc o2) {
		DigitalVideoDisc tmp = new DigitalVideoDisc();

		copyDiscData(tmp, o1);
		copyDiscData(o1, o2);
		copyDiscData(o2, tmp);
	}	
	public static void changeTitle(DigitalVideoDisc dvd,String title) {
			String oldTitle = dvd.getTitle();
			dvd.setTitle(title);
			dvd = new DigitalVideoDisc(oldTitle);
		}
		
	}


