package oop1;
import javax.swing.JOptionPane;
public class HelloNameDialog {
	public static void main(Sring[] args) {
		String result;
		result = JOptionPane.showInputDialog("Please enter your name");
		JOptionPane.showMessageDialog(null,"hi " + result );
		System.exit(0);
	}

}
