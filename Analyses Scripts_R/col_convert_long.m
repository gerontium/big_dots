% col_convert_long() - create long format of multidimensional matrix for
%                      use in R. writes excel file and creates matrix also.
%                      Must be SUBJECTS x Z1 x ... Zn factor matrix
% Usage:
%    >> final_col = col_convert_long(orig_col,outputfile)
% 
% Inputs:
%   orig_col      = multidimensional matrix with z1 x z2 x ... zn factors
% 
% Optional inputs:
%   outputfile    = filename for xls file. otherwise called final_col.xls
% 
% Copyright (C) 04/07/2016 Ger Loughnane

function final_col = col_convert_long(varargin)

if nargin==1
    outputfile = 'final_col.xls';
else
    outputfile = varargin{2};
end
orig_col = varargin{1};
% % tester
% orig_col = ones(50,3,4,6);

% get relevant aspects of matrix
mat_size = size(orig_col);
mat_dim = length(mat_size);
mat_multi = cumprod(mat_size);
mat_multi2 = [1,cumprod(mat_size(2:end))];

% create subject ID column
IDs = repmat([1:size(orig_col,1)]',[mat_multi(end)/size(orig_col,1),1]);

% create factor columns
fac = [];
for i = 2:mat_dim
    fac_temp = [];
    for k = 1:mat_size(i)
        fac_temp = [fac_temp;ones(size(orig_col,1)*mat_multi2(i-1),1)*k];
    end
    fac_temp = repmat(fac_temp,[length(IDs)/(size(orig_col,1)*mat_multi2(i)),1]);
    fac(:,i-1) = fac_temp;
end

% create dv column
dvs = reshape(orig_col,[mat_multi(end),1]);

% concatenate
final_col = [IDs,fac,dvs];

% add names for columns
names = {'IDs'};
for i = 1:mat_dim-1
    names = [names,['Factor_',num2str(i)]];
end
names = [names,'DVs'];

% get rid of previous outputfile
if exist(outputfile, 'file');
  delete(outputfile);
end

% write excel file
xlswrite(outputfile,[names;num2cell(final_col)]);