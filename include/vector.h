#include <stdint.h>

typedef void (*const handler_t)(void);

typedef struct
{
    uint32_t *stackPointer;
    handler_t reset;
} vectors_t;

extern uint32_t _data_loadaddr, _data, _edata, _ebss, _stack;
extern vectors_t vectors;

void reset_handler(void);