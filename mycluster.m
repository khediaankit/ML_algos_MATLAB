function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!
%centroid = datasample(unique(bow,'rows'),K,'Replace',false);
%disp(bow);
%disp(centroid);
format short e
nw=size(bow,2);
doc_s=size(bow,1);
%pi_c(1,1:K)=1/K;
%pi_c=[1/4,1/2,1/8,1/8];


    
pi_c=rand(1,K);
pi_c= pi_c*(1/sum(pi_c(:)));
%centroid(1:K,1:nw)=1/(nw*K);
centroid =rand(K,nw);
%diag(1./sum(centroid,1))
%centroid= centroid*diag(1./sum(centroid,1));
centroid= diag(1./sum(centroid,2))*centroid;
%disp(pi_c);
%disp(centroid);
%recalculate centroid and pi
%disp(bow);
%centroid=[1.0, 2.0,3.0;4.0,5.0,6.0];
%bow=[1.0,2.0,3.0;4.0,5.0,6.0;7.0,8.0,9.0];
%bow=bow(1:5,1:5);
%centroid=centroid(1:3,1:5);
%disp(bow);
for j=1:200
 for i=1:K
 b=bsxfun(@power,centroid(i,:), bow);
%  disp(b);
 multi_int=prod(b,2);
% disp(multi_int);
 gamma(:,i)= multi_int*pi_c(i);
 %disp(gamma(:,i)); 
 end
 %disp(gamma); 
%disp(diag(1./sum(gamma,2))); 
 gamma= diag(1./sum(gamma,2))*gamma;
 %disp(gamma); 
% % recalculte assignment
[val idx]=max(gamma,[],2);
class=idx;
 for i=1:K

   gamma_t=bsxfun(@times,gamma(:,i), bow);  
 %  disp(gamma_t);
   centroid(i,:)=sum(gamma_t,1)/sum(gamma_t(:));
%    disp('showing sum calc');
%    disp( sum(gamma_t,1));
%    disp('showing sum calc 2');
%     disp( sum(gamma_t(:)));
%     disp('showing sum calc1');
% disp( centroid(i,:))  
% 
 end
 %disp(gamma);
% disp(sum(gamma,1));
  pi_c=1/size(bow,1)*(sum(gamma,1))';
%disp(centroid);
%disp(pi_c);
%disp('new iter');
end
%disp(pi_c);
%a(1,1:size(bow,1))=1;
%class= a;

end

