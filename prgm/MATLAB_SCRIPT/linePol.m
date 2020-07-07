%Function to plot a line

function [A,B] = linePol(x0,y0,R,Theta,color)
    X = [x0 x0+R*cos(Theta)];
    Y = [y0 y0+R*sin(Theta)];
    A = X(2);
    B = Y(2);
    plot(X,Y,color)
end