#ifndef DAC_RUNNABLE_INTERFACE_H
#define DAC_RUNNABLE_INTERFACE_H

typedef struct {
	int (*run)(void*);
	int (*drop)(void*);
} RunnableInterface;

#endif
