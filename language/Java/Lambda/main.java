import java.util.*;

class Person {
  public enum Sex {
    MALE, FEMALE
  }

  String name;
  Sex gender;
  String emailAddress;

  public int getAge() {
    return 10;
  }

  public String getEmailAddress() {
    return emailAddress;
  }

  public void printPerson() {
  }
}


class main {
  interface Predicate<T> {
    boolean test(T t);
  }
  interface Consumer<T> {
    void accept(T t);
  }
  interface Function<T, R> {
    R apply(T t);
  }
  public static void processPersonWithFunction(
      List<Person> roster,
      Predicate<Person> tester,
      Function<Person, String> mapper,
      Consumer<Person> block) {
    for (Person p: roster) {
      if (tester.test(p)) {
        String data = mapper.apply(p);
        block.accept(p);
      }
    }
  }
  public static void main(String[] args) {
    System.out.println("HelloWorld");
  }
}
