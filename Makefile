NAME		:= libasm.a

CC			:= nasm
LINKER		:= ld
CCFLAGS		:= -f elf64
LFLAGS		:= 

SRCS_DIR	:= sources
HDRS_DIR	:= headers
vpath %.s	$(SRCS_DIR)
vpath %.h	$(HDRS_DIR)

SRCS		:=	hello_world.s

OBJS_DIR	:= .objects
OBJS		:= $(SRCS:%.s=$(OBJS_DIR)/%.o)

all:
					@echo "$(BOLD)Creating/updating $(WHITE_B)'$(NAME)'$(BOLD):$(DEF)"
					@$(MAKE) --no-print-directory $(NAME)

$(NAME):			$(OBJS)
					@echo "$(BOLD)Linking files...$(DEF)"
					@$(LINKER) $(OBJS) $(LFLAGS) -o $@
					@echo "$(WHITE_B)'$(NAME)'$(BOLD) has been created/updated.$(DEF)"

$(OBJS_DIR)/%.o:	%.s | $(OBJS_DIR)
					@echo "Assembling $<..."
					@$(CC) $(CCFLAGS) -o $@ $<

$(OBJS_DIR):
					@mkdir -p $@
					@echo "$(BOLD)Directory '$(OBJS_DIR)' has been created.$(DEF)"

clean:
					@rm -rf $(OBJS) $(OBJS_DIR)
					@echo "$(WHITE)$(NAME): $(BOLD)Object files have been cleaned.$(DEF)"

fclean:				clean
					@rm -rf $(NAME)
					@echo "$(WHITE)'$(NAME)'$(BOLD) has been cleaned.$(DEF)"

re:					fclean all

.PHONY:				all clean fclean re

BOLD	:= \033[0;1m
WHITE_B	:= \033[1;37m
WHITE	:= \033[37m
DEF		:= \033[0;39m
