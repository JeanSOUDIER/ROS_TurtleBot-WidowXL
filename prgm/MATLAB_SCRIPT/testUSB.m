clear

ARB_SIZE_POSE = 7;
ARB_LOAD_POSE = 8;
ARB_LOAD_SEQ = 9;
ARB_PLAY_SEQ = 10;
ARB_LOOP_SEQ = 11;

Tab = [2048 1];

for i = 1:2
    mypi = raspi;
    SD = serialdev(mypi,'/dev/ttyUSB0',115200);
    pause(10);

    SendArm(SD, ARB_SIZE_POSE, [1]);
    Pos = Tab(i)
    SendArm(SD, ARB_LOAD_POSE, [mod(Pos,256) floor(Pos/256)]);
    %SendArm(SD, ARB_LOAD_POSE, [0 i]);
    SendArm(SD, ARB_LOAD_SEQ, [0 232 3]);
    SendArm(SD, ARB_PLAY_SEQ, []);
    %pause(2);
    %write(SD,[72],'uint8');
    clear SD;
    clear mypi;
end

%{
Send = [255 253 3 7 1]; %255,253,3,7,10,238
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum]
%write(SD,Send,'uint8');
SendArm(SD, ARB_SIZE_POSE, [1]);
%pause(2);
Send = [255 253 4 8 10 13];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(SD,Send,'uint8');
%pause(2);
Send = [255 253 5 9 100 0 0];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(SD,Send,'uint8');
%pause(2);
Send = [255 253 2 11];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(SD,Send,'uint8');
%}

