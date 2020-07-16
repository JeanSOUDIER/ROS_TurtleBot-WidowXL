%Fonction pour calculer la position de l'objet
%               /\Camera
%              /  \
%             /    \
%      L     /      \
%           /        \
%          /  theta   \
%   Robot /_)__________\ Po2 = [X Y] (en pixels)

function O = ComputeDistCam(L, theta, Po2)
    Px = Po2(2)
    Py = Po2(1)
    Theta = theta;

    %D�finition des constantes
    ANGLE_CAM = 48.8;
    ANGLE_CAM = ANGLE_CAM/2*pi/180;
    ANGLE_CAM_H = 62.2;
    ANGLE_CAM_H = ANGLE_CAM_H/2*pi/180;
    RESOL_X_MOY = 360;
    RESOL_X_MAX = 720;
    RESOL_Y_MAX = 640;

    Theta = Theta*pi/180;

    %Calcul de Xmin(0 pixel), Xmoy(360 pixels) et Xmax(720 pixels)
    a = sin(Theta)*L; %D�duction de la hauteur de la cam�ra
    Alpha = pi/2-Theta; %On ajuste par rapport � l'axe des ordonn�es
    Beta = pi/2-Alpha-ANGLE_CAM; %On calcule l'angle minimum
    d = a/cos(Beta); %On calcule la distance entre la cam�ra et le bas de l'image
    Xmin = sqrt(d^2+L^2-2*d*L*cos(pi/2-ANGLE_CAM)); %On applique le th�or�me de pythagore g�n�ralis�

    Xmoy = L/cos(Theta); %On applique le th�ot�me de pythagore (angle droit avec la cam�ra)

    e = a/cos(Beta+2*ANGLE_CAM); %Idem que d et Xmin
    Xmax = sqrt(e^2+L^2-2*e*L*cos(pi/2+ANGLE_CAM));

    %On approxime le r�sultat avec une parabole pour compenser la lentille
    %o� A,B et C les coeffs du polynome (A*Px^2+B*Px+C = X)
    A = (Xmax-RESOL_X_MAX*((Xmoy-Xmin)/RESOL_X_MOY)) / (RESOL_X_MAX^2-RESOL_X_MAX*RESOL_X_MOY);
    B = (Xmoy-Xmin-RESOL_X_MOY^2*A)/RESOL_X_MOY;
    C = Xmin;
    X = A*Px^2+B*Px+C;
    
    %Py
    f = sqrt(X^2+L^2-2*L*X*cos(ANGLE_CAM_H)); %On applique le th�or�me de pythagore g�n�ralis�
    %f est la distance en la cam�ra et l'objet
    g = f*tan(ANGLE_CAM_H); %Calcul de la distance entre le centre de l'image et l'objet
    Y = g*Py/RESOL_Y_MAX; %Produit en croix pour ajuster � une valeur en [mm]
    
    O = [X Y]; %Cr�ation de la sortie
end