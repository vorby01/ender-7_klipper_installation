# Ender-7 Klipper Install
Details for Installing Klipper on Creality Ender 7 with BLTouch (Use at own risk)(Work in Progress)
- The ender-7 was my first 3d printer and these files show my learning curve into FDM printing with the ender-7

- Notes:
  - Ender-7 inbuilt screen will no longer work, incompatable with Klipper (creality wont release source code)
  - Installing Klipper if settings are incorrect the printer can crash/break
  
- - - -
- ### Printer Details
  - #### Creality Ender-7 Core-XY 3D Printer
    - (Early model with leadshine DM542 microstep drivers for X and Y)(purchased 2021/08/08)
  - ##### Modifications (2023/01/21)
    - Creality BL Touch Auto Bed Leveling Kit for Ender-7 (No Longer Available)(https://www.creality3d.online/collections/auto-bed-leveling-kit)
    - Embrace Making, Creality Ender 7 PEI Magnetic Flex Build Plate (https://embracemaking.com/products/copy-of-pei-magnetic-flex-build-plate-systems)
    - ~Embrace Making, Creality Ender 7 Triple Lead Screw Upgrade Kit (https://embracemaking.com/products/creality-ender-7-triple-lead-screw-upgrade-kit-pre-order)~
      - *Kept having twisting issues, broke plastic support arms.*
    - Tiny Machines 3D, Ender 7 Bed Stability Upgrade + Z-Axis Linear Rail Upgrade (https://www.tinymachines3d.com/products/ender-7-z-axis-upgrade-with-linear-rails-and-dual-lead-screws)
    - TH3D, Aluminum Bed Spacers (https://www.th3dstudio.com/product/aluminum-bed-spacers-pack-of-4/)

  - ##### Modifications (2023/02/18)
    - ADXL345 (Klipper Resonance Compensation)
    - TH3D, Creality Ender 7 12864 LCD Conversion/Upgrade Kit (https://www.th3dstudio.com/product/creality-ender-7-12864-lcd-conversion-upgrade-kit/)

- - - -           
- ### Klipper Host Machine
  - Raspberry Pi4
    - Running: Mainsail OS

- - - -
## File Descriptions:
 - 00_Prerequisite info.txt - Some information the should be collected before starting, eg, default firmware settings(Marlin: M503), microcontroller/board(Creality CR-FDM-v2.4.S1_v101), pin hardware names
 - 01_Install mainsailOS.txt - Process to install MainsailOS on raspberry pi
 - 02_Klipper config and install.txt - Process to build klipper printer.cfg and flash microcontroller/board
 - 03_Testing and calibration - Process for testing klipper is functional and ready to print
 - 04_Klipper macros.txt - Some Klipper macros and using with PrusaSlicer
 - 05_Extruder maximum flow.txt - Processes for determing printers maximum flow rate/speed
 - 06_Pressure advance.txt - Configure and use klipper pressure advance
 - 07_Resonance compensation.txt - Install and use ADXL345 accelerometer to minimise printer resonance (input shaping) (max_accel: x_max=18400, y_max=11500)
 
## Pictures
###### Ender 7 2023/01/21
![Ender-7](images/20230121_Ender-7_Whole.jpg)

