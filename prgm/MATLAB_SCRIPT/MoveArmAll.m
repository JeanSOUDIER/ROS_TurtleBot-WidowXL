%Function to move the arm properly
% SD (object USB file descriptor
% Grip = 0(catch), 1(on), 2(let) or (off)

function [succes NbPlot] = MoveArmAll(SD,X,Y,Z,Theta,Grip,NbPlot)
    %Define constantes in mm
    a1 = 155;
    a2 = 150;
    a3 = 165;

    Lr = 179;
    Lz = -236;
    Lim = 280;

    Tau = acos(145/a1);
    Z = Z+Lz+1;

    %Tests to protect the robot
    if(X > -1) %in front of the robot
        [Gamma R] = cart2pol(X,Y);
        if(R > Lr) %in the robot
            if(Z > Lz) %in the bottom
                if(norm(R,Z) < Lim+a3) %arm too short
                    [xout,yout] = circcirc(0,0,Lim,R,Z,a3);
                    [P3y id] = max(yout);
                    P3x = xout(id);
                    if(P3x > R) %Saturation
                        P3x = R;
                        P3y = Z+a3;
                    end
                    [xout,yout] = circcirc(0,0,a1,P3x,P3y,a2);
                    [P2y id] = max(yout);
                    P2x = xout(id);
                
                    Theta1 = pi/2-acos(P2y/a1);
                    Theta2 = pi/2-acos((P3y-P2y)/a2);
                    Theta3 = pi/2-acos((Z-P3y)/a3);
                    Theta4 = Theta;
                
                    if(Theta > 90)
                        Theta = 90;
                        fprintf('Theta > 90 \n');
                    end
                    if(Theta < -90)
                        Theta = -90;
                        fprintf('Theta < 90 \n');
                    end
                    Theta = Theta*pi/90;
                    if(Grip == 0)
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 pi/2];
                        MoveAllMot(SD, Pos, true);
                        Pos(6) = -pi/2;
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip CATCH \n');
                    elseif(Grip == 1)
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 -pi/2];
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip ON \n');
                    elseif(Grip == 2)
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 -pi/2];
                        MoveAllMot(SD, Pos, true);
                        Pos(6) = pi/2;
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip LET \n');
                    else
                        Pos = [Gamma (Theta1+Tau)-pi/2 pi/2+(Theta2-(Theta1+Tau)) Theta3-Theta2 Theta4 pi/2];
                        MoveAllMot(SD, Pos, true);
                        fprintf('6 => Grip OFF \n');
                    end
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
