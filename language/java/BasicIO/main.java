import java.util.*;
import java.lang.*;
import java.math.*;
import java.io.*;

class main {
  public static void main(String[] args) throws IOException {
    Scanner cin = null;
    PrintStream cout = System.out;
    cin = new Scanner(new BufferedReader(new FileReader("usnumbers.txt")));
    cin.useDelimiter("\\s|\\.|,");
    for ( ; cin.hasNext("\\d+"); ) {
      cout.println(cin.next("\\d+"));
    }
    cin.close();
  }
}
