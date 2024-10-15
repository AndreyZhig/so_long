#!/bin/bash

# Set the path for MLX
MLX_PATH="./mlx"

# Create the directory for MLX if it doesn't exist
mkdir -p $MLX_PATH

# Clone the MLX42 repository from GitHub
git clone https://github.com/codam-coding-college/MLX42.git $MLX_PATH

# Navigate to the mlx directory
cd $MLX_PATH

# Build the library
cmake -B build && cmake --build build --parallel --config (Debug|Release|RelWithDebInfo|MinSizeRel) --target install
cmake -B build # build here refers to the outputfolder.
cmake --build build -j4 # or do make -C build -j4
# Inform the user
echo "MLX42 library has been successfully installed!"

