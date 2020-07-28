%D�marrage
if exist('NbPlot','var')
    NbPlot = 1;
else
    %Connection � ROS si on ne l'avait pas d�j� fait
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end
%D�marrage de ROS via la toolbox
rosshutdown; %On ne peut pas le lancer si c'est d�j� fait
ipTurtlebot = '192.168.1.33';
rosinit(ipTurtlebot);
Homing(SD); %Position de repos
PosArmToMove(SD, false, false); %Position de d�placement
clc;

subO = rossubscriber('/odom')
subOC = rossubscriber('odomCov')
subK = rossubscriber('/robot_pose_ekf/odom_combined')

