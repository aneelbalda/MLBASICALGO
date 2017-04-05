function[w] = perceptron(data,label,epoc,eta,w) %<----data set,label,epoc_number,eta value,intial weight vector
for i=1:epoc
  li = 1;
  for di  = data
    %di
    if ((w'*di)*label(li)<=0)
      w = w + eta*di*label(li);
    end
    li = li+1;
  end
end

