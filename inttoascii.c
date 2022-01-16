/**
 * @file inttoascii.c
 * @author onyettr
 * @brief function to convert an integer to ASCII characters
 *        Assumes 32-bit integer for sake of example
 *        s(n)printf() would be easier....
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MAX_SIZE (sizeof(uint32_t)*2)
#define DIM(X) (sizeof(X) / sizeof(uint32_t))

/**
 * @fn uint32_t number_of_digits(uint32_t int_value) {
 * @brief find the number of digits in teh integer
 * @param int_value
 * @return
 */
uint32_t number_of_digits(uint32_t int_value) {
  uint32_t count = 0;

  while (int_value) {
    ++count;
    int_value = int_value >> 4;
  }

  return count;
}

/**
 * @fn 	char *inttoascii(uint32_t int_value)
 * @param[in] int_value
 * @return
 * @note could use the number of digits and get fancy with printing
 */
char *inttoascii(uint32_t int_value)
{

	static char hex_value[MAX_SIZE+1];
    char *p = (char *)&hex_value[MAX_SIZE];
 //   uint32_t number = number_of_digits(int_value);

    memset((char*)&hex_value[0], ' ', MAX_SIZE);
    hex_value[MAX_SIZE]= '\0';

    do {
    	uint8_t lower = int_value & 0XF;
        if (lower < 10) {
        	*p = lower + '0';
        } else {
        	*p = lower + 'A' - 10;
        }
        int_value = int_value >> 4;
        p--;
    } while (int_value);

	return (char *)&hex_value[0];
}

int main ( void )
{
  uint32_t test_array[] = {
		  0x12345678,
		  0x0,
		  0x123,
		  0x1234,
		  0x12345,
		  0xABC,
		  0xFFF,
		  0xFFFFFFFF
  };
  int i;

  printf("int to ascii - STARTS\n");

  for (i=0; i < DIM(test_array); i++) {
	  printf("%3d\t0x%8x\t%s\n", i,test_array[i],inttoascii(test_array[i]));
  }
  printf("int to ascii - ENDS\n");
}
