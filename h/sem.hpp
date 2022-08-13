//
// Created by os on 8/13/22.
//

#ifndef PROJECT_BASE_SEM_HPP
#define PROJECT_BASE_SEM_HPP


class _sem;
typedef _sem* sem_t;
class _sem{
public:
    int sem_open();
    int sem_close (sem_t handle);
    int sem_wait (sem_t id);
    int sem_signal (sem_t id);
private:
    sem_t first;
    sem_t last;
};

#endif //PROJECT_BASE_SEM_HPP
