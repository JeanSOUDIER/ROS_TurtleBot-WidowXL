%Fonction pour déplacer le bras
% SD (objet de l'USB fichier de description)
% Pos [6]
% Delay (bool)

function MoveAllMot(SD, Pos, Delay)
    %Définition des constantes
    ARB_LOAD_POSE = 8;
    ARB_LOAD_SEQ = 9;
    ARB_PLAY_SEQ = 10;
    ARB_LOOP_SEQ = 11;

    Size = 6;
    
    Max = [2800 4100 2100 2100 820 1000];
    Min = [700 2000 0 0 200 0];
    
    %Saturation des angles
    if(Pos(1) < -pi/2)
        Pos(1) = -pi/2;
    end
    if(Pos(1) > pi/2)
        Pos(1) = pi/2;
    end
    if(Pos(2) < -pi/2)
        Pos(2) = -pi/2;
    end
    if(Pos(2) > pi/2)
        Pos(2) = pi/2;
    end
    if(Pos(3) < -pi/2)
        Pos(3) = -pi/2;
    end
    if(Pos(3) > pi/4) %câble USB
        Pos(3) = pi/4;
    end
    if(Pos(4) < -pi/2)
        Pos(4) = -pi/2;
    end
    if(Pos(4) > pi/2)
        Pos(4) = pi/2;
    end
    if(Pos(5) < -pi/2)
        Pos(5) = -pi/2;
    end
    if(Pos(5) > pi/2)
        Pos(5) = pi/2;
    end
    if(Pos(6) < -pi/8+pi/16) %pince
        Pos(6) = -pi/8+pi/16;
    end
    if(Pos(6) > pi/2)
        Pos(6) = pi/2;
    end
    
    Pos = round((Pos+pi/2).*(Max-Min)/(pi)+Min);

    %Envoi des commandes
    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0)); %On envoie des positions
    Time = ones(1,2)*5000;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL)); %Envoie des durées
    SendArm(SD, ARB_PLAY_SEQ, []); %Demande de lecture de la séquence
    if(Delay == true)
        pause(5.2);
    end
end
