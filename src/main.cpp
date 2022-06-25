#include "../lib/console.h"
#include "../h/mem.h"
#include "../h/syscall_cpp.h"
#include "../lib/hw.h"
#include "../lib/console.h"

uint64 timerCount = 8;
extern "C" void handleSupervisorTrap(){
    uint64 scause;
    __asm__ volatile ("csrr %[read], scause" : [read] "=r" (scause));
    if(scause==(0x01UL<< 63 | 0x01)){ //is timer interupt?
        timerCount++;
        if(timerCount >= 50){
            __putc('a');
            __putc('\n');
            timerCount = 0;
        }
        asm volatile("csrc sip, 0x02");
    }

    console_handler();
}
extern "C" void supervisorTrap();

void main(){
    char* c = new char;
    *c = 'c';
    __putc(*c);
    __mem_free(c);

    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt
    while(1){}

}