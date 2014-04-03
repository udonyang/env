#include "main.h"
#define N 5
#define M 1<<20

typedef struct {
	int id, preId;
} Arg;

char pool[M];
pthread_attr_t attr;

void* ArgsTest(void* argIn)
{
	Arg *arg = argIn;
	int rndm = random()%M;
	size_t mystacksize;

	pthread_attr_getstacksize(&attr, &mystacksize);
	printf("I am #%2d, created by #%2d, random is %d, stack size is %li\n",
			arg->id, arg->preId,
			rndm,
			mystacksize);
	return 0;
}

int main(int argc, char **argv)
{
	pthread_t thrds[N];
	Arg arg[N];
	size_t mystacksize;
	
	srandom((unsigned int)time(0));
	pthread_attr_init(&attr);
	pthread_attr_getstacksize(&attr, &mystacksize);
	printf("current stack, size is %li\n", mystacksize);

	pthread_attr_setstacksize(&attr, sizeof(pool));

	pthread_attr_getstacksize(&attr, &mystacksize);
	printf("now stack size is %li\n", mystacksize);

	for (long t = 0; t < N; t++) {
		arg[t] = (Arg){t-1, t};
		pthread_create(thrds+t, &attr, ArgsTest, arg+t);
	}

	pthread_attr_destroy(&attr);
	JoinAll(thrds, N);
  return 0;
}
