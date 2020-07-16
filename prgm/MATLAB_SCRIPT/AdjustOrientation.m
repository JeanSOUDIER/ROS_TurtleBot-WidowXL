%Fonction pour ajuster l'orientation du robot
% A0 est l'angle d'offset

function AdjustOrientation(A0, tbot)
    a = TakeOdom(tbot); %On récupère la position du robot via ROS
    Go([0 0 a(3)-A0], tbot); %On tourne de la position actuelle moins l'offset
end