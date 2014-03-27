class main {
  public static void main(String[] args) {
    int f0 = 0, f1 = 1;
    for (int i = 0; i < 10000001; i++) {
      int temp = f1;
      f1 = (f0+f1)%1000000007;
      f0 = temp;
    }
    System.out.println(f1);
  }
}
