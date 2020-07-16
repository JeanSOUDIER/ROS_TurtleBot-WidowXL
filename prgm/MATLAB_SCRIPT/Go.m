%Fonction de déplacement du robot à une position relative
% Pos [X Y Theta] (position où l'on veut aller)
% tbot (objet Turtlebot)

function Theta = Go(Pos, tbot)
    %Conversion en coordonnées polaires
    [theta rho] = cart2pol(Pos(1), Pos(2));
    Theta = theta-Pos(3); %Ajout de l'angle en plus
    
    %Normalisation entre -pi et pi
    Theta = Theta+pi;
    Theta = mod(Theta,2*pi);
    Theta = Theta-pi;
    
    %Déplacement angulaire
    if(abs(Theta) > 0)
        setVelocity(tbot,0,1*sign(Theta),'Time',abs(Theta));
    end
    %Déplacement en norme
    if(abs(rho) > 0)
        setVelocity(tbot,-0.1*sign(rho),0,'Time',abs(rho/100));
    end
end
