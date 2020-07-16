%Fonction pour récupérer l'odométrie du robot
% tbot (objet Turtlebot)

function P = TakeOdom(tbot)
    Pos = getOdometry(tbot); %Récupération des points
    Pos.Position(3) = Pos.Orientation(1);
    Pos = Pos.Position;
    P(2) = -1000*Pos(1); %Ajustement en [mm]
    P(1) = -1000*Pos(2);
    P(3) = Pos(3);
end