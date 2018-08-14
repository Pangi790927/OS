NAME := filesystem
CXX := g++-7
LIBS := 
INCLUDE :=
OBJS := 

all: $(NAME)

$(NAME):%:%.cpp
	$(CXX) $(CXX_FLAGS) $(LIBS) $(INCLUDE) $(OBJS) $(LIBS) $^ -o $@

superblock.ext2:
	dd if=/dev/zero of=superblock.ext2  bs=1K  count=1

clean:
	rm -f $(NAME)
