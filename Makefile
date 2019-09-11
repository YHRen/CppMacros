CXX=g++
all: main.cpp
	$(CXX) -std=c++17 -O3 main.cpp -o main 

d: main.cpp
	$(CXX) -std=c++17 -DDEBUG main.cpp -o main 

c:
	$(MAKE) xclip_way || $(MAKE) clip_exe_way

xclip_way:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard

clip_exe_way:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | clip.exe 

debug: main.cpp
	$(CXX) -std=c++17 -DDEBUG main.cpp -o main 

copy:
	cat main.cpp | xclip -selection clipboard

cp:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard
	#cat main.cpp | xclip -selection clipboard
