%Function to find a way to go on the Map
% prm (object PRM)
% PostoGo [X Y Theta]
% tbot (object Turtelbot)
% P [X Y Theta]

function [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P)
    %Cast the Map
    mapI = robotics.BinaryOccupancyGrid(floor(Map/10));
    mapInflated = copy(mapI);
    prm.Map = mapInflated;
    
    %Create points of interests
    startLocation = [P(2) P(1)]
    endLocation = [PosToGo(2) PosToGo(1)]

    %Compute path
    path = findpath(prm, startLocation, endLocation)

    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        show(prm);
    end
end