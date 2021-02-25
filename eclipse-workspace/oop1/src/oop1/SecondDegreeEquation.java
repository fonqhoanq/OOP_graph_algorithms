package oop1;

public class SecondDegreeEquation {
	private int a,b,c;
	private int delta;
	public int getA() {
		return this.a;
	}
	public int getB() {
		return this.b;
	}
	public int getC() {
		return this.c;
	}
	public void setA(int a) {
		this.a = a;
	}
	public void setB(int b) {
		this.b = b;
	}
	public void setC(int c) {
		this.c = c;
	}
	public String resolve() {
		delta = b*b - 4*a*c ;
		if (delta == 0) {
			return ("phuong trinh co nghiem kep : " + (double) -b/(2*a));
		}
		else if (delta < 0 ) {
			return ("phuong trinh vo nghiem");
		}
		else {
			return ("phuong trinh co hai nghiem phan biet :" +(double)  (b*(-1) + Math.sqrt(delta))/2*a + "va" + (double) (b*(-1) - Math.sqrt(delta))/2*a );
		}
	}

}
