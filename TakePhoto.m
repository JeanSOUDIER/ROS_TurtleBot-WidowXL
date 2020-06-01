function TakePhoto(mypi,NbPlot)
    mycam = cameraboard(mypi,'Resolution','1280x720');
    img = snapshot(mycam);
    figure(NbPlot);
    imagesc(img);
end