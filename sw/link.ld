OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  . = 0x00000000;
  .text : { *(.text) }
  .data : { *(.data) }
  .bss : { *(.bss) }
}
