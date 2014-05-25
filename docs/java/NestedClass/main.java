class main {
  public static String x = "a";
  public static class A {
    private static String x = "b";
    public void go(String x) {
      System.out.println(main.this.x+this.x+x);
    }
  } 
  public static void main(String[] args) {
    A a = new A();
    a.go("c");
  }
}
