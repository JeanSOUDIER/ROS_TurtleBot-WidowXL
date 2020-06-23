if exist('NbPlot','var')
    NbPlot = 1;
else
    clear
    [tbot, SD, mypi, NbPlot] = Start();
end

%home
Homing(SD);


pause(1);
[a NbPlot] = TakeLidarScan(tbot,NbPlot);

pause(1);
TakePhoto(mypi, NbPlot);

%PRGM
%{
fprintf('PRGM !!!\n');
Img = TakePhoto(mypi,-1);
[PosO NbPlot] = GetObject(Img, NbPlot);
if(norm(PosO) == 0)
    pause(1);
    Img = TakePhoto(mypi,-1);
    [PosO NbPlot] = GetObject(Img, NbPlot);
    if(norm(PosO) == 0)
        setVelocity(tbot,1);
        pause(0.2);
        setVelocity(tbot,0);
        pause(2);
        Img = TakePhoto(mypi,-1);
        [PosO NbPlot] = GetObject(Img, NbPlot);
        if(norm(PosO) == 0)
            pause(1);
            Img = TakePhoto(mypi,-1);
            [PosO NbPlot] = GetObject(Img, NbPlot);
        end
    end
end
if(norm(PosO) ~= 0)
    PosO = ComputeDistCam(600, 60, PosO);
    NbPlot = PathFinding(PosO(1), PosO(2), tbot, NbPlot);
    pause(1);
    NbPlot = MoveArmAll(SD, 300, 0, -200, 0, true, NbPlot);
end

TakePhoto(mypi, NbPlot);
%}
