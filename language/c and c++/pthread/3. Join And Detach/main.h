#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "time.h"

extern void srandom(unsigned int);
extern long random(void);

int JoinAll(pthread_t thrds[], int n) {
	int ret = 0;
	for (int i = 0; i < n; i++) {
		if (pthread_join(thrds[i], NULL)) {
			ret = -1;
		}
	}
	return ret;
}
