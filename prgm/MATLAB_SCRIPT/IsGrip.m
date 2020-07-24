function res = IsGrip(SD)
    SendAx12(SD, 2, [40 2], 6);
    test =  ReadAx12(SD);
    while(sum(test) == 0)
        test =  ReadAx12(SD);
    end
    out = uint16(test(3))*256+uint16(test(2));
    if(out < 300)
        res = true;
    else
        res = false;
    end
end
