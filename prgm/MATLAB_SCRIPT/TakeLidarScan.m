function [scanMsg, NbPlot] = TakeLidarScan(tbot,NbPlot,LIDAR_MAX_LENGTH)
    [scan,scanMsg] = getLaserScan(tbot);
    scanMsg = AdjustLidarPoints(scanMsg,LIDAR_MAX_LENGTH);
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        Angle = [1:1:360]';
        scatter(1000*scanMsg.*cosd(Angle),1000*scanMsg.*sind(Angle));
        xlim([-LIDAR_MAX_LENGTH/2 LIDAR_MAX_LENGTH/2]);
        ylim([-LIDAR_MAX_LENGTH/2 LIDAR_MAX_LENGTH/2]);
    else
        NbPlot = -1;
    end
end