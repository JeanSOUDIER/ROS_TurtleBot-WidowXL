%Fonction pour afficher une ligne
% (x0,y0) la position de d�part
% R la longueur
% Theta l'angle de la ligne
% color la couleur

function [A,B] = linePol(x0,y0,R,Theta,color)
    X = [x0 x0+R*cos(Theta)]; %vecteurs avec les positions de d�but et de fin de la ligne
    Y = [y0 y0+R*sin(Theta)];
    A = X(2); %retour des coordonn�es de fin de la ligne
    B = Y(2);
    plot(X,Y,color)
end