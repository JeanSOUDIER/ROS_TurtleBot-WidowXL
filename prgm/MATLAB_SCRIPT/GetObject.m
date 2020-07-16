%Fonction pour trouver un objet dans une image
% ImgName (string, "X[NUM].jpg")
% sceneImage (img à analyser)

function [PosO, NbPlot] = GetObject(sceneImage, ImgName, NbPlot)
    %Lecture des images et conversion en niveaux de gris
    boxImage = imread(ImgName);
    boxImage = rgb2gray(boxImage);
    sceneImage = rgb2gray(sceneImage);

    %On cherche les points d'intérêts
    boxPoints = detectSURFFeatures(boxImage);
    scenePoints = detectSURFFeatures(sceneImage);

    [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

    %Comparaisons des similitudes
    boxPairs = matchFeatures(boxFeatures, sceneFeatures);

    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    
    %Affichage
    if(NbPlot > 0)
        figure (NbPlot);
        NbPlot = NbPlot+1;
        imshow(sceneImage);
    end
    %S'il n'y a pas d'occurence
    if(isempty(matchedScenePoints.Location))
        fprintf("pas d'objet\n");
        PosO = [0 0];
    else
        PosO = matchedScenePoints.Location(1,:);
        %Affichage suite
        if(NbPlot > 0)
            hold on;
            plot(PosO(1),PosO(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
            hold off;
        end
        %Saturation des valeurs
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
    end
end
