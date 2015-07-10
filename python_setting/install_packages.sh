# Install pip
sudo yum install -y python-devel gcc lapack lapack-devel blas blas-devel
# sudo python ez_setup.py
sudo easy_install pip
sudo pip install virtualenv

# Create working directories
virtualenv /home/ec2-user/svm_doc_pn || exit 1
cd /home/ec2-user/svm_doc_pn || exit 1
source bin/activate

# Install python libraries
pip install MySQL-python
pip install http://mecab.googlecode.com/files/mecab-python-0.996.tar.gz
pip install -U git+git://github.com/satomacoto/cabocha-python.git
pip install numpy
pip install scipy
pip install scikit-learn
pip install pandas
pip install mprpc
pip install setproctitle
