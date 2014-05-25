#include <stdio.h>
#include <assert.h>
#include <signal.h>
#include <time.h>

void test_time()
{
  time_t t = time(NULL);
  struct tm *tp = localtime(&t);
  char buf[BUFSIZ];
  strftime(buf, BUFSIZ, "%Z %Y-%m-%d %A %I:%M:%S %p", tp);
  puts(buf);
}

void handler0(int sig)
{
  printf("I am 0.%d\n", sig);
}

void handler1(int sig)
{
  printf("I am 1.%d\n", sig);
}

void handler2(int sig)
{
  printf("I am 2.%d\n", sig);
}

void handler3(int sig)
{
  printf("I am 3.%d\n", sig);
}

void (*get_handler(int id))(int)
{
  static void (*handler[])(int) = {
    handler0,
    handler1,
    handler2,
    handler3
  };
  return handler[id];
}

void handle_kill(int sig)
{
  printf("got it %d.\n", sig);
}

void test_signal()
{
  signal(SIGABRT, handle_kill);
  signal(SIGFPE, handle_kill);
  signal(SIGINT, handle_kill);
  signal(SIGSEGV, handle_kill);
  signal(SIGTERM, handle_kill);
  for (int i = 0; i < 4; i++)
    get_handler(i)(i);
  raise(SIGABRT);
  raise(SIGFPE);
  raise(SIGINT);
  raise(SIGSEGV);
  raise(SIGTERM);
}

void test_stdio()
{
  FILE* file = fopen("tmp", "w");
  fprintf(file, "test stdio\n");
  fclose(file);
  remove("tmp");
}


int main(int argc, char** argv)
{
  test_time();
  // test_signal();
  // test_stdio();
  return 0;
}
