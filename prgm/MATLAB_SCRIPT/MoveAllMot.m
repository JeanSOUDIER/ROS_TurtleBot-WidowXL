function MoveAllMot(SD, Pos)
    ARB_LOAD_POSE = 8;
    ARB_LOAD_SEQ = 9;
    ARB_PLAY_SEQ = 10;
    ARB_LOOP_SEQ = 11;

    Size = 6;
    
    Max = [2850 2000 2100 2100 820 1000];
    Min = [700 0 0 0 200 0];
    
    Pos = mod(Pos+pi,2*pi)
    
    if(Pos(6) < -pi/4+pi) %pince
        Pos(6) = -pi/4+pi;
    end
    if(Pos(3) > pi/2+pi) %cables USB
        Pos(3) = pi/2+pi;
    end
    
    Pos = round((Pos).*(Max-Min)/(2*pi)+Min)

    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0));
    Time = ones(1,2)*5000;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL));
    SendArm(SD, ARB_PLAY_SEQ, []);
    pause(0.2);
end
