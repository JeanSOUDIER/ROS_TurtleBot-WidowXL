%Démarrage
if exist('NbPlot','var')
    NbPlot = 1;
else
    %Connection à ROS si on ne l'avait pas déjà fait
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end
%Démarrage de ROS via la toolbox
rosshutdown; %On ne peut pas le lancer si c'est déjà fait
ipTurtlebot = '192.168.1.33';
rosinit(ipTurtlebot);
Homing(SD); %Position de repos
PosArmToMove(SD, false, false); %Position de déplacement
clc;

subO = rossubscriber('/odom')
subOC = rossubscriber('odomCov')
subK = rossubscriber('/robot_pose_ekf/odom_combined')

