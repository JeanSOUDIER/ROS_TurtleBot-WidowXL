%Fonction pour caster la position du bras selon la forme pour la carte
%arduino

function PosC = CastPos(Pos, id)
    PosC = [id];
    for i = 1:length(Pos)
        %Forme [id LSB_pos1 MSB_pos1 ... LSB_posN MSB_posN]
        PosC = [PosC mod(Pos(i),256) floor(Pos(i)/256)];
    end
end