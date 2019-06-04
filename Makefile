CXX=g++
all: main.cpp
	$(CXX) -std=c++17 -O3 main.cpp -o main 

d: main.cpp
	$(CXX) -std=c++17 -DDEBUG main.cpp -o main 

c:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard

debug: main.cpp
	$(CXX) -std=c++17 -DDEBUG main.cpp -o main 

copy:
	cat main.cpp | xclip -selection clipboard

cp:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard
	#cat main.cpp | xclip -selection clipboard
