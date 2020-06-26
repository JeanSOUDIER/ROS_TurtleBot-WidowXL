function [PosO NbPlot] = TryGetObject(mypi, ImgName, NbPlot)
    Img = TakePhoto(mypi,-1);
    for i = 1:length(ImgName)
        [PosO NbPlot] = GetObject(Img, ImgName(i), NbPlot);
        if(norm(PosO) ~= 0)
            break;
        end
    end
end