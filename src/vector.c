#include "../include/vector.h"

int main(void);

void reset_handler(void)
{
	volatile uint32_t *src, *dest;

    /* Copy the data to SRAM */
	for (src = &_data_loadaddr, dest = &_data; dest < &_edata; src++, dest++) {
		*dest = *src;
	}
    /* Set bss to zeros */
	while (dest < &_ebss) {
		*dest++ = 0;
	}
	/* Continue to the main function. */
	(void)main();
}

__attribute__ ((section(".vectors")))
vectors_t vectors = {
    .stackPointer       = &_stack,
    .reset              = reset_handler,
};

