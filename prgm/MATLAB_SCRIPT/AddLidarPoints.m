function Mat = AddLidarPoints(MAP_MAX_LENGTH, ROBOT_LENGTH, tbot)
    [scan,scanMsg] = getLaserScan(tbot);
    scanMsg = AdjustLidarPoints(scanMsg);
    Angle = [1:1:360];
    Dot = [1000*scanMsg.Ranges.*cosd(Angle') -1000*scanMsg.Ranges.*sind(Angle')];
    Dot = Dot';

    Mat = zeros(MAP_MAX_LENGTH,MAP_MAX_LENGTH);

    for j=1:360
        if(abs(Dot(1,j)) ~= Inf) && (abs(Dot(2,j)) ~= Inf)
            if(Dot(1,j) > (MAP_MAX_LENGTH-ROBOT_LENGTH)/2)
                Dot(1,j) = (MAP_MAX_LENGTH-ROBOT_LENGTH)/2;
            end
            if(Dot(1,j) < -(MAP_MAX_LENGTH-ROBOT_LENGTH)/2)
                Dot(1,j) = -(MAP_MAX_LENGTH-ROBOT_LENGTH)/2;
            end
            if(Dot(2,j) > (MAP_MAX_LENGTH-ROBOT_LENGTH)/2)
                Dot(2,j) = (MAP_MAX_LENGTH-ROBOT_LENGTH)/2;
            end
            if(Dot(2,j) < -(MAP_MAX_LENGTH-ROBOT_LENGTH)/2)
                Dot(2,j) = -(MAP_MAX_LENGTH-ROBOT_LENGTH)/2;
            end
            Mat(floor(Dot(2,j)-ROBOT_LENGTH/2+MAP_MAX_LENGTH/2)+1:floor(Dot(2,j)+ROBOT_LENGTH/2+MAP_MAX_LENGTH/2)-1,floor(Dot(1,j)-ROBOT_LENGTH/2+MAP_MAX_LENGTH/2)+1:floor(Dot(1,j)+ROBOT_LENGTH/2+MAP_MAX_LENGTH/2)-1) = ones(ROBOT_LENGTH-1,ROBOT_LENGTH-1);
        end
    end
end