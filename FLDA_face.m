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
[mean1, A, egn] = faceFisher(out);
disp('mean1')
disp(mean1)
disp('A')
disp(A)
disp('egn')
disp(egn)