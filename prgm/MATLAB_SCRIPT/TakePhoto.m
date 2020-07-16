%Fonction pour prendre une photo avec la cam�ra
% tbot (objet Turtlebot)

function [img, NbPlot] = TakePhoto(mypi, NbPlot)
    mycam = cameraboard(mypi,'Resolution','1280x720'); %D�claration de la cam�ra
    img = snapshot(mycam); %Prise de la photo
    %Affichage
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        imshow(img);
    end
end