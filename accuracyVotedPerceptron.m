function [accuracy ] = accuracyVotedPerceptron (W,C,label,testData)
  accuracy = 0.0;
  %PM = prediction(P,Q,testData);
  PM =[]; %<---prediction matrix...
  for td = testData
     prediction = 0;
     i = 1;
     for p = W
        if(p'*td <= 0)
            sign = -1;
        else
             sign = 1;
        end
        prediction = prediction + sign*C(i);
        i = i+1;
      end
      if(prediction < 0)
         prediction = -1;
      else
         prediction = 1;
      end
     PM = [PM ,prediction];     
  end
  
  for i = 1:length(PM)
    if(PM(i)*label(i)>0)
      accuracy = accuracy + 1;
    end
  end
  accuracy = accuracy/length(PM);
end
