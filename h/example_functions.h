//
// Created by os on 6/26/22.
//

#ifndef PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#define PROJECT_BASE_EXAMPLE_FUNCTIONS_H

#include "../h/syscall_c.h"
#include "../h/thread.hpp"

void printString(char const *string){
    for(char const * chr = string; *chr!='\0';chr++){
        putc(*chr);
    }
}

void function1(void *param){
    while(1){
        printString("Function1 \n");
        thread_exit();
        _thread::yield();
    }
}

void function2(void *param){
    while(1){
        printString("Function2 \n");
        _thread::yield();
    }
}

#endif //PROJECT_BASE_EXAMPLE_FUNCTIONS_H
