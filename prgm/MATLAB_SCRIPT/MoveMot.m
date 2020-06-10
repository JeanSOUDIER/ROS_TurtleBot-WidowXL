function MoveMot(nb, pos)
    if(nb > -1)
        if(nb < 6) %moteur du bras
            table = [6 4 0 0 3]; %adaptation numéro du bras/numéro du capteur
            sub = rossubscriber('/joint_states'); %abonnement à la position du bmoteur
            nbS = int2str(nb); %conversion en texte
            txt = ['/joint_' nbS '/command']; %création du nom du publieur
            [robot,mot] = rospublisher(txt); %publication
            mot.Data = pos; %mise à jour de la position
            send(robot,mot); %envoi en robot
            test = 1;
            cpt = 0;
            while(test < 1) %tant qu'on a pas atteint la position à +/-0.02 sur 4 soit +/-0.5%
                if(sub.LatestMessage.Position(table(nb)) > pos-0.02)
                   if(sub.LatestMessage.Position(table(nb)) < pos+0.02)
                        test = 0;
                   end
                end
                cpt = cpt+1;
                pause(0.001);
                if(cpt > 5000)
                    test = -1;
                    fprintf('error positionning');
                end
            end
        elseif(nb == 6) %pince
            [robot,mot] = rospublisher('/gripper_controller/gripper_action/goal');
            mot.Goal.Command.MaxEffort = 0.15;
            mot.Goal.Command.Position = 0.031;
            send(robot,mot);
            [robot,mot] = rospublisher('/gripper_joint/command');
            mot.Data = pos;
            send(robot,mot);
            pause(3); %attente
        else
            printf('error num arm too big');
        end
    else
        printf('error num arm too small');
    end
end