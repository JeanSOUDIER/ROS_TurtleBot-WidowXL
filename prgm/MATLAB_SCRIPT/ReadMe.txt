Ce programme Matlab pilote un turtlebot3 waffle pi avec un bras Widow XL de Arbotis monté dessus
Il utilise l'interface ROS pour le turtlebot via le toolbox ROS de Matlab,
la caméra et le bras (en USB) sont pilotés via la Raspberry pi toolbox de Matlab.
La Raspberry pi est un modèle 3B v1.2 de 2015 et la version de Matlab est 2018a.

Le programme Main détecte un objet et donne des consignes au robot pour aller le chercher et le ramener
au point de départ.

Les programmes de démarrages sont :
 - FastLaunch.m
 - Start.m

Les programmes de visions sont :
 - GetObject.m
 - TakePhoto.m
 - TryGetObject.m

Les programmes de création du terrain virtuel sont :
 - AddLidarPoints.m
 - AdjustLidarPoints.m
 - AdjustMap.m
 - DiscoverMap.m
 - TakeLidarScan.m
 - TakeOdom.m

Les programmes de gestion de déplacement du robot sont :
 - Go.m
 - AdjustOrientation.m
 - Find.m
 - PathFinding.m

Les programmes de gestion du bras au niveau matériel sont :
 - CastPos.m
 - CastTime.m
 - MoveAllMot.m
 - SendArm.m
 - SetNbMot.m

Les programmes de gestion avancée du bras sont :
 - ComputeDistCam.m
 - ComputeDistCamArm.m
 - Homing.m
 - MoveArmAll.m
 - PosArmToMove.m
 - PosArmToSee.m

Les programmes de dessin (lié au bras) sont :
 - circle.m
 - linePol.m
 - point.m

Les programmes de démonstrastion sont :
 - main.m
 - demoArm.m
 - demoPathfind.m
