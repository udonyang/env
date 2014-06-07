class main {
  class A {
  };
  interface C {}
  class B extends A implements C {
  };
  public C test() {
    B b = new B();
    return b;
  }
  public static void main(String[] args) {
  }
}
