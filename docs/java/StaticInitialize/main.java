class main {
  private static String a, b, c, d;
  private String e, f, g, h;
  static {
    a = "a";
    b = "b";
    c = "c";
    d = "d";
  }
  {
    e = f = g = h = "e";
  }
  public static void main(String[] args) {
    System.out.println(a+b+c+d);
  }
}
