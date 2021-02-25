package oop1;

import oop1.SecondDegreeEquation;
public class test3 {
	public static void main( String args[]) {
		SecondDegreeEquation sde = new SecondDegreeEquation();
		sde.setA(1);
		sde.setB(-2);
		sde.setC(1);
		System.out.println(sde.resolve());
	}

}
