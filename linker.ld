/*
    A Linker script for STM32VLDISCOVERY board 
    This is for learning purposes only. I have no idea what I'm doing,
    and you definately should not use this in any production code.
    But you can do that if you want to, just don't blame me.
*/

MEMORY
{
    flash(rx) : ORIGIN = 0x08000000, LENGTH = 128K
    /*  Same thing here, except for the SRAM */
    SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

/* The vectors is defined in our vector source files */
EXTERN(vectors)

/*  I guess this is the name of the symbol where the code should start executing. */
ENTRY(reset_handler)

_stack = ORIGIN(SRAM) + LENGTH(SRAM);

SECTIONS
{
    /* The text section contains our executable code. */
    .text : {
        *(.vectors) /* First we should have the vector table */
        *(.text)    /* Executable code goes here */
        . = ALIGN(4);
        *(.rodata*) /* Global constants go here */
        . = ALIGN(4);
    } > flash AT> flash

    /* The data section contains variables we have initialized in our code */
    .data : {
        _data = .;
        *(.data)
        . = ALIGN(4);
        _edata = .; /* _edata just means end of data */
    } > SRAM AT> flash
	_data_loadaddr = LOADADDR(.data);

    /* And here's our uninitialized data */
    .bss : {
        _bss = .;
        *(.bss)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .; /* _ebss just means end of bss */
    } > SRAM

    . = ALIGN(4);
    end = .;
}