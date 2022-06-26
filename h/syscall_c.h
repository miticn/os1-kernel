#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif

    void* mem_alloc(size_t blocks);
    int mem_free(void* ptr);

#ifdef __cplusplus
}
#endif
