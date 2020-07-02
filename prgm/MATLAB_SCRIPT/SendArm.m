%Function to send data to the arm
% myserialdevice (object USB file descriptor)

function SendArm(myserialdevice, Ins, Data)
    Send = [Ins Data];
    Send = [255 253 length(Send)+1 Send];
    Checksum = 255-(mod(sum(Send),256)+1);
    Send = [Send Checksum];
    write(myserialdevice,Send,'uint8');
end