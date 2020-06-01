function scanMsg = AdjustLidarPoints(scanMsg)
    for i = 1:length(scanMsg.Ranges)
        if(scanMsg.Ranges(i) < 0.16) %supression des points sur le robot (entretoise et cables)
            scanMsg.Ranges(i) = nan;
        end
    end
end