function [predict_value,predict_error]=xulie(data,n)
            y = data;
            m = length(y);
            yhat = zeros(1, m-n+1);
            for j = 1:m-n+1
                yhat(j)=sum(y(j:j+n-1))/n;                 
            end            
            predict_value = yhat(end); 
            predict_error = sqrt(mean((y(n+1:m)-yhat(1:end-1)).^2));
            %app.NALabel.Text = num2str(app.predict_value);
            %app.NALabel_2.Text = num2str(app.predict_error); 