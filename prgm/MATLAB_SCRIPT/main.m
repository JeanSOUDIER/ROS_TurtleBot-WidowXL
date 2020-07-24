%Démarrage
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

%Position de repos
Homing(SD);
%Remplissage du terrain pour la première fois
[Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);

%Programme principal
fprintf('Programme !!!\n');
%Recherche de l'objet
[PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot); %Recherche de l'objet par rapport à toutes les images de la forme "Pile[NUM].jpg"
if(norm(PosO) == 0) %Si la recherche ne donne pas de résultats
    pause(1);
    [PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot); %On réessaye avec une nouvelle photo
    if(norm(PosO) == 0) %Si toujours pas de résultat
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
if(norm(PosO) ~= 0) %Si on a trouvé une image
    PosArmToMove(SD, false, false); %Bras en position de déplacement
    PosO = ComputeDistCam(626, 53, PosO); %On convertie la position en pixel en position où le robot doit aller
    %On lance le programme de déplacement et dévitement
    [P Map NbPlot] = PathFinding([PosO(2)+TAPIS_X0 PosO(1)-50+TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
    test_suc = false;
    %On cherche l'objet autour du robot en déplacant le bras
    for i = -pi/4-pi/8:pi/8:pi/4+pi/8
        PosArmToSeeObj(i, SD); %Position de prise de photo du bras
        pause(1);
        [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot); %Détection de l'objet forme "PileD[NUM].jpg"
        if(norm(PosD) == 0) %Si on ne trouve pas l'objet on réalise une deuxième photo et on la teste
            pause(0.5);
            [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot);
        end
        if(norm(PosD) ~= 0) %Si on a un résultat
            PosD = ComputeDistCamArm(PosD, 390, 95, i); %On calcule la position ou le bras doit aller
            %On déplace le bras
            [succes NbPlot] = MoveArmAll(SD, PosD(1), PosD(2), 0, PosD(2)*pi/1280, 0,NbPlot);
            if(succes == true) %Si la position est dans la plage autorisée du bras
                test_suc = true;
                break; %On arrête de chercher l'objet
            end
        end
    end
    PosArmToMove(SD, true, false); %On remet le bras en position de déplacement avec la pince fermée
    pause(0.5);
    %On retourne au point de départ avec le programme d'évitement
    [P Map NbPlot] = PathFinding([TAPIS_X0 TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
    pause(0.5);
    [PosE NbPlot] = TryGetObject(mypi, "PileE", NbPlot); %Détection de l'objet forme "PileE[NUM].jpg"
    if(norm(PosE) == 0)
        pause(0.5);
        [PosE NbPlot] = TryGetObject(mypi, "PileE", NbPlot); %Détection de l'objet forme "PileE[NUM].jpg"
    end
    PosE
    if(test_suc == true) && (norm(PosE) ~= 0) %Si on a pris un objet
        [succes NbPlot] = MoveArmAll(SD, 200, 0, 0, 0, 2,NbPlot); %On le pose devant le robot
    end
    close all;
    PosArmToMove(SD, false, false); %On ouvre la pince
    clc;
else
    %On n'a pas trouvé d'objet
    setVelocity(tbot,0.1); %On recule à nouveau
    pause(1);
    setVelocity(tbot,0);
    clc;
    fprintf('Abandon...\n');
    close all;
    pause(1);
    [a NbPlot] = TakePhoto(mypi, NbPlot); %On prend une photo
    PosArmToMove(SD, false, false); %On remet le bras en position de déplacement
end
