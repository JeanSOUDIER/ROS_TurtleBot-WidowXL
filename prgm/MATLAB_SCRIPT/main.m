clear
NbPlot = 1;
%rosshutdown;

%IPs declarations
ipTurtlebot = '192.168.1.34';
ipArbotix = '192.168.1.33';

%Init Tbot3
tbot = turtlebot(ipTurtlebot);
%Cmd in velocity
tbot.Velocity.TopicName = '/cmd_vel';

%Init Arbotix arm
%rosinit(ipArbotix,11311);

%Init camera
mypi = raspi(ipTurtlebot,'pi','turtlebot');
SD = serialdev(mypi,'/dev/ttyUSB1',115200);
pause(10);
SendArm(SD, 7, [6]);




setVelocity(tbot,1);
pause(1);
setVelocity(tbot,0);

pause(1);
MoveAllMot(SD, [1000 1000 400 400 400 400]);
pause(2);
MoveAllMot(SD, [2000 2000 600 600 600 600]);

pause(1);
TakeLidarScan(tbot,1);

pause(1);
TakePhoto(mypi,2);
%home
%Homing();

%PRGM
%GotoObject(tbot, mypi);

%{
Img = TakePhoto(mypi,-1);
[PosO NbPlot] = GetObject(Img, NbPlot);
if(norm(PosO) ~= 0)
    PosO = ComputeDistCam(600, 60, PosO);
    PathFinding(PosO(1), PosO(2), tbot);
    pause(1);
    MoveArm(300, 0, -200, 0, true);
end

TakePhoto(mypi, NbPlot);
%}

%log out Arbotix arm
%rosshutdown;
