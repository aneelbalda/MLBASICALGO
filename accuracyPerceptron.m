function accuracy = accuracyPerceptron(W,testData,label)  %<----W weight vector, label = label of data, testData is data on which accuracy is checked
   accuracy = 0.0;
   li = 0 ;
   for td = testData
      li = li+1;
      if((W'*td)*label(li)>0)
        accuracy = accuracy+1;
      end
   end
   accuracy = accuracy/length(testData);
end