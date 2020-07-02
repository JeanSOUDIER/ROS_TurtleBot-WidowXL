%Function to find an object in an image
% ImgName (string, "X.jpg")
% sceneImage (img to analyse)

function [PosO, NbPlot] = GetObject(sceneImage, ImgName, NbPlot)
    %Read image and convert in gray levels
    boxImage = imread(ImgName);
    boxImage = rgb2gray(boxImage);
    sceneImage = rgb2gray(sceneImage);

    %Find interested points
    boxPoints = detectSURFFeatures(boxImage);
    scenePoints = detectSURFFeatures(sceneImage);

    [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

    boxPairs = matchFeatures(boxFeatures, sceneFeatures);

    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    
    if(NbPlot > 0)
        figure (NbPlot);
        NbPlot = NbPlot+1;
        imshow(sceneImage);
    end
    if(isempty(matchedScenePoints.Location))
        fprintf("not found\n");
        PosO = [0 0];
    else
        PosO = matchedScenePoints.Location(1,:);
        if(NbPlot > 0)
            hold on;
            plot(PosO(1),PosO(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
            hold off;
        end
        %Saturation
        PosO = [640-PosO(1) 720-PosO(2)];
        if(PosO(2) < 0)
            PosO(2) = 0;
        end
        if(PosO(2) > 720)
            PosO(2) = 720;
        end
        if(PosO(1) < -640)
            PosO(1) = -640;
        end
        if(PosO(1) > 640)
            PosO(1) = 640;
        end
        PosO
    end
end
