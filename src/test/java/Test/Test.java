package Test;

public class Test {
	public static void main(String[] args) {
		Test t = new Test();
		int i = 0;
		t.x(i);
		System.out.println(i);
		System.out.println("_____");
		i = i++;
		System.out.println(i);
	}
	void x(int i) {
		i++;
	}
}
