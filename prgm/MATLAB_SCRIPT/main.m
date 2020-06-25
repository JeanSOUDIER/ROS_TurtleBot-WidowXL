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
Img = TakePhoto(mypi,-1);
[PosO NbPlot] = GetObject(Img, 'Pile', NbPlot);
if(norm(PosO) == 0)
    pause(1);
    Img = TakePhoto(mypi,-1);
    [PosO NbPlot] = GetObject(Img, 'Pile', NbPlot);
    if(norm(PosO) == 0)
        setVelocity(tbot,-1);
        pause(0.2);
        setVelocity(tbot,0);
        pause(2);
        Img = TakePhoto(mypi,-1);
        [PosO NbPlot] = GetObject(Img, 'Pile', NbPlot);
        if(norm(PosO) == 0)
            pause(1);
            Img = TakePhoto(mypi,-1);
            [PosO NbPlot] = GetObject(Img, 'Pile', NbPlot);
        end
    end
end
if(norm(PosO) ~= 0)
    PosArmToMove(SD, false);
    PosO = ComputeDistCam(626, 53, PosO);
    %NbPlot = PathFinding(PosO(1), PosO(2), tbot, NbPlot);
    Go([PosO(1) PosO(2) 0], tbot);
    pause(1);
    PosArmToSeeObj(SD);
    pause(1);
    %{
    Img = TakePhoto(mypi,-1);
    [PosD NbPlot] = GetObject(Img, 'PileD', NbPlot);
    if(norm(PosD) == 0)
        pause(1);
        Img = TakePhoto(mypi,-1);
        [PosD NbPlot] = GetObject(Img, 'PileD', NbPlot);
    end
    PosD
    %}
    %NbPlot = MoveArmAll(SD, 225, 0, 0, 0, 0, NbPlot);
    
    %{
    pause(0.5);
    PosArmToMove(SD, true);
    pause(0.5);
    Go([PosO(2) PosO(1) -pi/2], tbot);
    Go([0 0 pi], tbot);
    pause(1);
    %}
    PosArmToMove(SD, false);
else
    setVelocity(tbot,1);
    pause(0.2);
    setVelocity(tbot,0);
    fprintf('Abandon...\n');
end

pause(2);

TakePhoto(mypi, NbPlot);
