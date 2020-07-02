%Function to move the robot to a presice position
% Pos [X Y Theta]
% tbot (object Turtlebot)

function Theta = Go(Pos, tbot)
    [theta rho] = cart2pol(Pos(1), Pos(2));
    Theta = theta-Pos(3);
    
    %Normalise
    Theta = Theta+pi;
    Theta = mod(Theta,2*pi);
    Theta = Theta-pi;
    
    %Go to angle
    if(abs(Theta) > 0)
        setVelocity(tbot,0,1*sign(Theta),'Time',abs(Theta));
    end
    %Go to norm
    if(abs(rho) > 0)
        setVelocity(tbot,-0.1*sign(rho),0,'Time',abs(rho/100));
    end
end
