package oop1;

public class SystemFirstDegreeEquation {
	private int a,b,c,i,j,k;
	private int d,d1,d2;
	public int getA() {
		return this.a;
	}
	public int getB() {
		return this.b;
	}
	public int getC() {
		return this.c;
	}
	public int getI() {
		return this.i;
	}
	public int getJ() {
		return this.j;
	}
	public int getK() {
		return this.k;
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
	public void setI(int i) {
		this.i = i;
	}
	public void setJ(int j) {
		this.j = j;
	}
	public void setK(int k) {
		this.k = k;
	}
	public String resolve() {
		d = a*j - i*b ;
		d1 = c*j - b*k ;
		d2 = a*k - c*i;
		if (d != 0 ) {
			return ("he pt co hai nghiem :" + (double) d1/d + "va " + (double) d2/d);
		}
		else if (d == 0 && d1 == 0 && d2 == 0) {
			return ("he pt co vo so nghiem");
		}
		else {
			return ("he pt vo nghiem");
		}
	}

}
