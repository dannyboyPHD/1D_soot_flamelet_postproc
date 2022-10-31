function [look_up] = clean_lookup(table_in)
col_heading = string(table_in.Properties.VariableNames(1));
row = 1;

first_char = string(table_in(row,col_heading).Variables);

while(~first_char.startsWith('SPECIES'))
%     disp(first_char);
    row = row +1;
    first_char = string(table_in(row,col_heading).Variables);
end

row = row+3;
first_char = string(table_in(row,col_heading).Variables);


species_cntr= 0;


while(~first_char.startsWith('-----------------------------------'))
    row_values = first_char.split;
    
    species_sym = row_values(2);
    phase = row_values(3);
    charge = row_values(4);
    MR = row_values(5);
    T_Lo = row_values(6);
    T_Hi = row_values(7);
    
    disp(species_sym);% species symbol i.e. O2, AR, N2 ...
    
    % update, find next row
    row = row +1;
    species_cntr = species_cntr +1;
    first_char = string(table_in(row,col_heading).Variables);
    
    if(species_cntr == 1)
%        look_up = table(species_sym, phase, charge, MR, T_Lo, T_Hi,'VariableNames', {'species','phase','charge','MR','T_Lo','T_Hi'}) ;
         look_up = table(phase, charge, MR, T_Lo, T_Hi,species_cntr+1,'VariableNames', {'phase','charge','MR','T_Lo','T_Hi','offset'},'RowNames',string(species_sym)) ;

    else
%         add_tab = table(species_sym, phase, charge, MR, T_Lo, T_Hi,'VariableNames', {'species','phase','charge','MR','T_Lo','T_Hi'}) ;
        add_tab = table(phase, charge, MR, T_Lo, T_Hi,species_cntr+1,'VariableNames', {'phase','charge','MR','T_Lo','T_Hi','offset'},'RowNames',string(species_sym)) ;
        look_up = [look_up;add_tab];
        
    end
    
end


% sort out data types
look_up = convertvars(look_up,{'MR','T_Lo','T_Hi'},'double');

disp(strcat(string(species_cntr),' species found'));





end

