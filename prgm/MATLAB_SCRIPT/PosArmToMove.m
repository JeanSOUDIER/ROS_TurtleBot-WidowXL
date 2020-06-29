function PosArmToMove(SD, Grip, Delay)
    if(Grip == true)
        MoveAllMot(SD, [0 pi/2 -pi/2 0 0 -pi/2], Delay);
    else
        MoveAllMot(SD, [0 pi/2 -pi/2 0 0 pi/2], Delay);
    end
end