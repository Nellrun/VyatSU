l = [0.45; 0.15; 0.25; 0.1; 0.2];
f = [
	0, 16, 10, 6, 0, 0, 0, 0, 6, 0;
	20, 0, 0, 10, 0, 0, 2, 0, 4, 0;
	20, 10, 0, 18, 0, 0, 0, 0, 0, 3;
	0, 20, 40, 0, 0, 20, 0, 8, 0, 6;
	0, 80, 0, 30, 0, 0, 8, 0, 0, 4
];

f1 = [
	0, 1, 1, 1, 0, 0, 0, 0, 1, 0;
	1, 0, 0, 1, 0, 0, 1, 0, 1, 0;
	1, 1, 0, 1, 0, 0, 0, 0, 0, 1;
	0, 1, 1, 0, 0, 1, 0, 1, 0, 1;
	0, 1, 0, 1, 0, 0, 1, 0, 0, 1
];

fileVolume = [0.5; 1; 1; 1.5; 1.5; 2; 2.5; 3.0; 2.5; 4];

l_s = sum(l)
printf('l_s = %f \n', sum(l))
disp('D is: '), disp(l' * f)
printf('sum(D) =  %f\n', sum(l' * f))

p = l' * f ./ sum(l' * f);
disp('P is: '), disp(p)

printf('summary volume =  %f\n', sum(fileVolume))
printf('m_нмл = %f\n', sum(fileVolume) / 1.25)
printf('m_нмд = %f\n', sum(fileVolume) / 0.25)

disp(f1 * fileVolume)