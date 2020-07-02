%Function to home the arm

function Homing(SD)
    fprintf('HOMING !!!\n');
    MoveAllMot(SD, [0 0 0 0 0 pi/2], true);
end