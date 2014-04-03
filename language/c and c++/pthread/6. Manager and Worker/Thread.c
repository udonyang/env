#include "Thread.h"

Thread* ThreadNew(void* (*todoIn)(void*))
{
	Thread *new = malloc(sizeof(Thread));
	if (!new) return NULL;
	new->todo = todoIn;
	if (pthread_attr_init(&new->attr)) {
		fprintf(stderr, "%s", strerror(errno));
		return NULL;
	}
	pthread_attr_setdetachstate(&new->attr, PTHREAD_CREATE_JOINABLE);
	return new;
}

int ThreadRun(void* thisIn)
{
	Thread *this = thisIn;
	if (pthread_create(&this->thread, &this->attr, this->todo, NULL)) {
		return -1;
	}
	return 0;
}

int ThreadDrop(void* thisIn)
{
	Thread *this = thisIn;
	if (pthread_attr_destroy(&this->attr)) {
		return -1;
	}
	free(thisIn);
	return 0;
}

pthread_t ThreadGetId(void* thisIn)
{
	Thread *this = thisIn;
	return this->thread;
}

int ThreadJoin(void* thisIn)
{
	Thread *this = thisIn;
	return pthread_join(this->thread, NULL);
}

int ThreadDetach(void* thisIn)
{
	Thread *this = thisIn;
	return pthread_detach(this->thread);
}

const ThreadWrapperDefine ThreadWrapper = {
	{ThreadRun, ThreadDrop}
};
