function F = equation3R(x, L1, L2, L3, X, Y)
	F(1) = L1*cosd(x(1)) + L2*cosd(x(1) + x(2)) + L3*cosd(x(1) + x(2) + x(3)) - X;
    F(2) = L1*sind(x(1)) + L2*sind(x(1) + x(2)) + L3*sind(x(1) + x(2) + x(3)) - Y;
    F(3) = x(1) < 181;
 end