%clear

ARB_SIZE_POSE = 7;
ARB_LOAD_POSE = 8;
ARB_LOAD_SEQ = 9;
ARB_PLAY_SEQ = 10;
ARB_LOOP_SEQ = 11;

Size = 6;


%mypi = raspi;
ipTurtlebot = '192.168.1.34';
mypi = raspi(ipTurtlebot,'pi','turtlebot');
SD = serialdev(mypi,'/dev/ttyUSB2',115200);
pause(10);

id = 0;
SendArm(SD, ARB_SIZE_POSE, [Size]);

for i = 0:40
    i% = 2000;
    Pos = 100*i*ones(1,Size);
    SendArm(SD, ARB_LOAD_POSE, CastPos(Pos, 0));
    Time = ones(1,2)*100;
    PosL = [0 255];
    SendArm(SD, ARB_LOAD_SEQ, CastTime(Time, PosL));
    SendArm(SD, ARB_PLAY_SEQ, []);
    pause(0.2);
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

%}

