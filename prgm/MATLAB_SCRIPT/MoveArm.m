function MoveArm(SD, X, Y, Z, Theta, Grip)
    Pos = [];
    %Angle
    [Gamma R] = cart2pol(X,Y);
    %R = sqrt(X^2+Y^2);
    %Gamma = 2*atan(Y/(X+R));
    %GammaNorm = Gamma/pi*3.2+0.9;
    if(X > -1)
        fprintf('R = %d \n',R);
        fprintf('1 => %d \n',Gamma);
        Pos = [Gamma];
    else
        fprintf('X negative !!');
        Pos = [0];
    end
    
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
        x(1) = (x(1)-pi)*pi;
        fprintf('2 => %d \n',x(1));
        Pos = [Pos x(1)];
        x(2) = (x(2)-pi)*pi;
        fprintf('3 => %d \n',x(2));
        Pos = [Pos x(2)];
        x(3) = (x(3)-pi)*pi;
        fprintf('4 => %d \n',x(3));
        Pos = [Pos x(3)];
    else
       fprintf('error position \n'); 
       Pos = [Pos 0 0 0];
    end
    if(Theta > 90)
        Theta = 90;
        fprintf('Theta > 90 \n');
    end
    if(Theta < -90)
        Theta = -90;
        fprintf('Theta < 90 \n');
    end
    Theta = Theta*pi/90;
    
    %End arm
    fprintf('5 => %d \n',Theta);
    Pos = [Pos Theta];
    if(Grip == true)
        Pos = [Pos -0.6];
        fprintf('6 => Grip ON \n');
    else
        Pos = [Pos pi];
        fprintf('6 => Grip OFF \n');
    end
    MoveAllMot(SD,Pos);
end