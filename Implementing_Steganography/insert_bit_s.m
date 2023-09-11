%insert the binary in the select block

function out=insert_bit_s(n,lb)
global i_c1; 
global changes1;
global binary;
global m_size;
global ch1;
b=bitget(n,1:8);
	if b(1)==bitget(str2num(lb),1);
		changes1{1,i_c1}=0;
		ch1=ch1+1;
	else 
		changes1{1,i_c1}=1;
		ch1=ch1+1;
	end
	
b(1,1)=bitget(str2num(lb),1);
out=bi2de(b);
i_c1=i_c1+1;
end