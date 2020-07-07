clear
ipTurtlebot = '192.168.1.33';
mypi = raspi(ipTurtlebot,'pi','turtlebot');
openShell(mypi)

pause(10);

SD = serialdev(mypi,'/dev/pts/0');
C = ['ls -a' char(4)];
write(SD,double(C),'uint8')

%read(SD,1)
%[status,cmdout] = system(mypi,['export PATH=' myPath ' ; ' command])
