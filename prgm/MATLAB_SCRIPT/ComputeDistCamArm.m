%Function to compute the distance between the camera and the object for the
% arm
%                 |\ Camera
%                 | \
%                 |  \
%                 |   \
%                 |    \
%              H  |     \  L
%                 |      \
%                 |       \
%                 |___X____\
%                     Object Pos [X Y] (in pixels)
%
% Angle of the arm from the base

function O = ComputeDistCamArm(Pos, L, H, Angle)
    Px = Pos(1);
    Py = Pos(2);
    
    %Define constantes
    ANGLE_CAM = 48.8;
    ANGLE_CAM = ANGLE_CAM/2*pi/180;
    ANGLE_CAM_H = 62.2;
    ANGLE_CAM_H = ANGLE_CAM_H/2*pi/180;
    RESOL_X_MAX = 720;
    RESOL_Y_MAX = 640;

    %Px
    a = L*tan(ANGLE_CAM);
    X = a*Px/RESOL_X_MAX;

    %Py
    b = L*tan(ANGLE_CAM_H);
    Y = b*Py/RESOL_Y_MAX;
    
    %Add the angle of the arm
    [Gamma R] = cart2pol(Y,X);
    Gamma = Angle+Gamma;
    [Xa Ya] = pol2cart(Gamma,R);
    
    [X0 Y0] = pol2cart(Angle,H);
    Xf = X0+Xa;
    Yf = Y0+Ya;
    
    O = [Xf Yf];
    
end
    