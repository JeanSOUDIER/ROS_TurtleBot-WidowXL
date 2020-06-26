%start
if exist('NbPlot','var')
    NbPlot = 1;
else
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end

%home
Homing(SD);

%program
fprintf('PRGM !!!\n');
[PosO NbPlot] = TryGetObject(mypi, ["Pile"], NbPlot);
if(norm(PosO) == 0)
    pause(1);
    [PosO NbPlot] = TryGetObject(mypi, ["Pile"], NbPlot);
    if(norm(PosO) == 0)
        setVelocity(tbot,-0.1);
        pause(1);
        setVelocity(tbot,0);
        pause(2);
        [PosO NbPlot] = TryGetObject(mypi, ["Pile"], NbPlot);
        if(norm(PosO) == 0)
            pause(1);
            [PosO NbPlot] = TryGetObject(mypi, ["Pile"], NbPlot);
        end
    end
end
if(norm(PosO) ~= 0)
    PosArmToMove(SD, false);
    PosO = ComputeDistCam(626, 53, PosO);
    NbPlot = PathFinding(PosO(1)-150, PosO(2), tbot, NbPlot);
    %Go([PosO(1)-100 PosO(2) 0], tbot);
    pause(1);
    for i = -pi/4-pi/8:pi/8:pi/4+pi/8
        PosArmToSeeObj(i, SD);
        pause(1);
        ImgNames = ["PileD","PileD1","PileD2","PileD3"];
        [PosD NbPlot] = TryGetObject(mypi, ImgNames, NbPlot);
        if(norm(PosD) == 0)
            pause(1);
            [PosD NbPlot] = TryGetObject(mypi, ImgNames, NbPlot);
        end
        PosD
        if(norm(PosD) ~= 0)
            PosD = ComputeDistCamArm(PosD, 350, i);
            NbPlot = MoveArmAll(SD, PosD(1), PosD(2), 0, -PosD(2)*pi/1280, 0,NbPlot);
            break;
        end
    end
    PosArmToMove(SD, true);
    pause(0.5);
    %Go([PosO(2) PosO(1) -pi/2], tbot);
    %Go([0 0 pi], tbot);
    NbPlot = PathFinding(-PosO(1)+150, -PosO(2), tbot, NbPlot);
    pause(1);
    PosArmToMove(SD, false);
else
    setVelocity(tbot,0.1);
    pause(1);
    setVelocity(tbot,0);
    fprintf('Abandon...\n');
end

pause(2);

TakePhoto(mypi, NbPlot);
