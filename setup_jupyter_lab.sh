# these commands need to be ran interactively

#=========================== JupyterLabs
sudo apt-get update; sudo apt install -y python3-pip; pip3 install --user jupyterlab;jupyter notebook --generate-config -y;
echo 'c.NotebookApp.password = "'$(python3 -c 'from IPython.lib import passwd; print(passwd())')\" > .jupyter/jupyter_notebook_config.py
#===========================
printf "c = get_config()\n# Kernel config\nc.IPKernelApp.pylab = 'inline'\n# Notebook config\nc.NotebookApp.ip = '0.0.0.0'\nc.NotebookApp.open_browser = False\n#Lastly instruct jupyter to run on port that we opened earlier in Step 9\nc.NotebookApp.port = 8001" >> .jupyter/jupyter_notebook_config.py
echo "screen -mdS jupyter_lab_serving bash -c 'jupyter lab'" > run_server.sh
bash run_server.sh
#===========================
screen -S jupyter_lab_serving -X quit
#=========================== NVTOP
sudo apt install -y cmake libncurses5-dev libncursesw5-dev git;
git clone https://github.com/Syllo/nvtop.git;
mkdir -p nvtop/build && cd nvtop/build;
cmake ..
cmake .. -DNVML_RETRIEVE_HEADER_ONLINE=True
make
sudo make install # You may need sufficient permission for that (root)
#===========================





#=========================== Generate Presigned URLs via python3's Boto
import boto3
bucket = 'BUCKET_NAME_HERE' # name of the s3 bucket
file_key = 'folder/subfolder/file.txt' # key including any folder paths
uri_duration = 2000000 #expiry duration in seconds. default 3600
s3Client = boto3.client('s3')
_uri = s3Client.generate_presigned_url('get_object', Params = {'Bucket': bucket, 'Key': file_key}, ExpiresIn = uri_duration)
context.updateVariable('s3_uri', _uri)

