function[W,C] = voteperceptron(data,label,epoc,w) %<----data set,label,epoc_number,eta value,intial weight vector
C=[];
c=1;
W =[];
for i=1:epoc
  li = 1;
  for di  = data
    %di
    if ((w'*di)*label(li)<=0)
      W = [W,w];
      C = [C,c];
      w = w + di*label(li);
      c=1;
    else
      c = c+1;
    end
    li = li+1;
  end
  %W = [W,w];
  %C = [C,c];
end
