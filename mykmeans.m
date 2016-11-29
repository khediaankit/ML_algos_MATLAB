function [ class, centroid ] = mykmeans( pixels, K )
if(K > size(pixels,1))
    K = size(pixels,1);
end
 if(K > size(unique(pixels,'rows'),1))
    K = size(unique(pixels,'rows'),1);
end  
% if(K==1)
%   centroid = datasample(pixels,K,'Replace',false);
  
% block = size(pixels,1)/K;
% block = floor(block);
% disp(pixels(block,:));
% centroid1= zeros(K,3);
% for i=1:K
%     centroid(i,1:3)= pixels(i*block,:);
%    %  rnd= datasample(idxlist,1);
% end
% disp(centroid);
% fileID = fopen('med.txt','w');

 centroid = datasample(unique(pixels,'rows'),K,'Replace',false);
 %disp(centroid);
%calulating individual distance
% for i=1:size(pixels,1)
%     for j=1:K
%         %centroid(j,:)
%         %pixels(i,:)
%         
%         distf(j)= norm(centroid(j,:)-pixels(i,:));
%         %distf(j)
%         %disp('Iam here');
%     end
%           [val ind]= min(distf);
%           class(i)= ind;
% end
IDX = knnsearch(centroid,pixels,'distance','euclidean');
    %disp(IDX);
    class=IDX';
%calculating median
total_sum= zeros(K,3);
total_size= zeros(K,1);
%disp('tot siz');
%disp(total_size);
for i=1:size(pixels,1)
    
        total_sum(class(i),:)=total_sum(class(i),:)+ pixels(i,:);
        total_size(class(i))= total_size(class(i))+1;
       % fprintf(fileID,'the pixel value %d %d %d clss assigned %d\n',pixels(i,:),class(i));
end
        total_size(total_size==0)=1;
%  disp('after');
%  disp(total_size);
%   for i=1:K
%          
%         centroid1(i,:)=total_sum(i,:)/total_size(i);
%       %  fprintf(fileID,'the centroid tot val  %d %d %d an size %d\n',centroid1(i,:),totals );
%        % disp(centroid1(i,:));
%   end  
%   disp (total_sum);
%   disp('now size dude');
%   disp(total_size);
%   disp('now done dude');
    a= bsxfun(@rdivide,total_sum' ,total_size');
   centroid1=a';
 % disp(centroid1);
 count=0;
while(isequal(centroid, centroid1)==0 && count<=100)
    centroid=centroid1;
    count=count+1;
% for i=1:size(pixels,1)
%     for j=1:K
%         distf(j)= norm(centroid(j,:)-pixels(i,:));
%     end
%           [val ind]= min(distf);
%           class(i)= ind;
% end
IDX = knnsearch(centroid,pixels,'distance','euclidean');
    %disp(IDX);
    class=IDX';
%calculating median
total_sum= zeros(K,3);
total_size= zeros(K,1);
for i=1:size(pixels,1)
    
        total_sum(class(i),:)=total_sum(class(i),:)+ pixels(i,:);
        total_size(class(i))= total_size(class(i))+1;
 end
%   for i=1:K
%          
%         centroid1(i,:)=total_sum(i,:)/total_size(i);
%   end  
     a= bsxfun(@rdivide,total_sum' ,total_size');
   centroid1=a';
end
%disp(centroid1);
centroid=centroid1;
class=class';


%disp(class);
%disp pixels;
%[class, centroid] = [0,0]
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

 % [class, centroid] = kmeans(pixels, K);
% fclose(fileID);
end

