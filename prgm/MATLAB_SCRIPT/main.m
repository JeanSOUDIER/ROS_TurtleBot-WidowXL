%start
if exist('NbPlot','var')
    NbPlot = 1;
else
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end
%Define constantes
TAPIS_X = 1500;
TAPIS_Y = 2200;
TAPIS_X0 = TAPIS_X/2;
TAPIS_Y0 = 450;
Map = zeros(TAPIS_X,TAPIS_Y);
P = [TAPIS_X0 TAPIS_Y0 0];

%home
Homing(SD);
%View Map
[Map NbPlot] = DiscoverMap(Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);

%program
fprintf('PRGM !!!\n');
%Search obj
[PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot);
if(norm(PosO) == 0)
    pause(1);
    [PosO NbPlot] = TryGetObject(mypi, "Pile", NbPlot);
    if(norm(PosO) == 0)
        setVelocity(tbot,-0.1);
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
%Go to object
if(norm(PosO) ~= 0)
    PosArmToMove(SD, false, false);
    PosO = ComputeDistCam(626, 53, PosO);
    [PosO(2)+TAPIS_X0 PosO(1)-50+TAPIS_Y0]
    [P NbPlot] = PathFinding([PosO(2)+TAPIS_X0 PosO(1)-50+TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
    for i = -pi/4-pi/8:pi/8:pi/4+pi/8
        PosArmToSeeObj(i, SD);
        pause(1);
        [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot);
        %if(norm(PosD) == 0)
        %    pause(0.5);
        %    [PosD NbPlot] = TryGetObject(mypi, "PileD", NbPlot);
        %end
        PosD
        if(norm(PosD) ~= 0)
            %Catch object
            PosD = ComputeDistCamArm(PosD, 390, 95, i);
            [succes NbPlot] = MoveArmAll(SD, PosD(1), PosD(2), 0, PosD(2)*pi/1280, 0,NbPlot);
            if(succes == true)
                break;
            end
        end
    end
    PosArmToMove(SD, true, false);
    pause(0.5);
    %ERROR
    %Return to base
    [P NbPlot] = PathFinding([TAPIS_X0 TAPIS_Y0], Map, tbot, NbPlot, TAPIS_X, TAPIS_Y, P);
else
    %No object found
    setVelocity(tbot,0.1);
    pause(1);
    setVelocity(tbot,0);
    fprintf('Abandon...\n');
end
%IDLE position
close all;
pause(1);
TakePhoto(mypi, NbPlot);
PosArmToMove(SD, false, false);
