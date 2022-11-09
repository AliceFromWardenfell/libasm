NAME		:= libasm.a

CC			:= c++
CFLAGS		:= -Wall -Wextra -Werror
DEP_FLAGS	:= -MP -MMD

SRCS_DIR	:= sources
HDRS_DIR	:= headers
vpath %.cpp	$(SRCS_DIR)
vpath %.hpp	$(HDRS_DIR)
INCLUDES	:= -I$(HDRS_DIR)

SRCS		:=	main.cpp \
				test_utils.cpp \
				timer.class.cpp \
				vector.test.cpp

OBJS_DIR	:= .objects
OBJS		:= $(SRCS:%.cpp=$(OBJS_DIR)/$(OBJ_PREFIX)%.o)
DEPS		:= $(SRCS:%.cpp=$(OBJS_DIR)/$(OBJ_PREFIX)%.d)

all:
					@echo "$(BOLD)Creating/updating $(WHITE_B)'$(NAME)'$(BOLD):$(DEF)"
					@$(MAKE) --no-print-directory $(NAME)

$(NAME):			$(OBJS)
					@echo "$(BOLD)Linking files...$(DEF)"
					@$(CC) $(OBJS) $(CFLAGS) $(INCLUDES) -o $@
					@echo "$(WHITE_B)'$(NAME)'$(BOLD) has been created/updated.$(DEF)"

$(OBJS_DIR)/%.o:	%.cpp | $(OBJS_DIR)
					@echo "Assembling $<..."
					@$(CC) $(CFLAGS) $(DEP_FLAGS) $(INCLUDES) -c $< -o $@

$(OBJS_DIR):
					@mkdir -p $@
					@echo "$(BOLD)Directory '$(OBJS_DIR)' has been created.$(DEF)"

clean:
					@rm -rf $(OBJS) $(DEPS) $(OBJS_DIR)
					@echo "$(WHITE)$(NAME): $(BOLD)Object files have been cleaned.$(DEF)"

fclean:				clean
					@rm -rf $(NAME) $(NAME_STL)
					@echo "$(WHITE)'$(NAME)'$(BOLD) has been cleaned.$(DEF)"

re:					fclean all

.PHONY:				all clean fclean re

-include $(DEPS)

BOLD	:= \033[0;1m
WHITE_B	:= \033[1;37m
WHITE	:= \033[37m
DEF		:= \033[0;39m
