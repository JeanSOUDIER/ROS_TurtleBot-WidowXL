function MoveAllMot(SD, Pos)
    ARB_LOAD_POSE = 8;
    ARB_LOAD_SEQ = 9;
    ARB_PLAY_SEQ = 10;
    ARB_LOOP_SEQ = 11;

    Size = 6;
    
    Max = [2850 4100 2100 2100 820 1000];
    Min = [700 2000 0 0 200 0];
    
    if(Pos(1) < -pi/2)
        Pos(1) = -pi/2;
    end
    if(Pos(1) > pi/2)
        Pos(1) = pi/2;
    end
    if(Pos(2) < -pi/2)
        Pos(2) = -pi/2;
    end
    if(Pos(2) > pi/2)
        Pos(2) = pi/2;
    end
    if(Pos(3) < -pi/2)
        Pos(3) = -pi/2;
    end
    if(Pos(3) > pi/4) %cable USB
        Pos(3) = pi/4;
    end
    if(Pos(4) < -pi/2)
        Pos(4) = -pi/2;
    end
    if(Pos(4) > pi/2)
        Pos(4) = pi/2;
    end
    if(Pos(5) < -pi/2)
        Pos(5) = -pi/2;
    end
    if(Pos(5) > pi/2)
        Pos(5) = pi/2;
    end
    if(Pos(6) < -pi/8+pi/16) %pince
        Pos(6) = -pi/8+pi/16;
    end
    if(Pos(6) > pi/2)
        Pos(6) = pi/2;
    end
    
    Pos = round((Pos+pi/2).*(Max-Min)/(pi)+Min);

    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0));
    Time = ones(1,2)*5000;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL));
    SendArm(SD, ARB_PLAY_SEQ, []);
    pause(5.2);
end
