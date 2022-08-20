//
// Created by os on 8/17/22.
//

#ifndef PROJECT_BASE_CONSOLE_H
#define PROJECT_BASE_CONSOLE_H
#include "buffer.hpp"
class _console{
private:
    static _buffer bufferIN, bufferOUT;
public:
    static char getc ();
    static void putc (char);

    static void putc_thread_function(void *);
};

#endif //PROJECT_BASE_CONSOLE_H
