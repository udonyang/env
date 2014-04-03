#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int JoinAll(pthread_t thrds[], int n) {
	int ret = 0;
	for (int i = 0; i < n; i++) {
		if (pthread_join(thrds[i], NULL)) {
			ret = -1;
		}
	}
	return ret;
}
