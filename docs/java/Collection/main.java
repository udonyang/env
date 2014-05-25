import java.util.*;
import java.lang.*;
import java.math.*;
import java.io.*;

class Name implements Comparable<Name> {
  private final String firstName, lastName;
  public Name(String firstName, String lastName) {
    if (firstName == null || lastName == null)
      throw new NullPointerException();
    this.firstName = firstName;
    this.lastName = lastName;
  }
  public String firstName() { return firstName; }
  public String lastName() { return lastName; }
  public int compareTo(Name n) {
    int lastCmp = lastName.compareTo(n.lastName);
    return lastCmp != 0? lastCmp: firstName.compareTo(n.firstName);
  }
  public int hashCode() {
    return 31*firstName.hashCode()+lastName.hashCode();
  }
  public boolean equals(Object o) {
    if (!(o instanceof Name)) return false;
    Name n = (Name)o;
    return n.firstName.equals(firstName) && n.lastName.equals(lastName);
  }
  public String toString() {
    return firstName+" "+lastName;
  }
}

public class main {
  static Name[] ns = {
    new Name("Wudong", "Yang"),
    new Name("Keli", "Zhang"),
    new Name("Yongzheng", "Fu"),
    new Name("Xun", "Cai"),
    new Name("Yongqiu", "Yang"),
    new Name("Zhengpeng", "Deng"),
    new Name("Minghui", "Zhang")
  };
  static String[] ss = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
  static Integer[] xs = {6, 5, 2, 1, 3, 5, 6, 4, 6, 2, 6};
  static PrintStream cout = System.out;
  static Collections alg; 
  static Arrays arr;
  static void collection() {
    List<String> a = new ArrayList<>();
    String[] c = {"1", "2", "3", "4"};
    List<String> b = Arrays.asList(c);
    a.addAll(b);
    for (String i: a) System.out.println(i);
    for (Iterator<?> it = a.iterator(); it.hasNext(); ) {
      System.out.println(it.next());
    }
    String[] c2 = new String[b.size()];
    Arrays.asList(c).toArray(c2);
    System.out.println(b.contains(Arrays.asList(c2).get(0)));
  }
  static void set() {
    Set<Integer> s = new LinkedHashSet<>(Arrays.asList(xs));
    for (int i: xs) s.remove(i);
    for (int i: xs) cout.println(s.add(i));
    Object[] ys = s.toArray();
    for (Object i: ys) cout.println((Integer)i);
  }
  static void list() {
    List<Integer> l = new ArrayList<>(Arrays.asList(xs));
    Collections.swap(l, 0, 5);
    Collections.sort(l);
    // for (int i: l.subList(0, l.size())) cout.println(i);
    List<Integer> l2 = new ArrayList<>();
    Collections.copy(l2, l);
    for (Integer i: l2) cout.println(i);
  }
  static void queue() {
    Queue<Integer> q = new LinkedList<>(Arrays.asList(xs));
    for (int i: q) {
      cout.println(i);
    }
    Queue<Integer> pq = new PriorityQueue<>();
    for (int i: q) {
      pq.offer(i);
    }
    for ( ; !pq.isEmpty(); ) {
      cout.println(pq.peek());
      pq.poll();
    }
  }
  static void deque() {
    Deque<Integer> d = new LinkedList<>(Arrays.asList(xs));
    d.offerLast(xs[0]);
    d.offerFirst(xs[1]);
    for ( ; !d.isEmpty(); ) {
      cout.println(d.peekFirst()+" "+d.peekLast());
      d.pollFirst();
      if (!d.isEmpty()) d.pollLast();
    }
  }
  static void map() {
    Map<String, Integer> m = new HashMap<>();
    for (int i = 0; i < 10; i++) {
      m.put(ss[i], xs[i]);
    }
    for (Map.Entry p: m.entrySet()) {
      cout.println(p.getKey()+" "+p.getValue());
    }
    Map<String, Integer> n = new TreeMap<>(m);
    m.remove(ss[0]);
    m.put(ss[0], xs[1]);
    cout.println(m.equals(n));
  }
  static void ordering() {
    List<Name> nl = Arrays.asList(ns);
    cout.println(nl);
    alg.sort(nl);
    cout.println(nl);
  }
  static void sortedSet() {
    SortedSet<Name> nameSet = new TreeSet<>(arr.asList(ns));
    for (Iterator<?> dit = nameSet.headSet(ns[0]).iterator(); dit.hasNext(); )
      cout.println(dit.next());
  }
  static void sortedMap() {
    SortedMap<Name, Integer> nameMap = new TreeMap<>();
    for (int i = 0; i < 7; i++) {
      nameMap.put(ns[i], xs[i]);
    }
    cout.println(nameMap.firstKey());
  }
  /**
   * hoho
   */
  public static void main(String[] args) {
    // collection();
    // set();
    // list();
    // queue();
    // deque();
    // map();
    // ordering();
    // sortedSet();
    sortedMap();
  }
}
