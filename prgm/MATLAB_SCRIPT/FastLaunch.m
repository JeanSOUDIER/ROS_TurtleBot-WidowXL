if exist('NbPlot','var')
    NbPlot = 1;
else
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end
rosshutdown;
ipTurtlebot = '192.168.1.33';
rosinit(ipTurtlebot);
Homing(SD);
PosArmToMove(SD, false, false);
