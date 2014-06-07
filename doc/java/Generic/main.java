import java.util.*;
import java.lang.*;
import java.math.*;

class main {
  static class Box<T extends Number> {
    T d;
    public void set (T t) { d = t; }
    public T get() { return d; }
  }
  static class Utils {
    // upperBound
    // static void foreach(List<? extends Number> list) {}
    // unBounded
    // static void foreach(List<?> list) {}
    // lowerBound
    static void foreach(List<? super Number> list) {}
    void foo(List<?> i) {
      fooHelper(i);
    }
    // originalMethodNameHelper
    private <T> void fooHelper(List<T> l) {
      l.set(0, l.get(0));
    }
  }
  public static void main(String[] args) {
    List<String> list = new ArrayList<>();
    list.add("hello");
    String sb = list.get(0);
    Box<BigInteger> box = new Box<>();
    box.set(new BigInteger("11"));
    BigInteger ss = box.get();
//     List<BigInteger> ilist = new ArrayList<>();
//     List<String> slist = new ArrayList<>();
//     Utils.foreach(ilist);
//     Utils.foreach(slist);
    List<Number> nlist = new ArrayList<>();
    Utils.foreach(nlist);
    List<?> qlist = nlist;
  }
}
