function Theta = Go(Pos, tbot)
    [theta rho] = cart2pol(Pos(1), Pos(2));
    Theta = theta-Pos(3);
    
    Theta = Theta+pi;
    Theta = mod(Theta,2*pi);
    Theta = Theta-pi;
    
    if(abs(Theta) > 0)
        setVelocity(tbot,0,1*sign(Theta),'Time',abs(Theta));
    end
    if(abs(rho) > 0)
        setVelocity(tbot,-0.1*sign(rho),0,'Time',abs(rho/100));
    end
end
