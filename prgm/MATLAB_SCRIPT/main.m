%D�marrage
if exist('NbPlot','var')
    NbPlot = 1;
else
    %Connection � ROS si on ne l'avait pas d�j� fait
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end

%D�finition des constantes
a = TakeOdom(tbot);
TAPIS_X = 1500;
TAPIS_Y = 2200;
TAPIS_X0 = TAPIS_X/2;
TAPIS_Y0 = 450;
Map = zeros(TAPIS_X,TAPIS_Y);
P = [TAPIS_X0 TAPIS_Y0 a(3)];

%Position de repos
Homing(SD);
%Remplissage du terrain pour la premi�re fois
[Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);

%Programme principal
fprintf('Programme !!!\n');
%Recherche de l'objet
[PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot); %Recherche de l'objet par rapport � toutes les images de la forme "Pile[NUM].jpg"
if(norm(PosO) == 0) %Si la recherche ne donne pas de r�sultats
    pause(1);
    [PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot); %On r�essaye avec une nouvelle photo
    if(norm(PosO) == 0) %Si toujours pas de r�sultat
        setVelocity(tbot,-0.1); %On avance un peu le robot et on refait 2 tests
        pause(1);
        setVelocity(tbot,0);
        pause(2);
        [PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot);
        if(norm(PosO) == 0)
            pause(1);
            [PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot);
        end
    end
end
if(norm(PosO) ~= 0) %Si on a trouv� une image
    PosArmToMove(SD, false, false); %Bras en position de d�placement
    PosO = ComputeDistCam(626, 53, PosO); %On convertie la position en pixel en position o� le robot doit aller
    %On lance le programme de d�placement et d�vitement
    [P Map NbPlot] = PathFinding([PosO(2)+TAPIS_X0 PosO(1)-50+TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
    test_suc = false;
    %On cherche l'objet autour du robot en d�placant le bras
    for i = -pi/4-pi/8:pi/8:pi/4+pi/8
        PosArmToSeeObj(i, SD); %Position de prise de photo du bras
        pause(1);
        [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot); %D�tection de l'objet forme "PileD[NUM].jpg"
        if(norm(PosD) == 0) %Si on ne trouve pas l'objet on r�alise une deuxi�me photo et on la teste
            pause(0.5);
            [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot);
        end
        if(norm(PosD) ~= 0) %Si on a un r�sultat
            PosD = ComputeDistCamArm(PosD, 390, 95, i); %On calcule la position ou le bras doit aller
            %On d�place le bras
            [succes NbPlot] = MoveArmAll(SD, PosD(1), PosD(2), 0, PosD(2)*pi/1280, 0,NbPlot);
            if(succes == true) %Si la position est dans la plage autoris�e du bras
                test_suc = true;
                break; %On arr�te de chercher l'objet
            end
        end
    end
    PosArmToMove(SD, true, false); %On remet le bras en position de d�placement avec la pince ferm�e
    pause(0.5);
    %On retourne au point de d�part avec le programme d'�vitement
    [P Map NbPlot] = PathFinding([TAPIS_X0 TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
    pause(0.5);
    [PosE NbPlot] = TryGetObject(mypi, "PileE", NbPlot); %D�tection de l'objet forme "PileE[NUM].jpg"
    if(norm(PosE) == 0)
        pause(0.5);
        [PosE NbPlot] = TryGetObject(mypi, "PileE", NbPlot); %D�tection de l'objet forme "PileE[NUM].jpg"
    end
    PosE
    if(test_suc == true) && (norm(PosE) ~= 0) %Si on a pris un objet
        [succes NbPlot] = MoveArmAll(SD, 200, 0, 0, 0, 2,NbPlot); %On le pose devant le robot
    end
    close all;
    PosArmToMove(SD, false, false); %On ouvre la pince
    clc;
else
    %On n'a pas trouv� d'objet
    setVelocity(tbot,0.1); %On recule � nouveau
    pause(1);
    setVelocity(tbot,0);
    clc;
    fprintf('Abandon...\n');
    close all;
    pause(1);
    [a NbPlot] = TakePhoto(mypi, NbPlot); %On prend une photo
    PosArmToMove(SD, false, false); %On remet le bras en position de d�placement
end
