%Fonction pour envoyer des donn�es � l'arduino du bras
% myserialdevice (objet de l'USB, fichier de description)

function SendArm(myserialdevice, Ins, Data)
    Send = [Ins Data]; %Cr�ation du vecteur de la forme [255 253 longueur Instruction [Donn�es] Correction]
    Send = [255 253 length(Send)+1 Send];
    Checksum = 255-(mod(sum(Send),256)+1);
    Send = [Send Checksum];
    write(myserialdevice,Send,'uint8');
end