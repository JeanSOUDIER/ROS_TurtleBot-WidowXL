function PosArmToMove(SD, Grip)
    if(Grip == true)
        MoveAllMot(SD, [0 pi/2 -pi/2 0 0 -pi/2]);
    else
        MoveAllMot(SD, [0 pi/2 -pi/2 0 0 pi/2]);
    end
end