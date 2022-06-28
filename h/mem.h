#pragma once

#include "../lib/hw.h"

/*
 * The functions are intended to be used in supervisor mode, and they are not thread-safe
 */


#ifdef __cplusplus
    extern "C" {
#endif

    size_t getNumOfBlocks(size_t size);
    void* __mem_alloc(size_t size);

    int __mem_free(void* ptr);


#ifdef __cplusplus
    }
#endif

