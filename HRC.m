%HYBRID RING COUPLER SIMULATION WITHOUT USING TOOLBOXES

%CALCULATING IMPEDANCES
split = input("Enter 1 for equal split, 2 for unequal split");
z = input('Enter the port impedance');
if split == 1
    z0 = z.*sqrt(2);
    output = strcat('The characteristic impedance of the coupler is ',string(z0),' ohm.\n');
end
if split == 2
    p_split = input('Enter the power splitting ratio');
    z0a = z.*sqrt(1+p_split);
    z0b = z.*sqrt(1+p_split^(-1));
    output = strcat('The impedance of segments between ports 1-2 and 3-4 (Z0a) is  ',string(z0a),' ohm while that of segments 2-3 and 1-4 (Z0b) is  ',string(z0b),' ohm. \n');
end
fprintf(output);

%FINDING THE LENGTH OF SEGMENTS
mu = input("Choose the frequency in GHz");
c = 0.3;
lambda_mm = (c./mu)*1000;
l1 = lambda_mm/4;
l2 = 3*l1;
output = strcat('The spacing between the ports is ',string(l1),' mm and the circumference of the other half is ', string(l2), ' mm. \n');
fprintf(output);

%PARAMETERS OF HYBRID RING
if split == 1
    S_matrix = -1i/sqrt(2).*[0 1 0 -1; 1 0 1 0; 0 1 0 1; -1 0 1 0];
end
if split == 2
    S_matrix = 1i.*[0 -z/z0a 0 z/z0b;-z/z0a 0 -z/z0b 0; 0 -z/z0b 0 -z/z0a; z/z0b 0 -z/z0a 0];
end
disp(S_matrix);
fprintf('Reflection loss at each port is 0, as seen from the S matrix \n');
iso = [];
for i = 1:4
    for j = 1:4
        if i ~= j
            isolation = abs(S_matrix(i,j));
            iso = [iso isolation];
        end
    end
end
fprintf('The isolation between each pair of ports is: \n');
disp(iso);
