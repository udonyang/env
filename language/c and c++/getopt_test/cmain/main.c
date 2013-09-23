#pragma comment(linker, "\STACK:65535000")
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <getopt.h>

struct { char READ:1; char WRITE:1; char EXECUTE:1; } flag;

int main(int argc, char *argv[])
{
#if 0
	freopen("input.in", "r", stdin);
#endif
	for (int opt; (opt = getopt(argc, argv, "rwx")) != -1; ) {
    switch (opt) {
      case 1:
        printf("get %s\n", optarg);
        break;
      case 'r':
        flag.READ = 1;
        break;
      case 'w':
        flag.WRITE = 1;
        break;
      case 'x':
        flag.EXECUTE = 1;
        break;
      default:
        fprintf(stderr, "Usage: %s [rwx]\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    printf("%c get argument %s\n", opt, optarg);
	}
  if (optind >= argc) {
    fprintf(stderr, "Expected argument after option\n");
    exit(EXIT_FAILURE);
  }
  printf("%c%c%c argv[%d] = %s\n",
      flag.READ? 'r': '-',
      flag.WRITE? 'w': '-',
      flag.EXECUTE? 'x': '-',
      optind, argv[optind]);
	return 0;
}
