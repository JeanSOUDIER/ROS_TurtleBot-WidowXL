%Fonction pour ajouter les obstacles et les endroits connus
% Map [TAPIS_X,TAPIS_Y]
% ROBOT_LENGTH, LIDAR_MAX_LENGTH (int8)
% tbot (objet Turtlebot)
% P [X Y Theta] (position du robot)

function Map = AddLidarPoints(Map, TAPIS_X, TAPIS_Y, ROBOT_LENGTH, LIDAR_MAX_LENGTH, tbot, P)
    %Récupération des points du lidar
    [scanMsg, NbPlot] = TakeLidarScan(tbot,100,LIDAR_MAX_LENGTH);
    Somme = scanMsg;
    Angle = [1:1:360];
    P = ones(3,360).*P';
    Angle = mod(Angle'+P(3),360);
    %Conversion en cartésien
    Dot = [1000*Somme.*cosd(Angle)+P(2) -1000*Somme.*sind(Angle)+P(1)];
    Dot = Dot';
    
    %Création de la zone connue
    M1 = 1000*min(Somme(45:135)); %Nord
    M2 = 1000*min(Somme(135:225)); %Ouest
    M3 = 1000*min(Somme(225:315)); %Sud
    S = [Somme(1:45);Somme(315:360)];
    M4 = 1000*min(S); %Est
    %Ajustement par rapport à la position du robot
    A = P(1)-M1;
    B = P(1)+M3;
    C = P(2)-M2;
    D = P(2)+M4;
    %Saturation par rapport aux bords du terrain
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
    %Arrondi pour correspondre à des cases de matrices
    A = round(A);
    B = round(B);
    C = round(C);
    D = round(D);
    %Ajout dans le terrain
    Map(A:B,C:D) = Map(A:B,C:D)+ones(B-A+1,D-C+1);
    %Ajout des obstacles
    for j=1:360
        %Si le point est dans le terrain
        if(Dot(1,j) < TAPIS_Y-ROBOT_LENGTH/2) & (Dot(1,j) > ROBOT_LENGTH/2) & (Dot(2,j) < TAPIS_X-ROBOT_LENGTH/2) & (Dot(2,j) > ROBOT_LENGTH/2)
            Map(round(Dot(2,j)-ROBOT_LENGTH/2)+1:round(Dot(2,j)+ROBOT_LENGTH/2)-1,floor(Dot(1,j)-ROBOT_LENGTH/2)+1:floor(Dot(1,j)+ROBOT_LENGTH/2)-1) = 10*ones(ROBOT_LENGTH-1,ROBOT_LENGTH-1);
        end
    end
    %On ajuste le terrain car le terrain connu est additionner et sur un
    %obstacle il crée (11 et non 10) et de même si on connait 2 fois le
    %même terrain (2 devient 1)
    Map = AdjustMap(Map);
end