%Fonction pour créer le terrain virtuel
% Map [TAPIS_X,TAPIS_Y]
% tbot (objet Turtlebot)
% P [X Y Theta] (position du robot)

function [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P)
    ROBOT_LENGTH = 320; %Longueur du robot
    LIDAR_MAX_LENGTH = 3500; %Distance maximum de vision du lidar
    
    %Ajout des points du lidar dans le terrain
    Map = AddLidarPoints(Map, TAPIS_X, TAPIS_Y, ROBOT_LENGTH, LIDAR_MAX_LENGTH, tbot, P);

    %Affichage
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        imagesc(Map);
        colorbar;
    end
end