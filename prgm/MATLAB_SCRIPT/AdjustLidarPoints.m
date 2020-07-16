%Fonction de filtre du lidar
% scanMsg [360]
% LIDAR_MAX_LENGTH (int8) valeur d'erreur

function Out = AdjustLidarPoints(scanMsg,LIDAR_MAX_LENGTH)
    %La sortie vaut le code d'erreur
    Out = (LIDAR_MAX_LENGTH+10)*ones(360,1);
    DIST_MAX = 0.1; %Distance d'un point isolé
    %Si les points ne sont pas sur le robot
    if(scanMsg.Ranges(1) > 0.165)
        %Si les points ne sont pas trop éloignés de leur prédécesseur et
        %successeur (ici point 1)
        if(abs(scanMsg.Ranges(1)-scanMsg.Ranges(2)) < DIST_MAX) | (abs(scanMsg.Ranges(1)-scanMsg.Ranges(length(scanMsg.Ranges)) < DIST_MAX))
            Out(1) = scanMsg.Ranges(1);
        end
    end
    %Idem point 360
    if(scanMsg.Ranges(length(scanMsg.Ranges)) > 0.165)
        if(abs(scanMsg.Ranges(length(scanMsg.Ranges))-scanMsg.Ranges(length(scanMsg.Ranges)-1)) < DIST_MAX) | (abs(scanMsg.Ranges(1)-scanMsg.Ranges(length(scanMsg.Ranges))) < DIST_MAX)
            Out(length(scanMsg.Ranges)) = scanMsg.Ranges(length(scanMsg.Ranges));
        end
    end
    %Idem pour tout les autres point (2-359)
    for i = 2:length(scanMsg.Ranges)-1
        if(scanMsg.Ranges(i) > 0.165)
            if(abs(scanMsg.Ranges(i)-scanMsg.Ranges(i-1)) < DIST_MAX) | (abs(scanMsg.Ranges(i)-scanMsg.Ranges(i+1)) < DIST_MAX)
                Out(i) = scanMsg.Ranges(i);
            end
        end
    end
end