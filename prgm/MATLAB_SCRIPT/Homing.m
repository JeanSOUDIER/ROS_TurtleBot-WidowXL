function Homing()
    fprintf("HOMING !!");
    MoveMot(6, 1);
    MoveMot(5, 0.01);
    %4
    %3
    MoveMot(2, -0.8);
    MoveMot(1, 0.9);
end