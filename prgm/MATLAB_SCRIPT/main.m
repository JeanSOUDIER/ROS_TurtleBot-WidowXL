clear
NbPlot = 1;

%IPs declarations
ipTurtlebot = '192.168.1.34';

%Init Tbot3
tbot = turtlebot(ipTurtlebot);
%Cmd in velocity
tbot.Velocity.TopicName = '/cmd_vel';

%Init camera & arm
mypi = raspi(ipTurtlebot,'pi','turtlebot');
SD = serialdev(mypi,'/dev/ttyUSB1',115200);
pause(10);
%Declare Nb mot on arm
SendArm(SD, 7, [6]);

%home
fprintf('HOMING !!!');
MoveAllMot(SD, zeros(1,6));

%PRGM
%{
fprintf('PRGM !!!');
Img = TakePhoto(mypi,-1);
[PosO NbPlot] = GetObject(Img, NbPlot);
if(norm(PosO) ~= 0)
    PosO = ComputeDistCam(600, 60, PosO);
    PathFinding(PosO(1), PosO(2), tbot);
    pause(1);
    MoveArm(SD, 300, 0, -200, 0, true);
end

TakePhoto(mypi, NbPlot);
%}
