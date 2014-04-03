#ifndef DAC_THREAD_H
#define DAC_THREAD_H

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <string.h>
#include "RunnableInterface.h"

typedef struct {
	pthread_t thread;
	pthread_attr_t attr;
	void* (*todo)(void*);
} Thread;

Thread* ThreadNew(void* (*todoIn)(void*));
int ThreadRun(void* thisIn);
int ThreadDrop(void* thisIn);
pthread_t ThreadGetId(void* thisIn);
int ThreadJoin(void* thisIn);
int ThreadDetach(void* thisIn);

typedef struct {
	RunnableInterface Runnable;
} ThreadWrapperDefine;

extern const ThreadWrapperDefine ThreadWrapper;

#endif
