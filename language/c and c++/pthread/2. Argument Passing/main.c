#include "main.h"
#define N 5

typedef struct {
	int id, preId;
} Arg;

void* ArgsTest(void* argIn)
{
	Arg *arg = argIn;
	printf("I am #%2d, created by #%2d\n", arg->id, arg->preId);
	return 0;
}

int main(int argc, char **argv)
{
	pthread_t thrds[N];
	Arg arg[N];
	for (long t = 0; t < 5; t++) {
		arg[t] = (Arg){t-1, t};
		pthread_create(thrds+t, NULL, ArgsTest, arg+t);
	}
	JoinAll(thrds, N);
  return 0;
}
