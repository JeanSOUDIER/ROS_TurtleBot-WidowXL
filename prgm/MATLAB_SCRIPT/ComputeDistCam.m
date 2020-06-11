function O = ComputeDistCam(L, theta, Po2)
    Ph = 720;
    Pl = 1280;
    theta = theta*pi/180;
    
    B = abs(L/tan(120*pi/180-theta));
    H = abs(L/tan(pi/2+theta));
    
    Po = cos(theta)*(Po2(1)-Ph/2);
    OB = (H-B)*(Po+Ph/2)/Ph;
    
    O = [OB+B 0];
    
    O(2) = (H-B)*(Po2(2)-Pl/2)/Pl;
end