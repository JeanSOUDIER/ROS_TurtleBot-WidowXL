%Fonction pour afficher un cercle
% (x,y) la position
% r le rayon
% color la couleur

function circle(x,y,r,color)
    ang=0:0.01:2*pi; 
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp,color);
end