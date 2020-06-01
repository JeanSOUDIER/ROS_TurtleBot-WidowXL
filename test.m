MAP_MAX_LENGTH = 3500;
ROBOT_LENGTH = 32;
DIST_MIN = 5;

x = 100
y = 150



%while(abs(computeDist(getOdometry(tbot).Position,[x y 0])) < DIST_MIN)
    map = robotics.BinaryOccupancyGrid(MAP_MAX_LENGTH,MAP_MAX_LENGTH);
    prm = robotics.PRM;
    prm.Map = map;
    %show(prm);
    prm.NumNodes = 100;
    prm.ConnectionDistance = 10;
    %show(prm);
    
    path = findpath(prm, [MAP_MAX_LENGTH/2 MAP_MAX_LENGTH/2], [MAP_MAX_LENGTH/2+x MAP_MAX_LENGTH/2+y]);
    show(prm);
    
   
    
%end