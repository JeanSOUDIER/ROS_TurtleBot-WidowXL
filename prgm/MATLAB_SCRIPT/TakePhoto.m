%Function to get a photo from the camera
% tbot (object Turtlebot)

function [img, NbPlot] = TakePhoto(mypi, NbPlot)
    mycam = cameraboard(mypi,'Resolution','1280x720');
    img = snapshot(mycam);
    if(NbPlot > 0)
        figure(NbPlot);
        NbPlot = NbPlot+1;
        imshow(img);
    end
end