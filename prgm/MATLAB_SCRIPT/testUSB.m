clear
mypi = raspi;
myserialdevice = serialdev(mypi,'/dev/ttyUSB0',115200);
pause(10);
Send = [255 253 3 7 1]; %255,253,3,7,10,238
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(myserialdevice,Send,'uint8');
%pause(2);
Send = [255 253 4 8 10 13];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(myserialdevice,Send,'uint8');
%pause(2);
Send = [255 253 5 9 100 0 0];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(myserialdevice,Send,'uint8');
%pause(2);
Send = [255 253 2 11];
Checksum = 255-(mod(sum(Send),256)+1);
Send = [Send Checksum];
write(myserialdevice,Send,'uint8');
