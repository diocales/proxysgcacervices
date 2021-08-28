…or create a new repository on the command line
echo "# proxysgcacervices" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
##HTTPS
git remote add origin https://github.com/diocales/proxysgcacervices.git
##OR SSH  
##git remote add origin git@github.com:diocales/proxysgcacervices.git

git push -u origin main


…or push an existing repository from the command line
git remote add origin https://github.com/diocales/proxysgcacervices.git
git branch -M main
git push -u origin main