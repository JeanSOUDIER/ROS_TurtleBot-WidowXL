
Pos = [0 pi/2 -pi/2 0 0 pi/2];
Pos(6) = Pos(6)-3*pi/20;
MoveAllMotTime(SD, Pos, 100, true);
while(IsGrip(SD)+120 > Pos(6)*312.5+506.25) && (IsGrip(SD)-120 < Pos(6)*312.5+506.25)
    Pos(6) = Pos(6)-pi/20;
    MoveAllMotTime(SD, Pos, 100, true);
    if(Pos(6) < -pi/2)
        test = true;
        break;
    end
end

