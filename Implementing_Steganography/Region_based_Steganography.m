%main file for Region-based Separation Approach in the Steganography Techniques

clc;global pp;global check_ek;global check_sk;global check_ekd;global check_skd;global re;global g_string;global h_string;global g_string1;global h_string1;
global changes1;global i_o;global ch1;global i_c;global i_o1;global i_c1;global im;global ch;global changes ;global x;global y ;global Rdum;
global Gdum;global Bdum;global binary;global out;global m_size ;global k;

details=cell(fix(0),fix(0));
image_folder = 'F:\sample_image\512\Final\test'; %  Enter name of folder from which you want to upload pictures with full path
filenames = dir(fullfile(image_folder, '*.tiff'));  % read all images with specified extention, its jpg in our case
total_images = numel(filenames);    % count total number of photos present in that folder
for imn = 1:total_images
full_name= fullfile(image_folder, filenames(imn).name);         % it will specify images names with full path and extension
im= imread(full_name);                 % Read images  
sqr= imread(full_name); 
im_s= imread(full_name);
im_r = imread(full_name); 
Nfile=strcat(filenames(imn).name(1:size(filenames(imn).name,2)-4),'tiff');

pp=3;%number of chanels in image (eg:RGB image pp=3,Gray Sceal image pp=1)
ch=0;
m_size=8;
x=fix(size(im,2));
y=fix(size(im,1));

re=0;
ssrk=0; 
esrk=1;
sh=1;

i_c=1;
i_o=1;
Rdum=zeros(m_size,m_size);
Gdum=zeros(m_size,m_size);
Bdum=zeros(m_size,m_size);



check_es=cell(1,fix(0));
check_ek=cell(1,fix(0));%store Rough block index
check_sk=cell(1,fix(0));%store Smooth block index
check_ekd=cell(1,fix(0));%used region in Rough
check_skd=cell(1,fix(0));%used region in Smooth



%Block selection method 
for Ya=1:1:fix(y/m_size)
    for Xa=1:1:fix(x/m_size)
        
        wi=block_selection((Xa*m_size)-(m_size-1),Xa*m_size,(Ya*m_size)-(m_size-1),Ya*m_size);    
    end
end

%Store the Smooth Block index 
smk=1;
for sYa=1:1:fix(y/m_size)
    for sXa=1:1:fix(x/m_size)
         if size(check_sk,2)>=smk
            sm=check_sk{1,smk};
            smo=str2num(sm);
         end
         if(sYa==smo(2)&&sXa==smo(1))
             check_es{1,esrk}=[ num2str(sXa) ',' num2str(sYa)];
             esrk=esrk+1;
             smk=smk+1;  
         else
             check_es{1,esrk}=[ num2str(0) ',' num2str(0)];   
             esrk=esrk+1;
        end
    end
end

%Store the Rough  Block index 
for sYa=1:1:fix(y/m_size)
   for sXa=1:1:fix(x/m_size)
       if size(check_es,2)>=sh
           sm=check_es{1,sh};
           sh=sh+1;
           smo=str2num(sm);
           if(smo(2)==0&&smo(1)==0)
              exl=sXa*m_size-(m_size-1);
              eyl=sYa*m_size-(m_size-1);
              ssrk=ssrk+1;
              check_ek{1,ssrk}=[ num2str(sXa) ',' num2str(sYa)];
           end
        end
    end
end
i1=1;

box=500;%number of block need to concealed bit , this for same amount of bit concealed in smooth & rough region 
%if you need to concealed different bit size change the csk,cek 
csk=box; %csk:number of smooth region block 
cek=box; %cek:number of rough region block

%Assign the new array to the selected index according to the number of box
for i=1:1:cek
    check_ekd{1,i}=check_ek{1,i};    
end

for i=1:1:csk
    check_skd{1,i}=check_sk{1,i};  
end

%read the message file 
fileid=fopen('F:\misc\message.txt','r');
data=fread(fileid);
s=char(data);
fclose(fileid);

%Assign the new name for save files  
file=strcat('3Nf8_',num2str(box),'_',num2str(pp),Nfile);% new name for original file 
file3=strcat('3vNf8_',num2str(box),'_',num2str(pp),'SR_',Nfile);%selected region  
file2=strcat('3vNf8_',num2str(box),'_',num2str(pp),'S_',Nfile);%Smooth region setgoimage
file1=strcat('3vNf8_',num2str(box),'_',num2str(pp),'R_',Nfile);%Rough region setgoimage
kk1=[file];

disp('................Image Name.................');
disp(kk1);
disp('................Image Name.................');

%message file convert to the binary  
binary=dec2bin(s,m_size);
sz=size(binary,1);
szn=cek;
changes=cell(1,fix(szn));
h_string=cell(1,fix(szn));
p=0; 


% insert the message into Rough region

%xo=1;
for bi=1:1:cek
    ind=check_ekd{1,bi};
    a=str2num(ind);

    xl=a(1)*m_size-(m_size-1);
    yl=a(2)*m_size-(m_size-1);

    line_in=im(yl:a(2)*m_size,xl:a(1)*m_size,pp:pp);
 
    sqr=insertShape(sqr,'Rectangle',[ xl  yl  m_size m_size],'Color',{'red'},'LineWidth',1);
    
      
    for i=1:1:m_size
        for j=1:1:m_size
            A_val=line_in(i,j);
            if i_c<=size(binary,1)*m_size;
                if i+p<=size(binary,1);
                    bit=binary(i+p:i+p,j);
                end
                out= insert_bit_e(A_val,bit);
                im_i=(a(2)*m_size)-(m_size-i);
                im_j=(a(1)*m_size)-(m_size-j);
                im(im_i,im_j,pp:pp)=out;
               else
                break;
            end
        end
    end
    p=m_size+p;  
end


% save the Rough region setgoimage

folder1='F:\outputN\R_setgoimage';
imwrite(im,fullfile(folder1,file1));
im_copy=im;


if size(changes,2)>cek
   si=cek;
  else
   si=size(changes,2);
end
ni=1;m1=1;

%Read the message from the Rough region in the setgoimage
for bi_1=1:1:fix(si)
 
    ind1=check_ekd{1,bi_1};
    a1=str2num(ind1);
    xl_1=a1(1)*m_size-(m_size-1);
    yl_1=a1(2)*m_size-(m_size-1);

    line_in=im(yl_1:a1(2)*m_size,xl_1:a1(1)*m_size,pp:pp); 
 
     p1=1;i1=1;
     if i1*p1<=size(changes,2);    
        for i1=1:1:m_size
            for j1=1:1:m_size
                in_val=line_in(i1,j1);
                if i_o<=size(changes,2);
                    c_bit=changes{1,ni};
                    ni=ni+1;
                    in_to= extract_bit_e(in_val,c_bit);
                    im_i1=(a1(2)*m_size)-(m_size-i1);
                    im_j1=(a1(1)*m_size)-(m_size-j1);
                    im(im_i1,im_j1,pp:pp)=in_to;
                    else
                      break;
                end
             end
       end
       p1=p1+m_size;
    end 
end

% Display the message where the Rough region is hidden
if cek>1
   hp=size(h_string,2);
   g_string=cell(1,fix(hp/(m_size)));
   hide=char(h_string);
   hide_string=reshape(horzcat(h_string{:}),size(h_string,1),[]);
   for k1=1:1:hp/(m_size)
       g_string{1,k1}=str2double(hide_string(1+(k1-1)*m_size:m_size*k1));
   end
   g_stans=cell(1,fix(hp/(m_size)));

   for k2=1:1:hp/(m_size)
       g_stans{1,k2}=char(bin2dec(num2str(g_string{1,k2})));
   end
   hideword=char(g_stans); 
   hideword1=reshape(horzcat(g_stans{:}),size(g_stans,1),[]);
   disp(hideword1);
 
end

disp('..........................Smooth region work .................');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Smooth%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i_c1=1;i_o1=1;ch1=0;
ps=0;

changes1=cell(1,fix(0));
h_string1=cell(1,fix(0));


d=0;g=1;xs=1;
 
% insert the message into Smooth region

for bs=1:1:csk
    ins=check_skd{1,bs};
    as=str2num(ins);
    sx=as(1)*m_size-(m_size-1);
    sy=as(2)*m_size-(m_size-1);
	line_in_s=im_s(sy:as(2)*m_size,sx:as(1)*m_size,pp:pp);
 
    sqr=insertShape(sqr,'Rectangle',[ sx  sy  m_size m_size],'Color',{'green'},'LineWidth',1);
    for is=1:1:m_size
        for js=1:1:m_size
            A_valS=line_in_s(is,js);
            if i_c1<=size(binary,1)*m_size;
                if is+ps<=size(binary,1);
                    bitS=binary(is+ps:is+ps,js);
                end
                Sout= insert_bit_s(A_valS,bitS);
                im_iS=(as(2)*m_size)-(m_size-is);
                im_jS=(as(1)*m_size)-(m_size-js);
                im_s(im_iS,im_jS,pp:pp)=Sout;
                else
                break;
            end
         end
     end
     ps=m_size+ps;
end
figure(imn),imshow(sqr);

% save the Smooth region setgoimage

folder1='F:\outputN\S_setgoimage';
imwrite(im_s,fullfile(folder1,file2));
im_copy_s=im_s;

if size(changes1,2)>csk
   ssi=csk;
else
   ssi=size(changes1,2);
end
sni=1;

%Read the message from the Smooth region setgoimage

for sbi_1=1:1:fix(ssi)
    inds=check_skd{1,sbi_1};
    
    a1s=str2num(inds);

    sxl_1=a1s(1)*m_size-(m_size-1);
    syl_1=a1s(2)*m_size-(m_size-1);

    line_inS=im_s(syl_1:a1s(2)*m_size,sxl_1:a1s(1)*m_size,pp:pp); 
 
    sp1=1;si1=1;
    if si1*sp1<=size(changes1,2);    
       for si1=1:1:m_size
          for sj1=1:1:m_size
             sin_val=line_inS(si1,sj1);
                    if sni<=size(changes1,2);
                    sc_bit=changes1{1,sni};
                    sni=sni+1;
                    sin_to= extract_bit_s(sin_val,sc_bit);
                    sim_i1=(a1s(2)*m_size)-(m_size-si1);
                    sim_j1=(a1s(1)*m_size)-(m_size-sj1);
                    im_s(sim_i1,sim_j1,pp:pp)=sin_to;
                    else
                      break;
                    end
          end
       end
       sp1=sp1+m_size;
   end
end

%Display the message where the Smooth region is hidden
if csk>1
   hp1=size(h_string1,2);
   g_string1=cell(1,fix(hp1/(m_size)));
   hide1=char(h_string1);
   hide_string1=reshape(horzcat(h_string1{:}),size(h_string1,1),[]);

  for k1=1:1:hp1/(m_size)
      g_string1{1,k1}=str2double(hide_string1(1+(k1-1)*m_size:m_size*k1));
  end
  g_stans1=cell(1,fix(hp1/(m_size)));

  for k2=1:1:hp1/(m_size)
      g_stans1{1,k2}=char(bin2dec(num2str(g_string1{1,k2})));
  end
 
  Shideword=char(g_stans1); 
  Shideword1=reshape(horzcat(g_stans1{:}),size(g_stans1,1),[]);
  disp(Shideword1);
end



disp('..........................Smooth_new.................');

whos Shideword1;
whos s;


%calculate Validation mechanism PSNR,MSE,SSIM


disp('..........................Rough result.................');
disp('differen method');
err = immse(im,im_copy);
fprintf('\n The mean-squared new error is %0.4f\n', err);

npsnr=10*log10(255*255/err);
fprintf('\n psnr new error is %0.4f\n',npsnr);

disp('ssim');
esimval=ssim(im,im_copy);
fprintf('\n The ssim  error is %0.4f\n',esimval);

k=imabsdiff(im,im_copy);


disp('n_psnr');
epsnr=psnr(im,im_copy);
fprintf('\n The pnsr  error is %0.4f\n',epsnr);

disp('..........................Smooth result.................');
disp('differen method');
Serr = immse(im_s,im_copy_s);
fprintf('\n The mean-squared new error is %0.4f\n', Serr);

Snpsnr=10*log10(255*255/Serr);
fprintf('\n psnr new error is %0.4f\n',Snpsnr);

disp('ssim');
ssimval=ssim(im_s,im_copy_s);
fprintf('\n The ssim  error is %0.4f\n',ssimval);


disp('n_psnr');
spsnr=psnr(im_s,im_copy_s);

%Result table 

details{imn,1}=filenames(imn).name;
details{imn,2}=Snpsnr;
details{imn,3}=npsnr;
details{imn,4}=Serr;
details{imn,5}=err;
details{imn,6}=ssimval;
details{imn,7}=esimval;
details{imn,8}=size(check_ekd,2);
details{imn,9}=size(check_ek,2);
details{imn,10}=size(check_skd,2);
details{imn,11}=size(check_sk,2);
details{imn,12}=epsnr;
details{imn,13}=spsnr;

%selected region image 
folder1='F:\outputN\selected_region';
imwrite(sqr,fullfile(folder1,file3));

%save the orignal image
folder2='F:\outputN\orignal_image';
imwrite(im_r,fullfile(folder2,file));

 end