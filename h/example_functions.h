//
// Created by os on 6/26/22.
//

#ifndef PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#define PROJECT_BASE_EXAMPLE_FUNCTIONS_H

#include "../h/syscall_c.h"
#include "../lib/console.h"

void printString(char const *string){
    for(char const * chr = string; *chr!='\0';chr++){
        putc(*chr);
    }
}

void function1(void *param){
    while(1){
        printString("Function1 \n");
        //thread_exit();
        thread_dispatch();
    }
}

void function2(void *param){
    while(1){
        ((int*)param)[0]=1;
        printString("Function2 \n");
        thread_dispatch();
    }
}

#endif //PROJECT_BASE_EXAMPLE_FUNCTIONS_H
