%Fonction pour trouver un chemin sur le terrain
% prm (objet PRM)
% PostoGo [X Y Theta]
% tbot (objet Turtelbot)
% P [X Y Theta] (position du robot)

function [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P)
    %Cast du terrain
    mapI = robotics.BinaryOccupancyGrid(floor(Map/10));
    mapInflated = copy(mapI);
    prm.Map = mapInflated;
    
    %Création des points d'intérêts
    startLocation = [P(2) P(1)];
    endLocation = [PosToGo(2) PosToGo(1)];
    
    startLocation = double(startLocation);
    endLocation = double(endLocation);

    %Calcul du chemin
    path = findpath(prm, startLocation, endLocation)

    %Affichage
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        show(prm);
    end
end