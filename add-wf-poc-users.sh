echo "  - adding management user 'eapAdmin' with password 'redhateap1!'..."
echo
$EAP_HOME/bin/add-user.sh -r ManagementRealm -u eapAdmin -p redhateap1! -ro admin,manager,user,kie-server,kiemgmt,rest-all --silent

echo "  - adding user 'pamAdmin' with password 'redhatpam1!'..."
echo
$EAP_HOME/bin/add-user.sh -a -r ApplicationRealm -u pamAdmin -p redhatpam1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent

echo "  - adding user 'adminUser' with password 'test1234!'..."
echo
$EAP_HOME/bin/add-user.sh -a -r ApplicationRealm -u adminUser -p test1234! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent

echo "  - adding user 'kieserver' with password 'kieserver1!'..."
echo
$EAP_HOME/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server,rest-all --silent
