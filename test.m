test_variable = 5;

save('test.mat', 'test_variable')

/softlib/exe/x86_64/pkg/matlab/2018b/bin/matlab -r "run('test.m')"