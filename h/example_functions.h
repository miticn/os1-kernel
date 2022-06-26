//
// Created by os on 6/26/22.
//

#ifndef PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#define PROJECT_BASE_EXAMPLE_FUNCTIONS_H

#include "../lib/console.h"

void printString(char const *string){
    for(char const * chr = string; *chr!='\0';chr++){
        __putc(*chr);
    }
}

void function1(){
    while(1){
        printString("Function1 \n");
    }
}

void function2(){
    while(1){
        printString("Function2 \n");
    }
}

#endif //PROJECT_BASE_EXAMPLE_FUNCTIONS_H
