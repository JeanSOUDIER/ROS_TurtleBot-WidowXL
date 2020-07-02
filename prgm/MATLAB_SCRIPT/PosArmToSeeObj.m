%Function to place the arm the search an object
% SD (object USB file descriptor)

function PosArmToSeeObj(Angle, SD)
    MoveAllMot(SD, [Angle pi/4 -pi/4  -pi/4-pi/16 0 pi/2], true);
end