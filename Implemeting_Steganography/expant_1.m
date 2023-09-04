%Extracting the concealed secret data 
function in_to=expant_1(n,lb)

global i_o; global h_string;
b=bitget(n,1:8);
s=num2str(bi2de(b(1,1)));

h_string{1,i_o}=s;
if bitget(lb,1)==1
    if b(1,1)==1
        b(1,1)=0;
    else
        b(1,1)=1;
    end   
end

in_to=bi2de(b);

i_o=i_o+1;

end