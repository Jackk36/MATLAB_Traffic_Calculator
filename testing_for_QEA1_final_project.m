
clear;

function[found_roads] = calcRoads()

% function starts here

num_roads = input("how many roads are in the picture?:  ");
all_roads = sym("f",[1 num_roads]);
% ask user how many intersections they have
num_intersections = input("Mentally label each intersection with a number (1-n). How many intersections are in the picture?:  ");
ins = cell(num_intersections,1); % list of roads flowing towards/into a intersection
outs = cell(num_intersections,1); % list of roads flowing out of an intersection
% for each intersection, ask them which roads are flowing 
% into the intersection vs out of the intersection
for i=1:num_intersections
    towards_intersection_indices = input("name roads going into/towards intersection " + i + " in a row vector (ex. [1, 2]):")
    away_from_intersection_indices = input("name roads going away intersection " + i + " in a row vector (ex. [10]):")
    % add this to cell array
    ins{i,1} = towards_intersection_indices;
    outs{i,1} = away_from_intersection_indices;
end
% asks user to declare the stated number of cars in each road that they
% know the number of cars for
known_roads = input("put index of roads with known amounts of cars in the first row of a matrix, number of cars in second row of a matrix (ex. [3, 4; 2, 5]): ")
num_unknown_roads = 10-length(known_roads) % find out how many unknown roads there are
unknown_roads = input("put index of roads with unknown amounts of cars in a vector (ex. [3, 4; 2, 5]): ") % find index of unknown road
unknown_roads = cat(1, unknown_roads, zeros(1,length(unknown_roads)))





% set known variables in terms of unknowns at index i
% for each intersection
A = zeros(length(outs),length(unknown_roads))  % intersections x number of unknown road flows
b = zeros(length(outs),1) % intersections x 1
for j =1:length(outs) % for each intersection
in_of_j = cell2mat(ins(1,j)) 
out_of_j = cell2mat(outs(1,j))
% unknown 
for i = 1:length(unknown_roads) % for each unknown road
    if any(in_of_j == unknown_roads(2,i))
        A(j,i) = 1 % goes in the intersection= 1
    end
    if any(out_of_j == unknown_roads(2,i))
        A(j,i) = -1 % goes out the intersection = -1
    end
end
for i =1:length(known_roads)
    if any(known_roads(2,i) == in_of_j)
        b(j,1) = b(j,1)-known_roads(1,i) % subtract the known value of a road flowing in
    else if any(known_roads(2,i) == out_of_j)
        b(j,1) = b(j,1)+known_roads(1,i) % subtract the known value of a road flowing out
    end
    end
end


end

found_roads = A\b
end

% see image in readme file for a test case
calcRoads()



