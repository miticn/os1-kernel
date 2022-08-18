//
// Created by os on 8/17/22.
//

#ifndef PROJECT_BASE_EXAMPLE_H
#define PROJECT_BASE_EXAMPLE_H
//
// Created by os on 6/26/22.
//

#ifndef PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#define PROJECT_BASE_EXAMPLE_FUNCTIONS_H

#include "../h/syscall_c.h"
#include "../lib/console.h"

void printStringE(char const *string){
    for(char const * chr = string; *chr!='\0';chr++){
        putc(*chr);
    }
}

void function1(void *param){
    int i =0;
    int j = 1;
    while(1){
        while(i<1000) i = i+j;
        i = 0;
        printStringE("Function1 \n");
        //thread_exit();
        //thread_dispatch();
    }
}

void function2(void *param){
    while(1){
        printStringE("Function2 \n");
        //thread_dispatch();
    }
}

void functionSem1Test(void *param){
    char c = 'a';
    sem_t semReadyWrite = (sem_t)((uint64*)param)[0];
    sem_t semReadyRead = (sem_t)((uint64*)param)[1];
    char *CB = (char*)((uint64*)param)[2];
    while(1){
        sem_wait(semReadyWrite);
        *CB= c++;
        sem_signal(semReadyRead);
        //thread_dispatch();
    }
}
void functionSem2Test(void *param){//print char from sem
    sem_t semReadyWrite = (sem_t)((uint64*)param)[0];
    sem_t semReadyRead = (sem_t)((uint64*)param)[1];
    char *CB = (char*)((uint64*)param)[2];
    while(1){
        sem_wait(semReadyRead);
        putc(*CB);
        sem_signal(semReadyWrite);
        //thread_dispatch();
    }
}

#endif //PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#endif //PROJECT_BASE_EXAMPLE_H
