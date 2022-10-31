function [psd_out] = clean_psd(soot_in,z)
psd_out = zeros(length(soot_in(:,1))/2,5);
z_out = zeros(length(soot_in(:,1))/2,1);

index = 1;
for i = 1:2:length(soot_in(:,1))
    disp(index)
    psd_out(index,1:4) = soot_in(i,:);
    psd_out(index,5) = soot_in(i+1,1);
    z_out(index) = z(soot_in(i,2));
    
    index = index+1;
    
end


psd_out = table(psd_out(:,2),psd_out(:,3),z_out(:),psd_out(:,4),psd_out(:,5),'VariableNames'...
    ,{'z_index','ni_index','z','v','ni'});



end

