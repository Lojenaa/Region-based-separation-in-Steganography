%Block selection code 

function t=block_selection(n,c,m,p)
global pp;global im ;global Bdum;global edge_find;global ede;global check_e;global check_ek;global re; global m_size;
fo=0;
differB=zeros(m_size,m_size-1);
o=1;op=1;

	for i=m:1:p
		for j=n:1:c
		  Btmp=im(i,j,pp:pp); 
		   for k1=o:1:o
				for t=op:1:op
					Bdum(k1,t)=Btmp;
				end
			end
			if op==m_size
			   op=1;
			end 
			op=op+1;
		end 
		op=1;
			if o==m_size
			   o=1;
			end
			o=o+1;
	end
	
xa=c/m_size;
ya=p/m_size;
apv=0;
mea=mean(mean(Bdum));

	for i=1:1:m_size
		for j=1:1:m_size
			differB(i,j)=abs(Bdum(i,j)-mea);   
		end
	end

	  for i=1:1:m_size
		for j=1:1:m_size
			   if differB(i,j)>10
				  apv=apv+1;  
			   end
		end
	  end  

if(apv>4)
   re=re+1;
   check_ek{1,re}=[ num2str(xa) ',' num2str(ya)];
   else
 end
t=c;
end
