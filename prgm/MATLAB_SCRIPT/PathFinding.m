%Fonction pour trouver son chemin sur le terrain
% XY [2] (position où l'on veut aller)
% Map [TAPIS_X,TAPIS_Y]
% tbot (objet Turtlebot)
% P [X,Y,Theta] (position où l'on est)

function [P Map NbPlot] = PathFinding(XY, Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P)
    PosToGo = [XY(1) XY(2) 0];
    PosToGo = double(PosToGo);
    
    %Paramétrage du PRM
    prm = robotics.PRM;
    prm.NumNodes = 1500;
    prm.ConnectionDistance = 100;
    
    %Recherche du chemin
    [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, P);
    
    %Déplacement
    i = 2;
    while(i ~= length(path))
        j = i+4;
        if(j > length(path)) %Saturation
            j = length(path);
        end
        %Si la 4ième coordonnée après celle où l'ont va (où moins s'il n'y en a pas)
        %est inconnue
        if(Map(round(path(j,2)),round(path(j,1))) == 0)
            fprintf('découverte');
            Go([0 0 PosToGo(3)], tbot); %On remet le robot parallèle au terrain
            AdjustOrientation(P(3), tbot); %On corrige l'erreur
            PosToGo(3) = 0;
            %On scanne le terrain
            [Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, [TAPIS_X-path(i,2) path(i,1) 0]);
            %On cherche un nouveau chemin
            [path NbPlot] = Find(Map, prm, PosToGo, tbot, NbPlot, [path(i,2) path(i,1) 0]);
            i = 2;
        end
        %On se déplace
        PosToGo(3) = PosToGo(3) + Go([path(i,1)-path(i-1,1) path(i,2)-path(i-1,2) PosToGo(3)], tbot);
        i = i+1;
    end
    %On se remet parallèle au terrain
    Go([0 0 PosToGo(3)], tbot);
    AdjustOrientation(P(3), tbot); %On ajuste
    %On arrête le robot
    setVelocity(tbot,0);
    P = [XY(1) XY(2) P(3)]; %On renvoie la position actuelle du robot
end