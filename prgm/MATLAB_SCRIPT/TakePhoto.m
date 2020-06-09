function img = TakePhoto(mypi,NbPlot)
    mycam = cameraboard(mypi,'Resolution','1280x720');
    img = snapshot(mycam);
    if(NbPlot > 0)
        figure(NbPlot);
        imshow(img);
    end
end