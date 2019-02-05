FROM ubuntu:18.10

# Install dependecies
RUN apt-get update && apt-get install -y \
  gcc \
  make \
  rustc \
  cargo \
  automake \
  autoconf \
  libtool \
  gettext \
  itstool \
  libgdk-pixbuf2.0-dev \
  libgirepository1.0-dev \
  gtk-doc-tools \
  git \
  libgtk-3-dev \
  libxml2-dev \
  libcroco3-dev \
  libcairo2-dev \
  libpango1.0-dev \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory to /app for downloading librsvg src
WORKDIR /app

# Get tarball and extract
RUN curl -L https://github.com/GNOME/librsvg/archive/2.44.12.tar.gz -o librsvg-2.44.12.tar.gz \
  && tar -xvzf librsvg-2.44.12.tar.gz

# Set the working directory to librsvg folder for compiling
WORKDIR /app/librsvg-2.44.12

# Compile rsvg
RUN PATH="$PATH:/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0" ./autogen.sh \
  && make \
  && make install

# Return to main app directory and remove librsvg source
WORKDIR /app
RUN \rm -rf librsvg-2.44.12

# Run rsvg-convert when the container launches
ENTRYPOINT ["rsvg-convert"]
CMD ["--help"]
