#pragma once
#include "../lib/hw.h"

/*
 * The functions are intended to be used in supervisor mode, and they are not thread-safe
 */

#ifdef __cplusplus
    extern "C" {
#endif
        typedef struct _frmem _frmem;
        struct _frmem{
            _frmem *next;
            size_t current_size;
        };

        void* __mem_alloc(size_t size);

        int __mem_free(void* ptr);


#ifdef __cplusplus
    }
#endif

