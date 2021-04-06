package hust.soict.hedspi.aims.media;

public abstract class media {
	public  String title;
	public  String category;
	public  float cost;
	
	public media (String title) {
		this.title = title ;
	}
	
	public media(String title,String catetgory) {
		this(title) ;
		this.category = category ;
	}
	public media(String title,String category,float cost) {
		this.title = title ; 
		this.category = category ;
		this.cost = cost;
	}
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public float getCost() {
		return cost;
	}

	public void setCost(float cost) {
		this.cost = cost;
	}

	public abstract String displayInformation();
	
	
}
