%Function to create the Map and add new views
% Map [TAPIS_X,TAPIS_Y]
% tbot (object Turtlebot)
% P [X Y Theta]

function [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P)
    ROBOT_LENGTH = 320;
    LIDAR_MAX_LENGTH = 3500;
    
    %Add new points of the lidar
    Map = AddLidarPoints(Map, TAPIS_X, TAPIS_Y, ROBOT_LENGTH, LIDAR_MAX_LENGTH, tbot, P);

    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        imagesc(Map);
        colorbar;
    end
end