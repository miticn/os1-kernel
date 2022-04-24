#include "../lib/console.h"
#include "mem.h"
#include "../lib/hw.h"

void main(){
    __mem_alloc(4);
    if(HEAP_START_ADDR > HEAP_END_ADDR) __putc('k');
}