%Function to cast the position to send to the arm

function PosC = CastPos(Pos, id)
    PosC = [id];
    for i = 1:length(Pos)
        PosC = [PosC mod(Pos(i),256) floor(Pos(i)/256)];
    end
end