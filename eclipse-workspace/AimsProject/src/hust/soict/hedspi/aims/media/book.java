package hust.soict.hedspi.aims.media;

import java.util.ArrayList;
import java.util.List;

public class book extends media {
	private List<String> authors = new ArrayList<String>();
	public String displayInformation() {
		System.out.println(title+" "+category );
		return null;
	}
	public void addAuthor(String authorName) {
		authors.add(authorName);
	}
	public void removeAuthor(String authorName) {
		if (authors.isEmpty()) {
			System.out.println("can't remove author");
		}
		else {
			authors.remove(authorName);
		}
	}
	public book(String title) {
		super(title);
	}
	public book(String title,String category) {
		super(title);
		this.category = category ;
	}
	public book(String title, String category,List<String> authors) {
		super(title,category);
		this.authors = authors;
	}
	
}
