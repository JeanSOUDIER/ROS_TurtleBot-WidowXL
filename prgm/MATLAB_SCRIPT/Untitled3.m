%rosshutdown
%ipTurtlebot = '192.168.1.33';
%rosinit(ipTurtlebot);
%rate = rosrate(100)

Delay = 1;
Duration = 100; %s
TAPIS_X = 1500;
TAPIS_Y = 2200;
TAPIS_X0 = TAPIS_X/2;
TAPIS_Y0 = 450;
Map = zeros(TAPIS_X,TAPIS_Y);
P = [TAPIS_X0 TAPIS_Y0 0];
[Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);

t = timer;
t.TimerFcn = @takeBreak;
t.Period = Delay;
Imu = [0 0 0 ; 0 0 0];
Odom = [0 0 0; 0 0 0];
G = [Imu Odom];
t.userData = G;
t.TasksToExecute = round(Duration/Delay);
t.ExecutionMode = 'fixedRate';
start(t);

%{
ODOMdata = receive(subODOM,1);
Podom0 = [-1000*ODOMdata.Pose.Pose.Position.X -1000*ODOMdata.Pose.Pose.Position.Y ODOMdata.Pose.Pose.Orientation.Z];
IMUdata = receive(subIMU,1);
Pimu0 = [1000*IMUdata.LinearAcceleration.X 1000*IMUdata.LinearAcceleration.Y IMUdata.LinearAcceleration.Z];
PimuO0 = [1000*IMUdata.Orientation.X 1000*IMUdata.Orientation.Y IMUdata.Orientation.Z];
%}

pause(1);
%Go([100 0 0], tbot);
[P Map NbPlot] = PathFinding([TAPIS_X0 1200], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
pause(1);

stop(t);

G = t.UserData;
Imu = G(:,1:3);
ImuAccX = Imu(3:length(Imu),1:1);
ImuAccY = Imu(3:length(Imu),2:2);
ImuAccZ = Imu(3:length(Imu),3:3);
ImuVelX = cumtrapz(ImuAccX);
ImuVelY = cumtrapz(ImuAccY);
ImuVelZ = cumtrapz(ImuAccZ);
ImuPosX = cumtrapz(ImuVelX);
ImuPosY = cumtrapz(ImuVelY);
ImuPosZ = cumtrapz(ImuVelZ);
Odom = G(:,4:6);
OdomX = Odom(3:length(Odom),1:1);
OdomY = Odom(3:length(Odom),2:2);
OdomZ = Odom(3:length(Odom),3:3);
OdomVelX = [diff(OdomX);0];
OdomVelY = [diff(OdomY);0];
OdomVelZ = [diff(OdomZ);0];

a = size(ImuAccX)
t = linspace(1,a(1)+1,a(1));
size(t)
figure(1);
hold on;
plot(t,ImuAccX,'r-*');
plot(t,ImuAccY,'b-*');
plot(t,ImuAccZ,'g-*');
hold off;
figure(2);
hold on;
plot(t,OdomX,'r-*');
plot(t,OdomY,'b-*');
plot(t,OdomZ,'g-*');
hold off;
figure(3);
hold on;
plot(t,ImuVelX,'r-*');
plot(t,ImuVelY,'b-*');
plot(t,ImuVelZ,'g-*');
hold off;
figure(4);
hold on;
plot(t,ImuPosX,'r-*');
plot(t,ImuPosY,'b-*');
plot(t,ImuPosZ,'g-*');
hold off;
figure(5);
hold on;
plot(t,OdomVelX,'r-*');
plot(t,OdomVelY,'b-*');
plot(t,OdomVelZ,'g-*');
hold off;
