%insert the binary in the select block

function out=insert_bit_e(n,lb)
global i_c; 
global changes;
%global binary;
%global m_size;
global ch;
b=bitget(n,1:8);

if b(1)==bitget(str2num(lb),1);
	changes{1,i_c}=0;
	ch=ch+1;
else 
	changes{1,i_c}=1;
	ch=ch+1;
end
	
b(1,1)=bitget(str2num(lb),1);
out=bi2de(b);
i_c=i_c+1;
end