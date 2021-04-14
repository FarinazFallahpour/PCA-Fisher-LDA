% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

function [mean1 egn_PCA egn_Fisher outImages_Fisher] = faceFisher(in_f)
%%
Class_number = 30;
Class_population = 21;
total_num = Class_population * Class_number; % Total number of training images
mean1 = mean(in_f,2); 
A = double(in_f )- repmat(mean1,1,630);
L = A'*A; 
[V D] = eig(L); 
L_eig = [];
for i = 1 : total_num-Class_number 
    L_eig = [L_eig V(:,i)];
end
egn_PCA = A * L_eig; 

% Zi = egn_PCA' * (in_fi-mean1)
outImages_PCA = [];
for i = 1 : total_num
    temp = egn_PCA'*A(:,i);
    outImages_PCA = [outImages_PCA temp]; 
end
m_PCA = mean(outImages_PCA,2);
m = zeros(total_num-Class_number,Class_number); 
Sw = zeros(total_num-Class_number,total_num-Class_number); 
Sb = zeros(total_num-Class_number,total_num-Class_number); 
for i = 1 : Class_number
    m(:,i) = mean( ( outImages_PCA(:,((i-1)*Class_population+1):i*Class_population) ), 2 )';    
    S  = zeros(total_num-Class_number,total_num-Class_number); 
    for j = ( (i-1)*Class_population+1 ) : ( i*Class_population )
        S = S + (outImages_PCA(:,j)-m(:,i))*(outImages_PCA(:,j)-m(:,i))';
    end
    Sw = Sw + S; 
    Sb = Sb + (m(:,i)-m_PCA) * (m(:,i)-m_PCA)';
end
[J_eig_vec, J_eig_val] = eig(Sb,Sw);
J_eig_vec = fliplr(J_eig_vec);

for i = 1 : Class_number-1 
    egn_Fisher(:,i) = J_eig_vec(:,i); 
end

%% Projecting images onto Fisher linear space
% Yi = egn_Fisher' * egn_PCA' * (in_fi - mean1) 
for i = 1 : Class_number*Class_population
    outImages_Fisher(:,i) = egn_Fisher' * outImages_PCA(:,i);
end