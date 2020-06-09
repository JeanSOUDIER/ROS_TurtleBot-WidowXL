function PosO = GetObject(mypi)
    boxImage = imread('Pile2.jpg');
    boxImage = rgb2gray(boxImage);

    sceneImage  = TakePhoto(mypi,-1);
    sceneImage = rgb2gray(sceneImage);

    boxPoints = detectSURFFeatures(boxImage);
    scenePoints = detectSURFFeatures(sceneImage);

    figure;
    imshow(boxImage);
    title('100 Strongest Feature Points from Box Image');
    hold on;
    plot(selectStrongest(boxPoints, 500));

    figure;
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
    figure;
    imshow(sceneImage);
    hold on;
    % Plot cross at row 100, column 50
    plot(result(1),result(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
    hold off;

    PosO = [(760+result(2))/cosd(50) result(1)]
end

