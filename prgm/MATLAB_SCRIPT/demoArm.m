Homing(SD);
for l = -340:80:340
    for k = 0:80:340
        for j = 0:100:700
            [k l j]
            MoveArmAll(SD, k, l, j, 0, 3, -1);
        end
    end
end
