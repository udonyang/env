import java.util.*;

class main {
  public static void main(String[] args) {
    // test 1
    int[] as = new int[10];
    for (int i = 0; i < 10; i++) as[i] = i;
    for (int i: as) System.out.println(as[i]);
    int[] bs = as;
    for (int i = 0; i < 10; i++) bs[i] = (15+i)%10;
    for (int i: as) System.out.println(i);
    // test 2
    int[][] ass = new int[10][10];
    for (int[] i: ass) {
      for (int j: i)
          System.out.print(j);
      System.out.println("");
    }
    // test 3
    int[] cs = Arrays.copyOfRange(as, 0, 10);
    for (int i: cs) System.out.println(i);
    if (Arrays.equals(cs, as))
      System.out.println(Arrays.binarySearch(cs, 2));
    Arrays.sort(cs, 0, 10);
  }
}
