#include "main.h"
#define N 5

typedef struct {
	int id, preId;
} Arg;

void* ArgsTest(void* argIn)
{
	Arg *arg = argIn;
	int rndm = random()%100;
	printf("I am #%2d, created by #%2d, random is %d\n",
			arg->id, arg->preId,
			rndm);
	return 0;
}

int main(int argc, char **argv)
{
	pthread_t thrds[N];
	pthread_attr_t attr;
	Arg arg[N];
	
	srandom((unsigned int)time(0));
	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
	for (long t = 0; t < 5; t++) {
		arg[t] = (Arg){t-1, t};
		pthread_create(thrds+t, NULL, ArgsTest, arg+t);
		// pthread_detach(thrds[t]);
	}

	pthread_attr_destroy(&attr);
	JoinAll(thrds, N);
  return 0;
}
