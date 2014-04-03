#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define N 5

void* PrintHello(void *threadid) 
{
	int tid = (int)threadid;
	printf("Hello World! It's me, thread #%ld!\n", tid);
	return NULL;
}

int main(int argc, char **argv)
{
	pthread_t thread[N];
	int rc;

	for (long t = 0; t < N; t++) {
		printf("In main: creating thread %ld\n", t);
		rc = pthread_create(thread+t, NULL, PrintHello, (void*)t);
		if (rc) {
			printf("ERROR; return code from pthread_create() is %d\n", rc);
			return (-1);
		}
	}
  return 0;
}
