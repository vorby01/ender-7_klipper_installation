## 09_Klipper update RPI(linux)

#### Update Klipper on rpi(raspberry pi) to match updated mcu version
  - 20250125

  - SSH to RPi  
    `ssh pi@<ip_address>`

  - Navigate to Klipper directory  
    `cd ~/klipper/`

  - Klipper configure firmware
    `make menuconfig`

  - change micro-controller architecture to linux process
  - remove !PA15 (possibly still showing from mcu firmware update)

**make menuconfig (CUI)**
```
[*] Enable extra low-level configuration options
    Micro-controller Architecture (Linux proces) --->
() GPIO pins to set at micro-controller startup
```

  - Compile Klipper firmware for rpi
    - Stop Klipper service  
      `sudo service klipper stop`

    - Compile firmware  
      `make flash`

    - Start Klipper service  
      `sudo service klipper start`
