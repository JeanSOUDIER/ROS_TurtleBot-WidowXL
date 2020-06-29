function O = ComputeDistCamArm(Pos, L, H, Angle)
    Px = Pos(1);
    Py = Pos(2);
    
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
    
    %{
    [Gamma R] = cart2pol(X,Y)
    Gamma = pi/2-Gamma
    
    Delta = (-2*R*cos(Gamma))^2-4*(R^2-(L/2)^2)
    Sol = [(2*R*cos(Gamma)+sqrt(Delta))/2 (2*R*cos(Gamma)-sqrt(Delta))/2]
    c = max(Sol)
    
    Thet = acos((c^2+(L/2)^2-R^2)/(L*c))
    Angle = Angle+Thet
    
    O = [c*cos(Angle) c*sin(Angle)]
    %}
    
    [Gamma R] = cart2pol(Y,X);
    Gamma = Angle+Gamma;
    [Xa Ya] = pol2cart(Gamma,R);
    
    [X0 Y0] = pol2cart(Angle,H);
    Xf = X0+Xa;
    Yf = Y0+Ya;
    
    O = [Xf Yf];
    
end
    