FROM nvcr.io/nvidia/pytorch:21.08-py3

# Turn off questions while installing packages
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update  \
    && apt-get -y remove --auto-remove python-jinja2 \
    && apt-get -y install inotify-tools awscli \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# pip errors on flask install unless we specify jinja2 version like this
RUN pip install --no-cache-dir --upgrade "jupyterlab>=3.2.1" dominate yattag visdom plotly pytest-xdist seaborn rasterio geopandas deepdiff black boto3 backoff "jinja2>=3.0.0" pandera schema
RUN pip install --no-cache-dir natsort tabview scikit-optimize virtualenv pyaml  filelock backports.entry-points-selectable "distlib<1,>=0.3.1" pyspark
RUN pip install --no-cache-dir --no-dependencies "guildai==0.7.4"