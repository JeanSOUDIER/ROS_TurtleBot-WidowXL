%Fonction pour envoyer le nombre de moteur au bras
% SD (objet de l'USB, fichier de description)

function SetNbMot(SD)
    ARB_SIZE_POSE = 7;
    nb = 6;
    SendArm(SD, ARB_SIZE_POSE, [nb]);
end