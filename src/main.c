#include "../lib/console.h"

void main(){
    __putc('O');
    __putc('S');
    __putc('\n');
    __putc('\n');

    while(1){
        char car = __getc();
        __putc(car +30);
    }
}