%Code de démonstration pour le déplacement du bras

%Position de repos
Homing(SD);
l = 0;
%for l = -340:80:340
    for k = 0:80:340
        for j = 0:100:700
            [k l j]
            %Test de toutes les positions possibles
            MoveArmAll(SD, k, l, j, 0, 3, -1);
        end
    end
%end
