%Fonction pour calculer la distance entre la caméra et l'objet pour le bras
%                 |\ Camera
%                 | \
%                 |  \
%                 |   \
%                 |    \
%              H  |     \  L
%                 |      \
%                 |       \
%                 |___X____\
%                     Objet Pos [X Y] (en pixels)
%
% Angle : du bras par rapport à la base

function O = ComputeDistCamArm(Pos, L, H, Angle)
    Px = Pos(1);
    Py = Pos(2);
    
    %Définition des constantes
    ANGLE_CAM = 48.8;
    ANGLE_CAM = ANGLE_CAM/2*pi/180;
    ANGLE_CAM_H = 62.2;
    ANGLE_CAM_H = ANGLE_CAM_H/2*pi/180;
    RESOL_X_MAX = 720;
    RESOL_Y_MAX = 640;

    %Px
    a = L*tan(ANGLE_CAM); %Calcul de la distance entre le centre de l'image et l'objet en X
    X = a*Px/RESOL_X_MAX; %Produit en croix pour convertir en [mm]

    %Py
    b = L*tan(ANGLE_CAM_H); %Calcul de la distance entre le centre de l'image et l'objet en Y
    Y = b*Py/RESOL_Y_MAX; %Produit en croix pour convertir en [mm]
    
    %Ajout de l'angle du bras
    [Gamma R] = cart2pol(Y,X); %Conversion en coordonnées polaires
    Gamma = Angle+Gamma; %Ajout de l'angle du bras
    [Xa Ya] = pol2cart(Gamma,R); %Reconversion en coordonnées cartésiennes
    
    [X0 Y0] = pol2cart(Angle,H); %Conversion de coordonnées cartésiennes sur la partie de l'image
    Xf = X0+Xa; %Ajout des dépendance en X entre le centre de l'image et de la distance de l'ojet sur l'image
    Yf = Y0+Ya;
    
    O = [Xf Yf];
end
    