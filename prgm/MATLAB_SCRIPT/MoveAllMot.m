function MoveAllMot(SD, Pos)
    ARB_SIZE_POSE = 7;
    ARB_LOAD_POSE = 8;
    ARB_LOAD_SEQ = 9;
    ARB_PLAY_SEQ = 10;
    ARB_LOOP_SEQ = 11;

    Size = 6;

    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0));
    Time = ones(1,2)*100;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL));
    SendArm(SD, ARB_PLAY_SEQ, []);
    pause(0.2);
end
