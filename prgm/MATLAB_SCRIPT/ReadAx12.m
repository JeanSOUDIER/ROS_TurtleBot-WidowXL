function [Data Id Ins] = ReadAx12(SD)
    out = [];
    Start = read(SD,1);
    Id = read(SD,1);
    Ins = read(SD,1);
    Leng = read(SD,1);
    Data = read(SD,Leng-1);
    Checksum = read(SD,1);
end