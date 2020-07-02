function [P NbPlot] = PathFinding(XY, Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, TAPIS_X0, TAPIS_Y0, P)
    PosToGo = [XY(1) XY(2) 0];
    PosToGo = double(PosToGo);
    
    prm = robotics.PRM;
    prm.NumNodes = 1500;
    prm.ConnectionDistance = 100;
    
    [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P);
    
    i = 2;
    while(i ~= length(path))
        j = i+4;
        if(j > length(path))
            j = length(path);
        end
        if(Map(round(path(j,2)),round(path(j,1))) == 0)
            fprintf('discovering');
            Go([0 0 PosToGo(3)], tbot);
            PosToGo(3) = 0;
            [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, [TAPIS_X-path(i,2) path(i,1) 0]);
            [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, [path(i,2) path(i,1) 0]);
            i = 2;
        end
        PosToGo(3) = PosToGo(3) + Go([path(i,1)-path(i-1,1) path(i,2)-path(i-1,2) PosToGo(3)], tbot);
        i = i+1;
    end
    Go([0 0 PosToGo(3)], tbot);
    
    setVelocity(tbot,0);
    P = [XY(1) XY(2) 0];
end