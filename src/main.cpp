#include "../lib/console.h"

#include "../lib/hw.h"
#include "../h/syscall_cpp.h"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"

#include "../h/example_functions.h"

void main(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt

    char* c = new char;
    int* in = new int;
    long* lg = new long;
    *c = 'c';
    __putc(*c);
    int i = mem_free(c);

    mem_free(in);
    mem_free(lg);
    if(i==0){ __putc('i');}
    printString("Zdravo ljudi!");
    while(1){}

}