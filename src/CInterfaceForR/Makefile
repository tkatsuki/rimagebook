CXX = g++
CXXFLAGS = -O2 -fPIC
LINK = g++
CONFIG = Release
SRCS = CInterfaceForR.cpp
OBJS := $(SRCS:%.cpp=%.o)
OBJS := $(addprefix $(CONFIG)/,$(OBJS))
LIBS := ../$(CONFIG)/ImageFilter.a
TARGET := ../$(CONFIG)/CInterfaceForR.so

$(TARGET) : ../$(CONFIG) $(CONFIG) $(OBJS) $(LIBS)
	$(LINK) -shared $(OBJS) -o $@ $(LIBS)
../$(CONFIG)/ImageFilter.a:
	cd ../ImageFilter; make
$(CONFIG)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
$(CONFIG):
	mkdir $(CONFIG)
../$(CONFIG):
	mkdir ../$(CONFIG)
clean:
	rm -f $(OBJS) $(TARGET)

