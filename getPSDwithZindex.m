function [psd] = getPSDwithZindex(soot_psd,z_in)

rows = soot_psd.z_index == z_in;

v = soot_psd.v(rows);
ni = soot_psd.ni(rows);

psd = [v,ni];

end

