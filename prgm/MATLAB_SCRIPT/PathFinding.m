%Function to find a way and full the Map
% XY [2]
% Map [TAPIS_X,TAPIS_Y]
% tbot (object Turtlebot)

function [P NbPlot] = PathFinding(XY, Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P)
    PosToGo = [XY(1) XY(2) 0];
    PosToGo = double(PosToGo);
    
    %Param the PRM
    prm = robotics.PRM;
    prm.NumNodes = 1500;
    prm.ConnectionDistance = 100;
    
    %Find the way
    [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P);
    
    %Go to
    i = 2;
    while(i ~= length(path))
        j = i+4;
        if(j > length(path))
            j = length(path);
        end
        if(Map(round(path(j,2)),round(path(j,1))) == 0) %Area unknown
            fprintf('discovering');
            Go([0 0 PosToGo(3)], tbot);
            PosToGo(3) = 0;
            [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, [TAPIS_X-path(i,2) path(i,1) 0]);
            [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, [path(i,2) path(i,1) 0]);
            i = 2;
        end
        %Move
        PosToGo(3) = PosToGo(3) + Go([path(i,1)-path(i-1,1) path(i,2)-path(i-1,2) PosToGo(3)], tbot);
        i = i+1;
    end
    %Turn to the 0 angle
    Go([0 0 PosToGo(3)], tbot);
    
    %Stop
    setVelocity(tbot,0);
    P = [XY(1) XY(2) 0];
end