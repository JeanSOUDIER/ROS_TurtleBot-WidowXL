function [PosO, NbPlot] = GetObject(sceneImage, ImgName, NbPlot)
    ImgName = ImgName+".jpg";
    ImgName = convertStringsToChars(ImgName);
    boxImage = imread(ImgName);
    boxImage = rgb2gray(boxImage);

    sceneImage = rgb2gray(sceneImage);

    boxPoints = detectSURFFeatures(boxImage);
    scenePoints = detectSURFFeatures(sceneImage);

    figure (NbPlot);
    NbPlot = NbPlot+1;
    imshow(boxImage);
    title('100 Strongest Feature Points from Box Image');
    hold on;
    plot(selectStrongest(boxPoints, 500));

    figure (NbPlot);
    NbPlot = NbPlot+1;
    imshow(sceneImage);
    title('300 Strongest Feature Points from Scene Image');
    hold on;
    plot(selectStrongest(scenePoints, 1000));

    [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

    boxPairs = matchFeatures(boxFeatures, sceneFeatures);

    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);

    %figure(NbPlot);
    %NbPlot = NbPlot+1;
    %showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, matchedScenePoints, 'montage');
    %title('Putatively Matched Points (Including Outliers)');

    %result = matchedScenePoints.Location-matchedBoxPoints.Location;
    %{
    if(length(result(:,1)) > 1)
        result = mean(result)
    end
    result = result+size(boxImage)/2
    %}
    figure (NbPlot);
    NbPlot = NbPlot+1;
    imshow(sceneImage);
    % Plot cross at row 100, column 50
    if(isempty(matchedScenePoints.Location))
        fprintf("not found\n");
        PosO = [0 0];
    else
        PosO = matchedScenePoints.Location(1,:);
        hold on;
        plot(PosO(1),PosO(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
        hold off;
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

