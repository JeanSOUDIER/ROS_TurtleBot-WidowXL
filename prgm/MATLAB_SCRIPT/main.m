clear
rosshutdown;

%IPs declarations
ipTurtlebot = '192.168.1.34';
ipArbotix = '192.168.1.33';

%Init Tbot3
tbot = turtlebot(ipTurtlebot);
%Cmd in velocity
tbot.Velocity.TopicName = '/cmd_vel';

%Init Arbotix arm
rosinit(ipArbotix,11311);

%Init camera
mypi = raspi(ipTurtlebot,'pi','turtlebot');

%home
Homing();

%PRGM
%PosO = GetObject(mypi);
%PathFinding(PosO(1), PosO(2), tbot);
%MoveArm(100, -300, -250, 0, true);


TakePhoto(mypi,2);

TakeLidarScan(tbot,3);

getOdometry(tbot)

%log out Arbotix arm
%rosshutdown;
