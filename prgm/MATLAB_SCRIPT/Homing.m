%Fonction de placement en position de repos du bras

function Homing(SD)
    fprintf('Position de repos !!!\n');
    MoveAllMot(SD, [0 0 0 0 0 pi/2], true);
end