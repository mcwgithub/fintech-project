function historical_data = normalize_historical_data(raw_data, from, to)
% normalize_historical_data: Add missing entries in the given data and
% output the matrix with only datenum, opening price and closing price.
% Usage: data = normalize_historical_data(output, from, to)

% calculate duration
duration = to - from;

% instantiate duration x 3 matrix
historical_data = [ (from:to - 1)', zeros(duration, 2) ];
insert_index = 1;

for raw_index = 1:length(raw_data)
    date = datenum(raw_data(raw_index, 1), raw_data(raw_index, 2), raw_data(raw_index, 3));
    
    for data_index = insert_index:duration
        if historical_data(data_index, 1) == date
            historical_data(data_index, 2) = raw_data(raw_index, 4);   % 4th col is the closing price
            historical_data(data_index, 3) = raw_data(raw_index, 7);   % 7th col is the closing price
            insert_index = data_index + 1;
        end
    end
end

% fix all zeros. we cant fix the first one
for data_index = 2:duration
    % if the entry is missing the opening price, we take the previous entry's closing price as this entry's opening price
    if historical_data(data_index, 2) == 0
        historical_data(data_index, 2) = historical_data(data_index - 1, 3);
    end
    
    % if the entry is missing the closing price, we take the previous entry's opening price as this entry's closing price
    if historical_data(data_index, 3) == 0
        historical_data(data_index, 3) = historical_data(data_index - 1, 2);
    end
end
