class main {
  interface Yycin {
    String get();
  }
  public static void main(String[] args) {
    Yycin a = new Yycin() {
      public static final String x = "yycin";
      public String get() {
        return x;
      }
    };
    System.out.println(a.get());
  }
}
