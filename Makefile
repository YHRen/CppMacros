CXX=g++
all: main.cpp
	$(CXX) -std=c++14 -O3 main.cpp -o main 

debug: main.cpp
	$(CXX) -std=c++14 -DDEBUG main.cpp -o main 

copy:
	cat main.cpp | pbcopy

cp:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard
	#cat main.cpp | xclip -selection clipboard


