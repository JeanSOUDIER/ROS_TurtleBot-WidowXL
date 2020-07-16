%Fonction pour d�marrer le robot
% tbot (objet Turtlebot)
% SD (objet de l'USB, fichier de description)
% mypi (objet raspberry pi)

function [tbot, SD, mypi, NbPlot] = Start()
    fprintf('D�marrage !!!!\n');
    NbPlot = 1;
    %D�claration de l'adresse IP
    ipTurtlebot = '192.168.1.33';

    %Initialisation de l'objet Raspberry pi (Raspberry pi toolbox) et de
    %l'USB, fichier de description
    mypi = raspi(ipTurtlebot,'pi','turtlebot');
    SD = serialdev(mypi,'/dev/ttyUSB_ARBO',115200);
    pause(10); %Attente de la connexion USB

    %Initialisation du turtlebot (ROS)
    tbot = turtlebot(ipTurtlebot);
    %Mode de d�placement en vitesse
    tbot.Velocity.TopicName = '/cmd_vel';

    %D�claration du nombre de moteurs sur le bras
    SetNbMot(SD);
end
