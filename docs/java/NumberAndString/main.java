import java.util.*;
import java.lang.*;
import java.math.*;

class main {
  public static void main(String[] args) {
    Number n = 16;
    Byte m = 16;
    Integer k = 17;
    System.out.println(k.compareTo(k));
    System.out.println(k.equals(n));
    System.out.println(Integer.decode("0x16"));
    System.out.println(Integer.parseInt("16"));
    System.out.format("%d %d %d\n", n, m, k);
    Calendar c = Calendar.getInstance();
    System.out.format("%tB %te, %tY\n", c, c, c);
    System.out.format("%tl %tM %tp\n", c, c, c);
    System.out.format("%tD\n", c);
    BigInteger a = new BigInteger("123456");
    System.out.println(a.gcd(a));
    System.out.println(Math.random());
    Byte l = m;
    l++;
    System.out.println(m);
    Character ch = new Character('a'), chr = ch;
    chr = 'b';
    System.out.println(ch.isLetter('w'));
    String str = "hoho haha";
    char[] strch = new char[str.length()];
    str.getChars(0, str.length(), strch, 0);
    System.out.println(str.matches(""));
    StringBuilder sb = new StringBuilder("abc");
    sb.reverse();
    System.out.println(sb);
  }
}
