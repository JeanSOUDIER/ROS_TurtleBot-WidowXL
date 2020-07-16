%Fonction pour normaliser le terrain

function Map = AdjustMap(Map)
    a = size(Map);
    for j = 1:a(1)
        for k = 1:a(2)
            if(Map(j,k) >= 10) %Saturation des obstacles
                Map(j,k) = 10;
            elseif(Map(j,k) > 0) %Saturation du terrain connu
            	Map(j,k) = 1;
            end
         end
    end
end