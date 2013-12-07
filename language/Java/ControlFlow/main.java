class main {
  public static void main(String[] args) {
    int x = 10, y = x;
    y = 11;
    System.out.println("\t"+x);
haha:
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++) {
        System.out.println(i);
        break haha;
      }
haha:
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++) {
        System.out.println(i);
        continue haha;
      }
  }
}
