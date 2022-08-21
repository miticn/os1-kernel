//
// Created by os on 8/17/22.
//
#include "../h/console.h"
#include "../lib/hw.h"
#include "../h/syscall_c.h"
_buffer _console::bufferIN;
_buffer _console::bufferOUT;
_sem _console::semBufferIn;
_sem _console::semBufferOUT;

char _console::getc() {
    return _console::bufferIN.pop();
}

void _console::putc(char c) {
    _console::bufferOUT.push(c);
    _console::semBufferOUT.signal();
}

void _console::putc_thread_function(void *) {//runs as system thread
    while(1){
        while(((*(uint8*)CONSOLE_STATUS) & 0x20) && !bufferOUT.isEmpty()){
            char c = bufferOUT.pop();
            *(char*)(CONSOLE_TX_DATA) = c;
        }
        if(bufferOUT.isEmpty())
            sem_wait(&_console::semBufferOUT);
    }
}

void _console::getc_function() { // runs inside interupt
    int read = 0;
    while(((*(uint8*)CONSOLE_STATUS) & 0x01) && !_console::bufferIN.isFull()) {
        _console::bufferIN.push(*(char*)CONSOLE_RX_DATA);
        read++;
    }
    for(int i = 0;i<read;i++){
        _console::semBufferIn.signal();
    }
}

int _console::waitingInput() {
    return _console::semBufferIn.isWaiting();
}
