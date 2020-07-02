%Function to set the number of motor
% SD (object USB file descriptor)

function SetNbMot(SD)
    ARB_SIZE_POSE = 7;
    nb = 6;
    SendArm(SD, ARB_SIZE_POSE, [nb]);
end