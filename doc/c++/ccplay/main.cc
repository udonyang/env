#include <sys/wait.h>
#include <sys/file.h>
#include <unistd.h>
#include <signal.h>

#include <cstdio>

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <iomanip>
#include <sstream>

extern "C" {
#include <dac/v2/Comm.h>
}

#include "play.h"

using namespace std;

static void Dac() {
  char* str = DacFormat("%s fuck %s\n", "he", "her");
  DacPutsAndFree(str);
}

int main() {
#if 0
  freopen("input.in", "r", stdin);
#endif
	// Lambda();
	// Strtok();
	// Stream();
	// Signal();
  Dac();
	return 0;
}

static void sig_int(int sig) {
	printf("interrupt\n%%");
	exit(-1);
}
static void Bye()
{
	puts("Bye");
}

void Signal() {
	char buf[BUFSIZ];
	pid_t pid;
	int status;

	atexit(Bye);
	if ((signal(SIGINT, sig_int)) == SIG_ERR)
		perror("signal error");

	int fid;
	if ((fid = open("/tmp/main.pid", O_CREAT | O_CLOEXEC, S_IRWXU)) < 0) {
		fputs("open pid file failed.", stderr);
		exit(-1);
	}
	if (flock(fid, LOCK_EX | LOCK_NB) < 0) {
		fputs("already running.\n", stderr);
		exit(-1);
	}

	printf("%%");
	while (scanf("%s", buf) != EOF) {
		if (buf[strlen(buf)-1] == '\n')
			buf[strlen(buf)-1] = 0;

		if ((pid = fork()) < 0) {
			perror("fork error");
		}
		else if (pid == 0) {
			execlp(buf, buf, (char*)0);
			fprintf(stderr, "couldn't execute: %s", buf);
			exit(127);
		}

		if ((pid = waitpid(pid, &status, 0)) < 0)
			perror("waitpid error");
		printf("%%");
	}
	exit(0);
}

void Stream() {
	stringbuf buf;
	ostream os(&buf);
	os << "fuck " <<  "her " << setfill('x') << setw(10) << 5;
	cout << buf.str() << endl;

	stringstream oss;
	oss << "fuck " <<  "her " << setfill('x') << setw(10) << 5;
	cout << oss.str() << endl;
}

void Lambda() {
  int c = 3;
  auto func = [&](int a, int b){return a+b+c;};
  printf("%d %d\n", func(1, 2), c);
}

void Strtok() {
	char test[] = "1238172938-asfasdfjka-aafa -218712938",
			 dlim[] = "-";
	char to[100];
	int len = strlen(test);

	for (char *i = strtok(test, dlim); i; i = strtok(0, dlim)) {
		printf("%s'\n", i);
	}
	printf("%s\n", test);
} 
