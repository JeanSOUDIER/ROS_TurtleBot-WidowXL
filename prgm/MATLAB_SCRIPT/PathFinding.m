clear

MAP_MAX_LENGTH = 3500;
ROBOT_LENGTH = 32;
DIST_MIN = 5;

x = 100
y = 120

%loop
Dot = [100 120 500;100 200 -300];

Mat = zeros(MAP_MAX_LENGTH,MAP_MAX_LENGTH);

DotSize = size(Dot);
for j=1:DotSize(2)
    Mat(Dot(1,j)-ROBOT_LENGTH/2+MAP_MAX_LENGTH/2:Dot(1,j)+ROBOT_LENGTH/2+MAP_MAX_LENGTH/2,Dot(2,j)-ROBOT_LENGTH/2+MAP_MAX_LENGTH/2:Dot(2,j)+ROBOT_LENGTH/2+MAP_MAX_LENGTH/2) = ones(ROBOT_LENGTH+1,ROBOT_LENGTH+1);
end

map = robotics.BinaryOccupancyGrid(Mat);

mapInflated = copy(map);

prm = robotics.PRM;

prm.Map = mapInflated;

%prm.NumNodes = 1;

%prm.ConnectionDistance = 1;

startLocation = [MAP_MAX_LENGTH/2 MAP_MAX_LENGTH/2];
endLocation = [MAP_MAX_LENGTH/2+x MAP_MAX_LENGTH/2+y];

path = findpath(prm, startLocation, endLocation);

figure(2);
show(prm);