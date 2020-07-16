%Fonction pour placer le bras en position pour chercher l'objet
% SD (objet de l'USB, fichier de description)

function PosArmToSeeObj(Angle, SD)
    MoveAllMot(SD, [Angle pi/4 -pi/4  -pi/4-pi/16 0 pi/2], true);
end