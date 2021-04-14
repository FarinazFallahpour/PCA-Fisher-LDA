% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour
function [m, A, Eigenfaces] = facePCA(in_f)

in_f=double(in_f);
in_f2=in_f';
m=mean(in_f2);
m=m';
[min_f,nin_f]=size(in_f);

%%% Calculating the deviation of each image from mean image
A = [];  
for i = 1 : nin_f
    Diff=in_f(:,i)-m;  
    A = [A Diff];   
end

L = A'*A; % L =A*A'.
[V D] = eig(L); % eigenvalues of L 

%%% Sorting and eliminating eigenvalues
L_eig = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1 )
        L_eig = [L_eig V(:,i)];
    end
end
%%% Calculating the eigenvectors of covariance matrix 'C'
Eigenfaces = A * L_eig; % A: centered image vectors


%