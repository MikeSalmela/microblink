#include <stdint.h>

const uint32_t GPIO_C = 0x40011000;
const uint32_t GPIO_PUSH_PULL = 0x00;

volatile uint32_t* const GPIOC_CRH = (uint32_t*) (GPIO_C + 0x04);
volatile uint32_t* const RCC_APB2ENR = (uint32_t*) (0x40021000 + 0x18);
const uint32_t RCC_APB2ENR_IOPCEN = (1 << 4);

int main(void)
{
	*RCC_APB2ENR = RCC_APB2ENR_IOPCEN;

    *GPIOC_CRH = GPIO_PUSH_PULL << 2;
    *GPIOC_CRH |= 0x1;

	volatile uint32_t* const GPIOC_BSRR = (uint32_t*) (GPIO_C + 0x10);
	uint32_t a = 500000;
	while (1) {
		*GPIOC_BSRR = (1<<8);
		for (int i = 0; i < a; i++) {
		    __asm__("nop");
		}
		*GPIOC_BSRR = (1<<24);
		for (int i = 0; i < a; i++) {
		    __asm__("nop");
		}
	}
	return 0;
}
