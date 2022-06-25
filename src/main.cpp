#include "../lib/console.h"

#include "../lib/hw.h"
#include "../h/syscall_cpp.h"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"



void main(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt

    char* c = new char;
    *c = 'c';
    __putc(*c);
    int i = mem_free(c);


    if(i==0){ __putc('i');}
    while(1){}

}