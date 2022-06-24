#include "../lib/console.h"
#include "../h/mem.h"
#include "../h/syscall_cpp.h"
#include "../lib/hw.h"
#include "../lib/console.h"

void main(){
    char* c = new char;
    *c = 'c';
    __putc(*c);
    __mem_free(c);

}