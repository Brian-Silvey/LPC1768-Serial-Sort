#include "mbed.h"
#include <stdlib.h>

extern "C" int bubble_sort(int numbers[10], int size, int mode);

int size;                   // size of the array (MAX 100)
int numbers[100];           // declare array
int mode;                   // 0 = ascending sort, 1 = descending sort
Serial pc(USBTX, USBRX);    // set up serial over USB

int main() {
reset:
    pc.printf("Input number of elements:\n\r");
    pc.scanf("%d", &size);  // store input in size
    pc.printf("Input %d integers:\n\r", size);
    int i = 0;              // initialize index (for looping)
lbl1:
    pc.scanf("%d", &numbers[i]);    // store inputted value into numbers[i]
    i++;                            // increment
    if (i < size)
        goto lbl1;                  // restart loop 1
    pc.printf("Input ascending (0) or descending (1):\n\r");
    pc.scanf("%d", &mode);          // store inputted value into mode
    
    pc.printf("Before sort:\n\r");
    i = 0;                  // reset index for next loop
lbl2:
    pc.printf("array[%d] = %d\n\r", i, numbers[i]); // print ith element in array
    i++;                    // increment
    if (i < size)
        goto lbl2;          // restart loop 2
    bubble_sort(numbers, size, mode);   // call asm function to sort inputted array in certain order
    pc.printf("After sort:\n\r");
    i = 0;                  // reset index for next loop
lbl3:
    pc.printf("array[%d] = %d\n\r", i, numbers[i]); // print ith element in array
    i++;                    // increment
    if (i < size)
        goto lbl3;          // restart loop 3
    while(1) {
        if (pc.getc())      // if something is inputted
            goto reset;     // restart the program
    }
}