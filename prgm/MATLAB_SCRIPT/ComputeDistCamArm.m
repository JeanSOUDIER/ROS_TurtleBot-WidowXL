function O = ComputeDistCamArm(Pos, L, Angle)
    Px = Pos(2);
    Py = Pos(1);
    
    ANGLE_CAM = 48.8;
    ANGLE_CAM = ANGLE_CAM/2*pi/180;
    ANGLE_CAM_H = 62.2;
    ANGLE_CAM_H = ANGLE_CAM_H/2*pi/180;
    RESOL_X_MOY = 360;
    RESOL_X_MAX = 720;
    RESOL_Y_MAX = 640;

    %Px
    a = L*tan(ANGLE_CAM);
    X = a*Px/RESOL_X_MAX

    %Py
    b = L*tan(ANGLE_CAM_H);
    Y = b*Py/RESOL_Y_MAX
    
    [Gamma R] = cart2pol(X,Y)
    Gamma = pi-Gamma
    
    c = sqrt((L/2)^2+R^2-L*R*cos(Gamma))
    Thet = acos((c^2+(L/2)^2-R^2)/(L*c))
    Angle = Angle-Thet
    
    O = [c*cos(Angle) c*sin(Angle)]
end
    