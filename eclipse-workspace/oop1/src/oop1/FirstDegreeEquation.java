package oop1;

public class FirstDegreeEquation {
	private int a;
	private int b;
	private int c;
	
	public int getA() {
		return this.a;
	}
	public int getB( ) {
		return this.b;
	}

	public void setA(int a) {
		this.a=a;
	}
	public void setB(int b) {
		this.b=b;
	}
	public String resolve() {
		if (a==0 && b==0) {
			return ("vo so nghiem");
		} else if (a==0 && b!=0) {
			return ("vo nghiem");
		} else {
			return ("nghiem la :" + (double) -b/a);
		}
	}
}
