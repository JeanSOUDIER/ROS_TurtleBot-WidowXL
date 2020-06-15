function [PosO, NbPlot] = GetObject(sceneImage, NbPlot)
    boxImage = imread('Pile2.jpg');
    boxImage = rgb2gray(boxImage);

    sceneImage = rgb2gray(sceneImage);

    boxPoints = detectSURFFeatures(boxImage);
    scenePoints = detectSURFFeatures(sceneImage);

    figure (NbPlot);
    imshow(boxImage);
    title('100 Strongest Feature Points from Box Image');
    hold on;
    plot(selectStrongest(boxPoints, 500));

    NbPlot = NbPlot+1;
    figure (NbPlot);
    imshow(sceneImage);
    title('300 Strongest Feature Points from Scene Image');
    hold on;
    plot(selectStrongest(scenePoints, 1000));

    [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

    boxPairs = matchFeatures(boxFeatures, sceneFeatures);

    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);

    %figure;
    %showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, matchedScenePoints, 'montage');
    %title('Putatively Matched Points (Including Outliers)');

    result = matchedScenePoints.Location-matchedBoxPoints.Location;
    if(length(result(:,1)) > 1)
        result = mean(result);
    end
    result = result+size(boxImage)/2;
    NbPlot = NbPlot+1;
    figure (NbPlot);
    imshow(sceneImage);
    % Plot cross at row 100, column 50
    if(isempty(result))
        fprintf("not found\n");
        PosO = [0 0];
    else
        hold on;
        plot(result(1),result(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
        hold off;
        PosO = [result(1) result(2)]
    end
end

