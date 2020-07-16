if exist('NbPlot','var')
    NbPlot = 1;
else
    %Connection à ROS si on ne l'avait pas déjà fait
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end

%Définition des constantes
a = TakeOdom(tbot);
TAPIS_X = 1500;
TAPIS_Y = 2200;
TAPIS_X0 = TAPIS_X/2;
TAPIS_Y0 = 450;
Map = zeros(TAPIS_X,TAPIS_Y);
P = [TAPIS_X0 TAPIS_Y0 a(3)];

%Remplissage du terrain pour la première fois
[Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);

[P Map NbPlot] = PathFinding([TAPIS_X0-600 1300+TAPIS_Y0], Map, tbot, -1, TAPIS_X, TAPIS_Y, P);
