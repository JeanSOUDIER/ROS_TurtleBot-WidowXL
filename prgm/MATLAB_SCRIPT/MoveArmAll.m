%Fonction pour déplacer le bras proprement
% SD (objet de l'USB, fichier de description)
% Grip = 0(attraper), 1(fermer), 2(lâcher) ou (ouvert)

function [succes NbPlot] = MoveArmAll(SD,X,Y,Z,Theta,Grip,NbPlot)
    %Définition des constantes en [mm]
    a1 = 155;
    a2 = 150;
    a3 = 165;

    Lr = 179;
    Lz = -236;
    Lim = 280;

    Tau = acos(145/a1);
    Z = Z+Lz+1;

    %Tests de protection du robot
    if(X > -1) %Si c'est devant le robot
        [Gamma R] = cart2pol(X,Y);
        if(R > Lr) %Si ce n'est pas dans le robot
            if(Z > Lz) %Si ce n'est pas dans le sol
                if(norm(R,Z) < Lim+a3) %Si le bras n'est pas trop court
                    %Calcul des intersections des cercles de rayon Lim (longueur max des 2 premiers segments) et a3
                    [xout,yout] = circcirc(0,0,Lim,R,Z,a3);
                    [P3y id] = max(yout); %On cherche le plus grand pour prendre l'objet par le dessus
                    P3x = xout(id);
                    if(P3x > R) %Saturation pour que le bras ne revienne pas en arrière
                        P3x = R;
                        P3y = Z+a3;
                    end
                    %Calcul des intersections des cercles de rayon a1 et a2
                    [xout,yout] = circcirc(0,0,a1,P3x,P3y,a2);
                    [P2y id] = max(yout);
                    P2x = xout(id);
                
                    %calcul des angles en fonction des points trouvés
                    Theta1 = pi/2-acos(P2y/a1);
                    Theta2 = pi/2-acos((P3y-P2y)/a2);
                    Theta3 = pi/2-acos((Z-P3y)/a3);
                    Theta4 = Theta;
                    
                    if(Grip == 0)
                        %Le bras se place sur le bon angle X,Y
                        Pos = [Gamma pi/4 -pi/4 -pi/4-pi/16 Theta4 pi/2];
                        MoveAllMot(SD, Pos, true);
                        %Le bras descend
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 pi/2];
                        MoveAllMot(SD, Pos, true);
                        Pos(6) = -pi/2;
                        %Le bras se ferme
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip attrape \n');
                    elseif(Grip == 1)
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 -pi/2];
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip fermé \n');
                    elseif(Grip == 2)
                        %Le bras va à la position
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 -pi/2];
                        MoveAllMot(SD, Pos, true);
                        Pos(6) = pi/2;
                        %Le bras s'ouvre
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip Lâche \n');
                    else
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 pi/2];
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip ouvert \n');
                    end
                    %Affichage
                    if(NbPlot > 0)
                        figure(NbPlot);
                        NbPlot = NbPlot+1;
                        circle(0,0,Lim,'r');
                        hold on;
                        xlim([-281 471]);
                        ylim([-281 471]);
                        circle(0,0,Lim+a3,'b');
                        rectangle('Position',[0 -280 200 750]);
                        point(R,Z,'r+');
                        circle(R,Z,a3,'m');
                        circle(P3x,P3y,a2,'g');
                        circle(0,0,a1,'b');
                        point(P3x,P3y,'g+');
                        point(P2x,P2y,'m+');
                        [P2xb P2yb] = linePol(0,0,a1,Theta1,'r');
                        [P3xb P3yb] = linePol(P2xb,P2yb,a2,Theta2,'r');
                        linePol(P3xb,P3yb,a3,Theta3,'r');
                        hold off;
                    end
                    succes = true;
                else
                    fprintf('bras trop court\n');
                    succes = false;
                end
            else
                fprintf('bras dans le sol\n');
                succes = false;
            end
        else
            fprintf('bras dans le robot\n');
            succes = false;
        end
    else
        fprintf('bras derrière le robot\n');
        succes = false;
    end
end
