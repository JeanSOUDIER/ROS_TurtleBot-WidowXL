function F = equation2R(~, x, L1, L2, X, Y)
	F(1) = L1*cosd(x(1)) + L2*cosd(x(1) + x(2)) - X;
    F(2) = L1*sind(x(1)) + L2*sind(x(1) + x(2)) - Y;
end