% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour
clc;
clear all;
close all;
currentpath=cd;
path_train=strcat(currentpath,'\train\');
Lt1=length(dir(path_train));
Files=dir(path_train);
k=1;
%% Reading images of databse in a column of a Matrix (out)
for i=3:Lt1-1  
    I1=imread(strcat(path_train,'\',Files(i).name));
    I1 = rgb2gray(I1);
    out(:,k)=I1(:);
    k=k+1;
end

%% Apply PCA to images
[mean, A, egn] = facePCA(out);
% %one of image after PCA
egn_image=reshape(A(:,10),128,128);
egn_image(egn_image<0)=0;
figure,imshow(egn_image)
out_image=reshape(out(:,10),128,128);
figure,imshow(out_image)
%% MSE
MSE1=mse(egn_image(:),double(out_image(:)))
A1=reshape(A(:,10),128,128);
B1=reshape(egn(:,10),128,128);
C=A1/B1;
figure,imshow(C)
currentpath=cd;
path_train=strcat(currentpath,'\test\');
Lt1=length(dir(path_train))
Files=dir(path_train);
InputImage = out_image;
temp = InputImage(:,:,1);
temp=out_image;
[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
output_image2=zeros(128*128,1);
for index=1:(128*128)
    output_image2(index)=double(out_image(index));
end
Difference =output_image2-mean; 

