%Extracting the concealed secret data 

function in_to=extract_bit_s(n,lb)
global i_o1; global h_string1;
b=bitget(n,1:8);
s=num2str(bi2de(b(1,1)));
h_string1{1,i_o1}=s;

	if bitget(lb,1)==1
		if b(1,1)==1
		   b(1,1)=0;
		else
		   b(1,1)=1;
		end   
	end

in_to=bi2de(b);
i_o1=i_o1+1;
end