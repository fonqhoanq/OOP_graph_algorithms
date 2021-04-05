package hust.soict.hedspi.aims.media;
public class DigitalVideoDisc extends media {
	private String director;
	private int length ;
	public String displayInformation() {
		System.out.println(title+" "+category +" "+ director+" "+length+" "+cost);
		return null;
	}
	
	
	public String getDirector() {
		return director;
	}
	public int getLength() {
		return length;
	}
	
	
	
	public void setDirector(String director) {
		this.director = director;
	}
	public void setLength(int length) {
		this.length = length;
	}
	
	public DigitalVideoDisc(String title, String category, String director, int length, float cost) {
		super(title,category);
		this.director = director;
		this.length = length;
		this.cost = cost ;
		
	}
	public DigitalVideoDisc(String title) {
		super(title);
	}
	public DigitalVideoDisc(String title, String category, float cost) {
		super(title,category);
		this.cost = cost ;
		
	}
	public DigitalVideoDisc(String title, String category, String director, float cost) {
		super(title,category);
		this.director = director;
		this.cost = cost;
	}
	
	public boolean search(String title) {
		String[] words = title.toLowerCase().split(" ");
		String temp = this.getTitle().toLowerCase();
		if(title.equalsIgnoreCase(this.getTitle())) {
			return true;
		}else{
			for(int i = 0; i < words.length; i++) {
				if(!temp.contains(words[i])) {
					return false;
				}
			}
			return true;
		}
	}
	
	
}
