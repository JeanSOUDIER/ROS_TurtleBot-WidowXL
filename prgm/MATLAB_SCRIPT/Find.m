function [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P)
    mapI = robotics.BinaryOccupancyGrid(floor(Map/10));
    mapInflated = copy(mapI);
    prm.Map = mapInflated;
    
    startLocation = [P(2) P(1)]
    endLocation = [PosToGo(2) PosToGo(1)]

    path = findpath(prm, startLocation, endLocation)

    figure(NbPlot);
    NbPlot = NbPlot+1;
    show(prm);
end