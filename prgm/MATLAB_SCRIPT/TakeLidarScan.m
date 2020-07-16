%Fonction pour récupérer les points du lidar
% tbot (objet Turtlebot)

function [scanMsg, NbPlot] = TakeLidarScan(tbot,NbPlot,LIDAR_MAX_LENGTH)
    [scan,scanMsg] = getLaserScan(tbot); %Récupération des points
    scanMsg = AdjustLidarPoints(scanMsg,LIDAR_MAX_LENGTH); %Filtrage
    %Affichage
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        Angle = [1:1:360]';
        scatter(1000*scanMsg.*cosd(Angle),1000*scanMsg.*sind(Angle));
        xlim([-LIDAR_MAX_LENGTH/2 LIDAR_MAX_LENGTH/2]);
        ylim([-LIDAR_MAX_LENGTH/2 LIDAR_MAX_LENGTH/2]);
    end
end