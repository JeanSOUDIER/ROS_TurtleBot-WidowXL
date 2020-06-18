function SetNbMot()
    ARB_SIZE_POSE = 7;
    nb = 6;
    SendArm(SD, ARB_SIZE_POSE, [nb]);
end