//
// Created by os on 8/17/22.
//

#ifndef PROJECT_BASE_BUFFER_HPP
#define PROJECT_BASE_BUFFER_HPP
class _buffer{//fifo
private:
    static const int MAX_BUFFER_SIZE = 512;
    char array[MAX_BUFFER_SIZE];
    int left,right,taken;
    //left-take from, right-put
public:
    _buffer();
    char pop();
    int push(char c);
    int isEmpty();
};
#endif //PROJECT_BASE_BUFFER_HPP
