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
SD = serialdev(mypi,'/dev/ttyUSB_ARBO',115200);
pause(10);
%Declare nb mot on arm
SetNbMot(SD);

setVelocity(tbot,1);
pause(1);
setVelocity(tbot,0);

%home
fprintf('HOMING !!!\n');
MoveAllMot(SD, zeros(1,6));
pause(5);
MoveAllMot(SD, ones(1,6)*pi/2);
pause(5);


pause(1);
[a NbPlot] = TakeLidarScan(tbot,NbPlot);

pause(1);
TakePhoto(mypi, NbPlot);

%PRGM
%{
fprintf('PRGM !!!\n');
Img = TakePhoto(mypi,-1);
[PosO NbPlot] = GetObject(Img, NbPlot);
if(norm(PosO) == 0)
    pause(1);
    Img = TakePhoto(mypi,-1);
    [PosO NbPlot] = GetObject(Img, NbPlot);
    if(norm(PosO) == 0)
        setVelocity(tbot,1);
        pause(0.2);
        setVelocity(tbot,0);
        pause(2);
        Img = TakePhoto(mypi,-1);
        [PosO NbPlot] = GetObject(Img, NbPlot);
        if(norm(PosO) == 0)
            pause(1);
            Img = TakePhoto(mypi,-1);
            [PosO NbPlot] = GetObject(Img, NbPlot);
        end
    end
end
if(norm(PosO) ~= 0)
    PosO = ComputeDistCam(600, 60, PosO);
    NbPlot = PathFinding(PosO(1), PosO(2), tbot, NbPlot);
    pause(1);
    MoveArm(SD, 300, 0, -200, 0, true);
end

TakePhoto(mypi, NbPlot);
%}
