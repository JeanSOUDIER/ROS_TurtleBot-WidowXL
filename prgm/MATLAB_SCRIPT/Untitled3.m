rosshutdown
ipTurtlebot = '192.168.1.33';
rosinit(ipTurtlebot);

subIMU = rossubscriber('/imu');
subODOM = rossubscriber('/odom');

pause(5);

Podom0 = [-1000*subODOM.LatestMessage.Pose.Pose.Position.X -1000*subODOM.LatestMessage.Pose.Pose.Position.Y subODOM.LatestMessage.Pose.Pose.Orientation.Z];
Pimu0 = [1000*subIMU.LatestMessage.LinearAcceleration.X 1000*subIMU.LatestMessage.LinearAcceleration.Y subIMU.LatestMessage.Orientation.Z];

Go([100 -50 0], tbot);
pause(1);

Podom1 = [-1000*subODOM.LatestMessage.Pose.Pose.Position.X -1000*subODOM.LatestMessage.Pose.Pose.Position.Y subODOM.LatestMessage.Pose.Pose.Orientation.Z];
Pimu1 = [1000*subIMU.LatestMessage.LinearAcceleration.X 1000*subIMU.LatestMessage.LinearAcceleration.Y subIMU.LatestMessage.Orientation.Z];

Podom = Podom1-Podom0
Pimu = Pimu1-Pimu0


