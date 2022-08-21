//
// Created by os on 8/17/22.
//
#include "../h/console.h"
#include "../lib/hw.h"
#include "../h/syscall_c.h"
_buffer _console::bufferIN;
_buffer _console::bufferOUT;

char _console::getc() {
    return _console::bufferIN.pop();
}

void _console::putc(char c) {
    _console::bufferOUT.push(c);
}

void _console::putc_thread_function(void *) {
    while(1){
        while(((*(uint8*)CONSOLE_STATUS) & 0x20) && !bufferOUT.isEmpty()){
            char c = bufferOUT.pop();
            *(char*)(CONSOLE_TX_DATA) = c;
        }
        thread_dispatch();
    }
}
