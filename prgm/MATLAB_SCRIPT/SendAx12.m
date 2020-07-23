%Fonction pour envoyer des données à l'arduino du bras
% myserialdevice (objet de l'USB, fichier de description)

function SendAx12(myserialdevice, Ins, Data, Id)
    Send = [Ins Data]; %Création du vecteur de la forme [255 253 longueur Instruction [Données] Correction]
    Send = [255 Id length(Send)+1 Send];
    Checksum = 255-(mod(sum(Send),256)+1);
    Send = [Send Checksum];
    write(myserialdevice,Send,'uint8');
end