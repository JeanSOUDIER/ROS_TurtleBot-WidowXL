#!/bin/bash
cd widowx_arm/
source devel/setup.bash
roslaunch widowx_arm_bringup arm_moveit.launch sim:=false sr300:=false
cd ..
