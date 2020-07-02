%Function to find an object with all picture named ImgName+".jpg"
% mypi (object raspberry pi)

function [PosO NbPlot] = TryGetObject(mypi, ImgName, NbPlot)
    Img = TakePhoto(mypi,-1);
    cpt = 0;
    ImgN = ImgName+int2str(cpt)+".jpg";
    ImgN = convertStringsToChars(ImgN);
    while(isfile(ImgN))
        ImgN
        [PosO NbPlot] = GetObject(Img, ImgN, NbPlot);
        if(norm(PosO) ~= 0)
            break;
        end
        cpt = cpt+1;
        ImgN = ImgName+int2str(cpt)+".jpg";
        ImgN = convertStringsToChars(ImgN);
    end
end