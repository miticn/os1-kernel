//
// Created by os on 8/13/22.
//

#ifndef PROJECT_BASE_NODE_H
#define PROJECT_BASE_NODE_H


template <typename T> class Node{
private:
        T next;
public:
        T getNext(){return next;}
        void setNext(T next){this->next = next;}
};


#endif //PROJECT_BASE_NODE_H
