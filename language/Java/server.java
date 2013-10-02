import java.net.*;
import java.io.*;
public class server extends Thread {
	static int SERVERPORT = 8088;
	private Socket client;
	public static int i = 0;
	public static String[] vct = new String[10];
	public server() {
	}
	public void run() {
		ClientThread.log("Server Starting up");
		try {
			ServerSocket server = new ServerSocket(SERVERPORT);
			while (true) {
				client = server.accept();
				ClientThread ct = new ClientThread(client);
				ct.start();
			}
		} catch (Exception e) {
			e.printStackTrace();
			ClientThread.log("Server Shuting down");
			System.exit(0);
		}
	}
	public static void main(String[] args) {
		server sp = new server();
		sp.start();
	}
	public static synchronized void message(String msg) {
		vct[i] = msg;
		i = (i + 1) % 10;
		vct[i] = "* ";
	}
}
class ClientThread extends Thread {
	private static int ii = 0;
	private Socket s;
	String msg = null;
	ServerSocket serverSocket = null;
	Socket socket = null;
	BufferedReader cin = null;
	PrintWriter cout = null;
	public ClientThread(Socket s) {
		this.s = s;
	}
	public void run() {
		try {
			cin = new BufferedReader(new InputStreamReader(s.getInputStream()));
			cout = new PrintWriter(s.getOutputStream());
			SendToAll sta = new SendToAll();
			sta.start();
			msg = cin.readLine();
			ii++;
			System.out.println("some   connect   us!Total:" + ii + "people");
			while (!msg.equals("exit ")) {
				server.message(msg);
				msg = cin.readLine();
			}
			if (msg.equals("exit ")) {
				--ii;
				System.out.print("someone   exit\nTotal" + ii + "people");
				cin.close();
				cout.close();
				s.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	static void log(String strInfo) {
		System.out.println(strInfo);
	}
	class SendToAll extends Thread {
		private int j = -1;
		public void run() {
			while (true) {
				try {
					sleep(500);
					if (j == -1) {
						if (!server.vct[0].equals("* ")) {
							cout.println(server.vct[0]);
							cout.flush();
							j = 1;
						} else {
							cout.println(server.vct[1]);
							cout.flush();
							j = 2;
						}
					}
					while (!server.vct[j].equals("* ")) {
						cout.println(server.vct[j]);
						cout.flush();
						j = (j + 1) % 10;
					}
				} catch (Exception e) {
				}
			}
		}
	}
}
