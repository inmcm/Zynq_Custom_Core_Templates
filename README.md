# Zynq/MicroBlaze AXI Custom Core Templates
Complete examples of AXI-compatiable IP cores  ready for use in Xilinx Vivado/SDK. These cores are intended for use with the Zynq's Cortex-A9 PS and the MicroBlaze soft-processor. The core logic and AXI interface code is written in pure VHDL. The driver code is written in C and a self-test program is provided that is compatible with the Standalone bare-metal Xilinx libraries. Linux compatibility has not been tested, but likely works fine. These cores were developed under Vivado/SDK 2015.1


## Currently Complete:

* AXI4-Lite


## How to Implement:
* Clone repo 
* Open the Vivado project you want to use. Open `Tools -> Project Settings` Add the IP folder from the repo clone

![Import_IP](http://i.imgur.com/RByQq4M.png?1)

* Open the your project's block diagram. Ensure your Zynq/MicroBlaze instance is correctly configured for your board. **IMPORTANT** Make sure you have a UART available if you want to run the test suite later

![Init_BD](http://i.imgur.com/hGoZ7Tr.png?1)
 
* Open `Window -> IP Catalog` and search for `example`

![IP_Catalog](http://i.imgur.com/OedDNHq.png?1)

* Double on the example core and add it to the block diagram

![Just_Added_Core](http://i.imgur.com/fk1M2bd.png?1)

* Run Design Automation to add the AXI interface layer. Select the defaults.

![Design_Automation_Run](http://i.imgur.com/NtvR6Tn.png?1)

* Add import and output ports for the example core. Validate your block diagram and save it. 

![Done_Block_Diagram](http://i.imgur.com/wVCgv45.png?1)

* Add pin locations in your projects XDC file for the GPIO pins based on your board

![Example_XDC](http://i.imgur.com/mFMMn8b.png?1)

* Run all implementation steps including synthesis, place & route, and generate bit stream.

## How to Test
* Within Vivado, Open `File -> Export -> Export Hardware` and select export **Local to Project** and include the bitstream

![Export_Hardware](http://i.imgur.com/Ap9orzs.png)

* Open `File -> Launch SDK` with both drop downs set **Local to Project**

* Within SDK, check the Hardware Definition to Ensure the IP core is in the memory map

![Hardware_Memory_Map](http://i.imgur.com/2VWCeVs.png)

* Open `File -> New -> Board Support Package` to create a new standalone BSP based on the hardware definition exported from Vivado

![Create_BSP](http://i.imgur.com/TZcI6lG.png)

* Ensure the example core is listed in the BSP with it's driver

![Core_Driver](http://i.imgur.com/fc1jYPn.png)

* Open `File -> New -> Application Project` and create a new, standalone C project based on the BSP you just created. Click `Next`

![New_App_1](http://i.imgur.com/gqiJ80Y.png)

* Select `Empty Application` from the available templates

![New_App_2](http://i.imgur.com/SG4bli5.png)

* Copy the following code into you new project `main.c`. The code should build automatically when you save, but if not select `Project -> Build All`

```c
#include "example_core_lite.h"

int main()
{
	EXAMPLE_CORE_LITE_SelfTest();
	return 0;
}
```

* Right click on the project and select `Run As -> Run Configurations...` Create a new **Xilinx C/C++ application (GDB)** instance for the project. Click `Apply` and then `Close`

![Make_Run_Config](http://i.imgur.com/S4PRuDQ.png)

* Ensure your favorite JTAG adaptor is hooked up and working. Select `Xilinx Tools -> Program FPGA` to load the BIT file from Vivado into your target device.

![Program_FPGA](http://i.imgur.com/t9x4ARz.png)

* Make sure your device's UART is connected via USB/Serial/etc. Open your favorite serial port terminal client and select the proper port and baudrate (likely 115200bps)

* Execute the program run configuration you just created with the run button.

![Run_Test](http://i.imgur.com/mIKiFib.png)

* Verify the test output in your serial console. The only thing not exercised is the GPIO. 

![Test_Result](http://i.imgur.com/oGzpaob.png)



## How to Modify

The core can be modified at any time using the **IP Packager** in Vivado. Within the `IP Catalog` window, search for the core and right click on it to select the packager.

![IP_Packager](http://i.imgur.com/0fozJKs.png) 


The VHDL core is made up of three file:
* `example_core.vhd` Module that defines the behavior of the core based on input and output registers 
* `example_core_lite_v1_0_S00_AXI.vhd`  Defines the AXI bus interface as well as the input and output registers
* `example_core_lite_v1_0.vhd` The top-level module of the core than connect the main core logic to the AXI bus and the outside world
