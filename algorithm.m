function prob = algorithm(q)
load sp500
format short e
T=price_move;
%disp(T);
Transition=[0.8 0.2
             0.2 0.8];
% plot and return the probability
Emission=[1-q q
          q  1-q];
alpha(39,2)=0;
beta(39,2)=0;
pi=[0.2 0.8];
price_move(price_move<0)=0;
price_move(1);
alpha(1,:)=pi.*Emission(price_move(1)+1,:);
beta(39,:)=1;
for i=2:39
    k=alpha(i-1,:)*Transition;
   alpha(i,:)= k.*Emission(price_move(i)+1,:);

end
for i=38:-1:1
 %   k=Transition*beta(i+1,:)';
 %  beta(i,:)= k'.*Emission(price_move(i+1)+1,:);
   k= beta(i+1,:).*Emission(price_move(i+1)+1,:);
   beta(i,:)=(Transition*k')';

end
gamma= alpha.*beta;
gamma=  diag(1./sum(gamma,2))*gamma;
%disp('aplpha');
%disp(alpha);
%disp('beta');
%disp(beta);
%disp('gamma');
%disp(gamma);
prob=gamma(39,1);
%disp('ans');
%disp(gamma(39,1));
%figure;

plot(gamma(:,1));
hold on;