//
// Created by os on 8/17/22.
//

#ifndef PROJECT_BASE_CONSOLE_H
#define PROJECT_BASE_CONSOLE_H
#include "buffer.hpp"
#include "sem.hpp"
class _console{
private:
    static _buffer bufferIN, bufferOUT;
public:
    static _sem semBufferIn,semBufferOUT;
    static char getc ();
    static void putc (char);
    static int waitingInput();

    static void putc_thread_function(void *);
    static void getc_function();
};

#endif //PROJECT_BASE_CONSOLE_H
