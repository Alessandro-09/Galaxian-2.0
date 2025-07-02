# Project settings
CXX := g++
AS := as
EXEC := main
SRC_DIR := src
INC_DIR := include
OBJ_DIR := obj

# Source files
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
ASMS := $(wildcard $(SRC_DIR)/*.s)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))
AOBJS := $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(ASMS))

# Compiler flags
CXXFLAGS := -Wall -std=c++17 -I$(INC_DIR)
ASFLAGS := -mfpu=neon -march=armv7-a
LDFLAGS := -lallegro -lallegro_font -lallegro_ttf -lallegro_primitives \
           -lallegro_image -lallegro_audio -lallegro_acodec -lallegro_dialog

# Default target
all: $(EXEC)

# Link the executable
$(EXEC): $(OBJS) $(AOBJS)
	$(CXX) $^ -o $@ $(LDFLAGS)

# Compile C++ source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile assembly files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(OBJ_DIR)
	$(AS) $(ASFLAGS) $< -o $@

# Run the executable
run: $(EXEC)
	./$(EXEC)

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(EXEC)

.PHONY: all clean run