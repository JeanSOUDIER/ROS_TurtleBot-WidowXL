Delay = 4;

P = [0 0 0 0];

rosshutdown;
ipTurtlebot = '192.168.1.33';
rosinit(ipTurtlebot);
pause(1);
sub = rossubscriber('/imu');
pause(3);

t = timer;
t.TimerFcn = @takeBreak;
t.Period = Delay;
Cx = sub.LatestMessage.Orientation.X;
Cy = sub.LatestMessage.Orientation.Y;
Cz = sub.LatestMessage.Orientation.Z;
Cw = sub.LatestMessage.Orientation.W;
Coord = [Cx Cy Cz Cw ; P]
t.userData = Coord;
t.TasksToExecute = round(1000/Delay); %approx 10 min
t.ExecutionMode = 'fixedRate';
start(t);

pause(0.5);
P = [12 8 4 0];
Coord = [sub.LatestMessage.Orientation.X sub.LatestMessage.Orientation.Y sub.LatestMessage.Orientation.Z sub.LatestMessage.Orientation.W; P]
t.userData = Coord;
pause(3);
stop(t);