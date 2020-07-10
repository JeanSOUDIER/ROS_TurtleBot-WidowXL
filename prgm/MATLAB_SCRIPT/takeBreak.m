function takeBreak(mTimer,~)
    subIMU = rossubscriber('/imu');
    subODOM = rossubscriber('/odom');
    G = mTimer.userData;
    Imu = G(:,1:3);
    Odom = G(:,4:6);
    ODOMdata = receive(subODOM,1);
    Odom = [Odom ; -1000*ODOMdata.Pose.Pose.Position.X -1000*ODOMdata.Pose.Pose.Position.Y ODOMdata.Pose.Pose.Orientation.Z];
    IMUdata = receive(subIMU,1);
    Imu = [Imu ; 1000*IMUdata.Orientation.X 1000*IMUdata.Orientation.Y IMUdata.Orientation.Z];
    G = [Imu Odom];
    mTimer.userData = G;
end