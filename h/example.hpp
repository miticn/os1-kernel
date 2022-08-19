//
// Created by os on 8/17/22.
//

#ifndef PROJECT_BASE_EXAMPLE_HPP
#define PROJECT_BASE_EXAMPLE_HPP
//
// Created by os on 6/26/22.
//

#ifndef PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#define PROJECT_BASE_EXAMPLE_FUNCTIONS_H

#include "../h/syscall_c.h"
#include "../h/syscall_cpp.hpp"
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
        if(*CB<'~') {
            *CB = c++;
            sem_signal(semReadyRead);
        }
        else{
            sem_close(semReadyWrite);
            sem_close(semReadyRead);
            break;
        }

        //thread_dispatch();
    }
}
void functionSem2Test(void *param){//print char from sem
    sem_t semReadyWrite = (sem_t)((uint64*)param)[0];
    sem_t semReadyRead = (sem_t)((uint64*)param)[1];
    char *CB = (char*)((uint64*)param)[2];
    while(1){
        if (sem_wait(semReadyRead)==0) {
            putc(*CB);
            sem_signal(semReadyWrite);
        }
        else{
            putc('\n');
            break;
        }
        //thread_dispatch();
    }
}

void functionPeriodicThreadTest(void *param){
    class HelloThread : public PeriodicThread{
    protected:
        void periodicActivation() override{
            printStringE("Hello\n");
        }
    public:
        HelloThread(time_t time) : PeriodicThread(time){}
    };
    class NinjaThread : public PeriodicThread{
    protected:
        void periodicActivation() override{
            printStringE("Ninja\n");
        }
    public:
        NinjaThread(time_t time) : PeriodicThread(time){}
    };
    NinjaThread *ninja;
    HelloThread *hello;

    hello = new HelloThread(10);//1 sec
    ninja = new NinjaThread(50);//5 sec

    ninja->start();
    hello->start();

    time_sleep(1000);//100 sec

    delete ninja;
    delete hello;
}

#endif //PROJECT_BASE_EXAMPLE_FUNCTIONS_H
#endif //PROJECT_BASE_EXAMPLE_HPP
