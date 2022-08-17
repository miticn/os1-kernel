//
// Created by os on 8/17/22.
//
#include "../h/console.h"

char _console::getc() {
    return bufferIN.pop()
}

void _console::putc(char c) {
    bufferOUT.push(c);
}
