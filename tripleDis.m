function [U] = tripleDis(R)
%% Basic Information
S = [0.5 -0.5 0; 0.5 0.5 0.5; 0 0 0.5]; % FCC unit cell
% 8 corners of the unit cell
C1 = [0 0 0]; 
C2 = [1 0 0]; C3 = [0 1 0]; C4 = [0 0 1];
C5 = [1 1 0]; C6 = [1 0 1]; C7 = [0 1 1];
C8 = [1 1 1]; C = [C1; C2; C3; C4; C5; C6; C7; C8];

G = S'*S;
%% Calculation of Disclination
M_e = zeros(3,3); M_i =  zeros(3,3);
for ii = 1:3
    for jj = 1:3
       if R(ii,jj)>=1
           M_e(ii,jj)=1; M_i(ii,jj)=R(ii,jj)-1;
       elseif R(ii,jj)<0
            M_e(ii,jj)=-1; M_i(ii,jj)=R(ii,jj)+1;
       else
           M_e(ii,jj)=0; M_i(ii,jj)=R(ii,jj);
       end
    end
end
d = zeros(3,8); CC =zeros(8,4,3);
for ii = 1:3
    x = M_i(:,ii);
    for iii = 1:8
    d(ii,iii) = (x-C(iii,:)')'*G*(x-C(iii,:)');
    CC(iii,:,ii) = [C(iii,:) d(ii,iii)];
    end
end
CC(:,:,1) = sortrows(CC(:,:,1),4); CC(:,:,2) = sortrows(CC(:,:,2),4); CC(:,:,3) = sortrows(CC(:,:,3),4); 
% Order (first to third)
    for ii = 1:8
        for iii = 1:8
            for iiii = 1:8
                M_i(:,1) = CC(iiii,1:3,1)';
                M_i(:,2) = CC(iii,1:3,2)';
                M_i(:,3) = CC(ii,1:3,3)';
                M = M_e+M_i;
            if det(M)==1
                UU = inv(M);
                if abs(det(UU))==1
                    U = inv(M);          return
                end
            end
            end
        end
    end