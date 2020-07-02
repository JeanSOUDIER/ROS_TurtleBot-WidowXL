function Map = AddLidarPoints(Map, TAPIS_X, TAPIS_Y, ROBOT_LENGTH, LIDAR_MAX_LENGTH, tbot, P)
    %[scan,scanMsg] = getLaserScan(tbot);
    %scanMsg = AdjustLidarPoints(scanMsg,LIDAR_MAX_LENGTH);
    [scanMsg, NbPlot] = TakeLidarScan(tbot,100,LIDAR_MAX_LENGTH);
    Somme = scanMsg;
    Angle = [1:1:360];
    P = ones(3,360).*P';
    Angle = mod(Angle'+P(3),360);
    Dot = [1000*Somme.*cosd(Angle)+P(2) -1000*Somme.*sind(Angle)+P(1)];
    Dot = Dot';
    
    Mean = min(Somme);
    Mean = Mean*1000
    A = P(1)-Mean;
    B = P(1)+Mean;
    C = P(2)-Mean;
    D = P(2)+Mean;
    if(A < 1)
        A = 1;
    end
    if(B > TAPIS_X)
        B = TAPIS_X;
    end
    if(C < 1)
        C = 1;
    end
    if(D > TAPIS_Y)
        D = TAPIS_Y;
    end
    A = round(A);
    B = round(B);
    C = round(C);
    D = round(D);
    Map(A:B,C:D) = Map(A:B,C:D)+ones(B-A+1,D-C+1);
    
    for j=1:360
        if(Dot(1,j) < TAPIS_Y-ROBOT_LENGTH/2) & (Dot(1,j) > ROBOT_LENGTH/2) & (Dot(2,j) < TAPIS_X-ROBOT_LENGTH/2) & (Dot(2,j) > ROBOT_LENGTH/2)
            Map(round(Dot(2,j)-ROBOT_LENGTH/2)+1:round(Dot(2,j)+ROBOT_LENGTH/2)-1,floor(Dot(1,j)-ROBOT_LENGTH/2)+1:floor(Dot(1,j)+ROBOT_LENGTH/2)-1) = 10*ones(ROBOT_LENGTH-1,ROBOT_LENGTH-1);
        end
    end
    Map = AdjustMap(Map);
end