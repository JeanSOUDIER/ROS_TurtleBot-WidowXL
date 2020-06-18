function [scanMsg, NbPlot] = TakeLidarScan(tbot,NbPlot)
    [scan,scanMsg] = getLaserScan(tbot);
    scanMsg = AdjustLidarPoints(scanMsg);
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        plot(scanMsg);
    else
        NbPlot = -1;
    end
end