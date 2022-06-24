#include "../lib/console.h"
#include "../h/mem.h"
#include "../lib/hw.h"
#include "../lib/console.h"

void main(){
    char* c = __mem_alloc(1);
    *c = 'c';
    __putc(*c);
    __mem_free(c);

}