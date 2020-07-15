%Function to start the robot
% tbot (object Turtlebot)
% SD (object USB file descriptor)
% mypi (object raspberry pi)

function [tbot, SD, mypi, NbPlot] = Start()
    fprintf('Start !!!!\n');
    NbPlot = 1;
    %IPs declarations
    ipTurtlebot = '192.168.1.33';

    %Init camera & arm
    mypi = raspi(ipTurtlebot,'pi','turtlebot');
    SD = serialdev(mypi,'/dev/ttyUSB_ARBO',115200);
    pause(10);

    %Init Tbot3
    tbot = turtlebot(ipTurtlebot);
    %Cmd in velocity
    tbot.Velocity.TopicName = '/cmd_vel';

    %Declare nb mot on arm
    SetNbMot(SD);
end
