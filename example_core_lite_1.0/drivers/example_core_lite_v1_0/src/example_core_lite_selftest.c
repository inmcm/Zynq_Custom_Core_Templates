
/***************************** Include Files *******************************/
#include "example_core_lite.h"
#include "xparameters.h"
#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"

/************************** Constant Definitions ***************************/
uint32_t a_tests[] = {1,321097,45,4294967295,0,99,0xFFFF};
uint32_t b_tests[] = {2,1290484,214,4294967295,0,99,0x1};



/** @name Valid Selectors
Valid 32-Bit values that correspond to a unique output mux value
 */
///@{
const uint32_t valid_options[] = {0x00000000,
								0x00000001,
								0x00000002,
								0x00000003,
								0xFFFFFFFF,
								0x00000022,
								0x99999999,
								0xF0000000,
								0x0007E000,
								0x76543210,
								0x3787A668,
								0xABABABAB};
///@}


/** @name Valid Responses
Valid 32-Bit values that can be activated with the proper match request value
 */
///@{
const uint32_t valid_responses[] = {0x12345678,
							0xABABABAB,
							0x80000001,
							0x9ABCDEF0,
							0xC3C3C3C3,
							0x81818181,
							0x99999999,
							0xABABABAB,
							0x12488421,
							0xFEEDABBA,
							0xA6AAE961,
							0xFFFFFFFF};
///@}

/************************** Function Definitions ***************************/
/**
 *
 * Run a series of self-test on the driver/device. 
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   None
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus EXAMPLE_CORE_LITE_SelfTest()
{
	uint32_t i,a,b,c,d,temp_reg;
	uint64_t product_calc,product_test;
	
	printf("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\r");
	printf("^^^        Example AXI Core         ^^^\n\r");
	printf("^^^        Hello AXI World!         ^^^\n\r");
	printf("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\r\n\r");


	printf("***** Internal Case Selector Tests *****\n\r");
	for(i = 0; i < 12; i++){
		Xil_Out32(case_selector, valid_options[i]);
		d = Xil_In32(EXAMPLE_CORE_LITE_BASE_ADDRESS + 44);
		printf("Test: %02d  Case Input: 0x%08X Case Output: 0x%08X", i, valid_options[i], d);
		if(valid_responses[i] == d) {
		    printf("  CORRECT!\n\r");
		}
		else{
		    printf("  WRONG! Output should be 0x%08X\n\r\n\r", valid_responses[i]);
		    return XST_FAILURE;
		}
	}
	printf("\n\r");

	printf("***** Arithmetic Tests *****\n\r\n\r");
	for(i = 0; i < sizeof(a_tests)/sizeof(uint32_t);i++){

		printf("***************************************\n\r");
		printf("*****          Test %02d           ******\n\r",i+1);
		printf("***************************************\n\r");

		temp_reg = Xil_In32(counter_read);
		printf("Current Counter: %08X \n\r\n\r",temp_reg);

		a = a_tests[i];
		b = b_tests[i];
		Xil_Out32(intger_A_input, a);
		Xil_Out32(intger_B_input, b);
		product_calc = (uint64_t)a * (uint64_t)b;
		printf("A = 0x%08X, B = 0x%08X \n\r\n\r",a,b);

		printf("A + B = 0x%08X", Xil_In32(sum_AB));
		if (Xil_In32(sum_AB) == a + b){
		    printf("  CORRECT!\n\r\n\r");
		}
		else {
		    printf("  WRONG! Answer should be 0x%08X\n\r\n\r",a + b);
		    return XST_FAILURE;
	    }

		c = Xil_In32(product_AB_hi);
		d = Xil_In32(product_AB_lo);
		printf("A * B = 0x%08X%08X", Xil_In32(product_AB_hi),Xil_In32(product_AB_lo));
		product_test = ((uint64_t)c << 32) + (uint64_t)d;
		if (product_test == product_calc) {
		    printf("  CORRECT!\n\r\n\r");
		}
		else {
		    printf("  WRONG! Answer should be 0x%"PRIx64" \n\r\n\r", product_calc);
		    return XST_FAILURE;
        }


		printf("Bit Reversed A: 0x%08X", Xil_In32(bit_reverse_A));
		c = a;
		d = sizeof(a) * 8 - 1;
		
		for (a >>= 1; a; a >>= 1) {
			c <<= 1;
			c |= a & 1;
			d--;
		}
		c <<= d; // shift when v's highest bits are zero
		
		if (Xil_In32(bit_reverse_A) == c) {
		    printf("  CORRECT!\n\r\n\r");
	    }
		else {
		    printf("  WRONG! Answer should be 0x%08X\n\r\n\r", c);
		    return XST_FAILURE;
        }


		printf("Bit Inverted B: 0x%08X", Xil_In32(bit_inverse_B));
		if(~b == Xil_In32(EXAMPLE_CORE_LITE_BASE_ADDRESS + 40)) {
		    printf("  CORRECT!\n\r\n\r"); 
        }
        else {
            printf("  WRONG! Answer should be 0x%08X\n\r\n\r", ~b);
            return XST_FAILURE;
        }
	}
	printf("Example Core Test Complete! \n\r");
	printf("\n\n\n\n\n\n\n");
	return  XST_SUCCESS;
}


