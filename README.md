# Zynq Custom Core Templates
Complete examples of AXI-compatiable IP cores  ready for use in Xilinx Vivado/SDK. These cores are intended for use with the Zynq's Cortex-A9 PS and the MicroBlaze soft-processor. The core logic and AXI interface code is written in pure VHDL. The driver code is written in C and a self-test program is provided that is compatiable with the Standalone bare-metal Xilinx libraries. Linux compatiability has not been tested, but likely works fine. 

## Currently Complete:

* AXI4-Lite


## How to Use:
* Clone repo 
* Open the Vivado project you want to use. Open `Tools -> Project Settings` Add the ip folder from the repo clone

![Import_IP](http://i.imgur.com/RByQq4M.png?1)

* Open the your project's block diagram. Ensure your Zynq/MicroBlaze instance is correctly configured for your board.

![Init_BD](http://i.imgur.com/hGoZ7Tr.png?1)
 
* Open `Window -> IP Catalog` and search for `example`

![IP_Catalog](http://i.imgur.com/OedDNHq.png?1)

* Double on the example core and add it to the block diagram

![Just_Added_Core](http://i.imgur.com/fk1M2bd.png?1)

* Run Design Automation to add the AXI interface layer. Select the defaults.

![Design_Automation_Run](http://i.imgur.com/NtvR6Tn.png?1)

* Add import and output ports for the example core 

![Done_Block_Diagram](http://i.imgur.com/wVCgv45.png?1)

* Add pin locations in your projects XDC file for the GPIO pins based on your board

![Example_XDC](http://i.imgur.com/mFMMn8b.png?1)





