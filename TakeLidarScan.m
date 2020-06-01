function TakeLidarScan(tbot,NbPlot)
    [scan,scanMsg] = getLaserScan(tbot);
    scanMsg = AdjustLidarPoints(scanMsg);
    figure(NbPlot);
    plot(scanMsg);
end