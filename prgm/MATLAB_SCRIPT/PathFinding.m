%clear

%rosshutdown;
%ipTurtlebot = '192.168.1.34';
%tbot = turtlebot(ipTurtlebot);
%tbot.Velocity.TopicName = '/cmd_vel';

%resetOdometry(tbot);
%pos = getOdometry(tbot);
%Dist = pos.Position*1000;
%Dist(3) = 10000*pos.Orientation(1);

function PathFinding(X, Y, tbot)
    MAP_MAX_LENGTH = 3500;
    ROBOT_LENGTH = 320;

    PosToGo = [X Y 0];
    PosToGo = double(PosToGo);
    
    Mat = AddLidarPoints(MAP_MAX_LENGTH, ROBOT_LENGTH, tbot);

    map = robotics.BinaryOccupancyGrid(Mat);
    mapInflated = copy(map);
    prm = robotics.PRM
    prm.NumNodes = 2000;
    prm.ConnectionDistance = 200;
    prm.Map = mapInflated;

    startLocation = [MAP_MAX_LENGTH/2 MAP_MAX_LENGTH/2]
    endLocation = [MAP_MAX_LENGTH/2+PosToGo(1) MAP_MAX_LENGTH/2+PosToGo(2)]

    path = findpath(prm, startLocation, endLocation)

    figure;
    show(prm);
    
    for i = 2:length(path)
        PosToGo(3) = PosToGo(3) + Go([path(i,1)-path(i-1,1) path(i,2)-path(i-1,2) PosToGo(3)], tbot);
    end
    Go([0 0 PosToGo(3)], tbot);
    
    setVelocity(tbot,0);
end