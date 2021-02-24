package oop1;

import oop1.FirstDegreeEquation;
public class test {
	public static void main(String args[]) {
		FirstDegreeEquation fde = new FirstDegreeEquation();
		fde.setA(8);
		fde.setB(9);
		System.out.println(fde.resolve());
	}

}
