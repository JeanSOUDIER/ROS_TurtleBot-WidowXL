function O = ComputeDistCam(L, theta, Po2)
    Px = Po2(2)
    Py = Po2(1)
    Theta = theta;

    ANGLE_CAM = 48.8;
    ANGLE_CAM = ANGLE_CAM/2*pi/180;
    ANGLE_CAM_H = 62.2;
    ANGLE_CAM_H = ANGLE_CAM_H/2*pi/180;
    RESOL_X_MOY = 360;
    RESOL_X_MAX = 720;
    RESOL_Y_MAX = 640;

    Theta = Theta*pi/180;

    a = sin(Theta)*L;
    Alpha = pi/2-Theta;
    Beta = pi/2-Alpha-ANGLE_CAM;
    d = a/cos(Beta);
    Xmin = sqrt(d^2+L^2-2*d*L*cos(pi/2-ANGLE_CAM));

    Xmoy = L/cos(Theta);

    e = a/cos(Beta+2*ANGLE_CAM);
    Xmax = sqrt(e^2+L^2-2*e*L*cos(pi/2+ANGLE_CAM));

    A = (Xmax-RESOL_X_MAX*((Xmoy-Xmin)/RESOL_X_MOY)) / (RESOL_X_MAX^2-RESOL_X_MAX*RESOL_X_MOY);
    B = (Xmoy-Xmin-RESOL_X_MOY^2*A)/RESOL_X_MOY;
    C = Xmin;
    X = A*Px^2+B*Px+C;
    
    %X = Px*(Xmax-Xmin)/RESOL_X_MAX;
    
    %Py
    f = sqrt(X^2+L^2-2*L*X*cos(ANGLE_CAM_H));
    g = f*tan(ANGLE_CAM_H);
    Y = g*Py/RESOL_Y_MAX;
    
    
    O = [X Y]

    %{
    Ph = 720;
    Pl = 1280;
    theta = theta*pi/180;
    
    B = abs(L/tan(120*pi/180-theta));
    H = abs(L/tan(pi/2+theta));
    
    Po = cos(theta)*(Po2(1)-Ph/2);
    OB = (H-B)*(Po+Ph/2)/Ph;
    
    O = [OB+B 0];
    
    O(2) = (H-B)*(Po2(2)-Pl/2)/Pl;
    %}
end