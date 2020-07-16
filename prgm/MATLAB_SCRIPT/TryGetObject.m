%Fonction pour trouver un objet dans une image selon une banque
% forme ImgName+"[NUM].jpg"
% mypi (objet Raspberry pi)

function [PosO NbPlot] = TryGetObject(mypi, ImgName, NbPlot)
    Img = TakePhoto(mypi,-1); %Prise de la photo
    cpt = 0;
    ImgN = ImgName+int2str(cpt)+".jpg"; %Création du nom
    ImgN = convertStringsToChars(ImgN);
    while(isfile(ImgN)) %Tant qu'il y a une image qui a le bon nom
        [PosO NbPlot] = GetObject(Img, ImgN, NbPlot); %Recherche de l'objet
        if(norm(PosO) ~= 0) %Si on a trouvé l'objet
            break; %On arrète
        end
        cpt = cpt+1; %On incrémente le nom
        ImgN = ImgName+int2str(cpt)+".jpg";
        ImgN = convertStringsToChars(ImgN);
    end
end