### documentation of what I'm doing
# Task 1
Already have the programs folder

# Task 2
scroll down on github page to find linked 'releases page'
https://github.com/cli/cli/releases/tag/v2.87.2

link that just says 'GitHub CLI 2.87.2 linux amd64'
is same as what is linked and what I Want to download

commands for installing:

cd into programs folder in bora

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

tar -xzvf gh_2.74.2_linux_amd64.tar.gz 

### notably this is slightly ahead in terms of version as previous one, which is 2.74.0

# Task 3
making install_gh.sh script

first touch install_gh.sh

then nano install_gh.sh

type commands I used above, the wget, tar, then rm to remove the old .gz file

rm gh_2.74.2_linux_amd64.tar.gz

# Task 4

Can't yet execute due to no permissions

chmod +x install_gh.sh

does the trick

then execute using

./install_gh.sh

Actually it downloaded a ...gz.1 becuase I never removed the original. So, if I remove this .1, then should start running normally, so

rm gh_2.74.2_linux_amd64.tar.gz.1

works now and no tarballs left

# Task 5

Add location of gh binary to $PATH
### IDK how to do this, stopping here 2/22/2026