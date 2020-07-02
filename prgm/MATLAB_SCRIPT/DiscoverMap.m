function [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P)
    ROBOT_LENGTH = 320;%320
    LIDAR_MAX_LENGTH = 3500;
    P
    
    Map = AddLidarPoints(Map, TAPIS_X, TAPIS_Y, ROBOT_LENGTH, LIDAR_MAX_LENGTH, tbot, P);

    figure(NbPlot);
    NbPlot = NbPlot+1;
    imagesc(Map);
    colorbar;
end