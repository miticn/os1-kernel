//
// Created by os on 8/17/22.
//
#include "../h/console.h"
_buffer _console::bufferIN;
_buffer _console::bufferOUT;

char _console::getc() {
    return _console::bufferIN.pop();
}

void _console::putc(char c) {
    _console::bufferOUT.push(c);
}
