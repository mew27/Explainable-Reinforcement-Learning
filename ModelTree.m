classdef ModelTree
    %UNTITLED Model tree class
    %   Particular kind of decision tree where each leaf
    %   contains a linear regression model.
    
    properties
        coeff
        intercept
        index
        threshold
    end
    
    methods
        function obj = ModelTree(coeff, intercept, index, threshold)
            obj.coeff = coeff;
            obj.intercept = intercept;
            obj.index = index;
            obj.threshold = threshold;
        end
        
        function prediction = predict(obj, features)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            i = 1;
            [~, idx] = sort(obj.index(:, 1));
            
            while obj.threshold(idx(i), 1) ~= 0
                
                if features(obj.threshold(idx(i), 1)) <= obj.threshold(idx(i), 2)
                    i = obj.index(idx(i), 2);
                else
                    i = obj.index(idx(i), 3);
                end
            end
            
            prediction = features * obj.coeff(idx(i), :)' + obj.intercept(idx(i));
        end
    end
end

