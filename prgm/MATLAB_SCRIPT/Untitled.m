Go([0 0 pi/2], tbot);
MoveMot(1, 2.4);
pause(4);
ImgL = TakePhoto(mypi,-1);
Go([100 0 0], tbot);
pause(4);
ImgR = TakePhoto(mypi,-1);


load('handshakeStereoParams.mat');

% Visualize camera extrinsics.
showExtrinsics(stereoParams);

player = vision.VideoPlayer('Position', [0,0,100,0]);
[frameLeftRect, frameRightRect] = rectifyStereoImages(ImgL, ImgR, stereoParams);

figure;
imshow(stereoAnaglyph(frameLeftRect, frameRightRect));
title('Rectified Video Frames');

frameLeftGray  = rgb2gray(ImgL);
frameRightGray = rgb2gray(ImgR);
    
disparityMap = disparity(frameLeftGray, frameRightGray);
figure;
imshow(disparityMap, [0, 64]);
title('Disparity Map');
colormap jet
colorbar

PosO = GetObject(ImgR, mypi);
if(norm(PosO) == 0)
    PosO = GetObject(ImgL, mypi);
end

if(norm(PosO) ~= 0) && (abs(PosO(1)) ~= Inf) && (abs(PosO(2)) ~= Inf)
    Dist = disparityMap(floor(PosO(1)), floor(PosO(2)));

    Dist = Dist*1.6/64*1000-320;
    Dist = floor(Dist)

    Go([-100 0 0], tbot);
    Go([0 0 pi/2], tbot);

    PathFinding(Dist, 0, tbot);
end
