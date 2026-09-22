CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -O2 $(shell sdl2-config --cflags)
LDFLAGS  := $(shell sdl2-config --libs)

SRC_DIR  := src
BUILD_DIR := build
TARGET   := chip8

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Uso: make run ROM=caminho/para/rom.ch8 SCALE=10 DELAY=3
run: $(TARGET)
	./$(TARGET) $(or $(SCALE),10) $(or $(DELAY),3) $(ROM)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)
