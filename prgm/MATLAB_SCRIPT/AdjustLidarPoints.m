%Function to suppress noise points
% scanMsg [360]
% LIDAR_MAX_LENGTH (int8) for error value

function Out = AdjustLidarPoints(scanMsg,LIDAR_MAX_LENGTH)
    Out = (LIDAR_MAX_LENGTH+10)*ones(360,1);
    DIST_MAX = 0.1;
    %If points are not on the robot and are close to each ones
    if(scanMsg.Ranges(1) > 0.165)
        if(abs(scanMsg.Ranges(1)-scanMsg.Ranges(2)) < DIST_MAX) | (abs(scanMsg.Ranges(1)-scanMsg.Ranges(length(scanMsg.Ranges)) < DIST_MAX))
            Out(1) = scanMsg.Ranges(1);
        end
    end
    if(scanMsg.Ranges(length(scanMsg.Ranges)) > 0.165)
        if(abs(scanMsg.Ranges(length(scanMsg.Ranges))-scanMsg.Ranges(length(scanMsg.Ranges)-1)) < DIST_MAX) | (abs(scanMsg.Ranges(1)-scanMsg.Ranges(length(scanMsg.Ranges))) < DIST_MAX)
            Out(length(scanMsg.Ranges)) = scanMsg.Ranges(length(scanMsg.Ranges));
        end
    end
    for i = 2:length(scanMsg.Ranges)-1
        if(scanMsg.Ranges(i) > 0.165)
            if(abs(scanMsg.Ranges(i)-scanMsg.Ranges(i-1)) < DIST_MAX) | (abs(scanMsg.Ranges(i)-scanMsg.Ranges(i+1)) < DIST_MAX)
                Out(i) = scanMsg.Ranges(i);
            end
        end
    end
end