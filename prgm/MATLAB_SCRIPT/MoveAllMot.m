function MoveAllMot(SD, Pos)
    ARB_LOAD_POSE = 8;
    ARB_LOAD_SEQ = 9;
    ARB_PLAY_SEQ = 10;
    ARB_LOOP_SEQ = 11;

    Size = 6;
    
    Max = [2800 2000 0 0 1000 1000];
    Min = [750 0 0 0 0 0];
    
    Pos = round((Pos+pi).*(Max-Min)/(2*pi)+Min);

    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0));
    Time = ones(1,2)*100;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL));
    SendArm(SD, ARB_PLAY_SEQ, []);
    pause(0.2);
end
