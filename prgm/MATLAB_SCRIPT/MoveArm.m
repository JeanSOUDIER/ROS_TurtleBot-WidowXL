function MoveArm(X, Y, Z, Theta, Grip)
    %Angle
    R = sqrt(X^2+Y^2);
    Gamma = 2*atan(Y/(X+R));
    MoveMot(1,Gamma/pi);
    fprintf('R = %d \n',R);
    fprintf('1 => %d \n',Gamma/pi);
    
    %Kinematic inv
    L1 = 150; %[mm]
    L2 = 150;
    L3 = 170;
    
    E = [R, Z];
    E2 = [R-L1, Z];
    
    if ((R > 0) && (Z > 100) && (norm(E) < L1+L2+L3)) || ((Z > -295) && (Z <101) && (R > 160) && (norm(E2) < L2+L3))
        x0 = [90, 90, 90];
        x = fsolve(@(x) equation3R(x, L1, L2,L3, E(1), E(2)), x0) %compute for 3 axes
        
        if(x(1) < 0)
            clear x;
            x = fsolve(@(x) equation2R(x,L2,L3, E2(1), E2(2)), x0); %compute for 2 axis
            x = [0 x];
        end
        MoveMot(2, (x(1)-90)/180);
        fprintf('2 => %d \n',(x(1)-90)/180);
        MoveMot(3, (x(2)-90)/180);
        fprintf('3 => %d \n',(x(2)-90)/180);
        MoveMot(4, (x(3)-90)/180);
        fprintf('4 => %d \n',(x(3)-90)/180);
    else
       fprintf('error position \n'); 
    end
    if(Theta > 90)
        Theta = 90;
        fprintf('Theta > 90 \n');
    end
    if(Theta < -90)
        Theta = -90;
        fprintf('Theta < 90 \n');
    end
    
    %End arm
    MoveMot(5, (Theta+90)/90);
    fprintf('5 => %d \n',(Theta+90)/90);
    if(Grip == true)
        %MoveMot(6, -0.8);
        fprintf('6 => Grip ON \n');
    else
        MoveMot(6, 1);
        fprintf('6 => Grip OFF \n');
    end
end