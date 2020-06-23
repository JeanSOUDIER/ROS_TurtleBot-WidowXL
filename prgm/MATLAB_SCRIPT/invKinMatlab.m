load exampleRobots.mat;
showdetails(puma1);
randConfig = puma1.randomConfiguration;
tform = getTransform(puma1,randConfig,'L6','base');

show(puma1,randConfig);

ik = inverseKinematics('RigidBodyTree',puma1);
weights = [0.25 0.25 0.25 1 1 1];
initialguess = puma1.homeConfiguration;
%rigidbodytree = rigidBody('RigidBodyTree');
%ik = inverseKinematics('RigidBodyTree',rigidbodytree);
