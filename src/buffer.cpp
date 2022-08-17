//
// Created by os on 8/17/22.
//
#include "../h/buffer.hpp"

char _buffer::pop() {
    if(left!=right){
        return array[(left++)%MAX_BUFFER_SIZE];
        taken--;
    }
    else
        return -1;//error no more to take from
}

int _buffer::push(char c) {
    if(taken<MAX_BUFFER_SIZE){
        array[(right++)%MAX_BUFFER_SIZE] = c;
        taken++;
        return 0;
    }
    else{
        return -1;//buffer is full
    }
}

_buffer::_buffer():left(0), right(0), taken(0) {}
