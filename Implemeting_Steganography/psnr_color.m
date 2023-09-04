
function [ psnr_Value ] = psnr_color(S, M)

%RGB component for Original image
Rs=S(:,:,1);
Gs=S(:,:,2);
Bs=S(:,:,3);

%RGB component for Modified image
Rm=M(:,:,1);
Gm=M(:,:,2);
Bm=M(:,:,3);


% Calculate MSE, mean square error.
Rdiff = (double(Rs) - double(Rm)) .^ 2;
Gdiff = (double(Gs) - double(Gm)) .^ 2;
Bdiff = (double(Bs) - double(Bm)) .^ 2;


[r c w] = size(S);
    
Rmse = sum(Rdiff(:)) / (r * c);
Gmse = sum(Gdiff(:)) / (r * c);
Bmse = sum(Bdiff(:)) / (r * c);

mse= Rmse+ Gmse+ Bmse;

% Calculate PSNR (Peak Signal to noise ratio)
psnr_Value = 10 * log10( (255^2*3) / mse);

end





