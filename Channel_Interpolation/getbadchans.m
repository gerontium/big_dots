function [ID,badchans] = getbadchans(filename)

fid = fopen(filename);

s=0;
eof = false;
while 1
    A = fgetl(fid);
    if A==-1, break, end
    br = min(findstr('[',A));
    if isempty(br), error(['no square brackets on line ' num2str(s+1)]); end
    s=s+1;
    B = A(1:br-1);
    % get rid of non-alphanumeric characters:
    B(find(B<48))=[];
    ID{s} = B;
    badchans{s} = eval(A(br:end));
end
fclose(fid);
    