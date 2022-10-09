CXX=g++
all: main.cpp
	$(CXX) -std=c++17 -O3 main.cpp -o main 

d: main.cpp
	$(CXX) -std=c++17  -fsanitize=address -D_LIBCPP_DEBUG=1 -DDEBUG main.cpp -o main 

c:
	$(MAKE) xclip_way || $(MAKE) clip_exe_way || $(MAKE) clip_mac_way

xclip_way:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | xclip -selection clipboard

clip_exe_way:
	grep -B 10000 -e '^int main(' main.cpp | head -n -1 | clip.exe 

clip_mac_way:
	sed -n -e "/^#include*/,/^};/ p" main.cpp | pbcopy

debug: main.cpp
	$(CXX) -std=c++17 -DDEBUG main.cpp -o main 

cp:
	$(MAKE) x_copy || $(MAKE) mac_copy

x_copy:
	cat main.cpp | xclip -selection clipboard 

mac_copy:
	cat main.cpp | pbcopy

