package oop1;

import oop1.SystemFirstDegreeEquation;
public class test1 {
	public static void main(String args[]) {
		SystemFirstDegreeEquation sfde = new SystemFirstDegreeEquation();
		sfde.setA(1);
		sfde.setB(2);
		sfde.setC(3);
		sfde.setI(4);
		sfde.setJ(5);
		sfde.setK(6);
		System.out.println(sfde.resolve());
	}

}
