package lab2;
public class  HeightOfNstars {
	private int n ;
	public void setN(int n) {
		this.n = n;
	}
	public int getN( ) {
		return this.n;
	}
	public void printNstars() {
		for (int i = 1 ; i <= n ; i++) {
			for (int j = 1 ; j <=2*n -1 ; j++) {
				if (j>= n - i + 1 && j <= n + i -1) {
					System.out.print('*');
				}
				else System.out.print(' ');
			}
			System.out.println();
		}
	}
}