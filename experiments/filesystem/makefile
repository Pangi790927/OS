NAME := filesystem
CXX := g++-7
LIBS := 
INCLUDE :=
OBJS := 

all: $(NAME)

$(NAME):%:%.cpp
	$(CXX) $(CXX_FLAGS) $(LIBS) $(INCLUDE) $(OBJS) $(LIBS) $^ -o $@

clean:
	rm -f $(NAME)