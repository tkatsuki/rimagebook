CXX = g++
CXXFLAGS = -O2 -fPIC
LINK = g++
AR = ar
CONFIG = Release
SRCS = MedianFilter.cpp SpatialFilter.cpp
OBJS := $(SRCS:%.cpp=%.o)
OBJS := $(addprefix $(CONFIG)/,$(OBJS))

../$(CONFIG)/ImageFilter.a : ../$(CONFIG) $(CONFIG) $(OBJS)
	$(AR) rcs $@ $(OBJS)
$(CONFIG)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
$(CONFIG):
	mkdir $(CONFIG)
../$(CONFIG):
	mkdir ../$(CONFIG)
clean:
	rm -f $(OBJS)

