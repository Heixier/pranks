# Still need to source, but least it works right

COMPILER ?= gcc
CFLAGS = -Wall

SRCS = $(addprefix $(ASCII-MATRIX_DIR)/, ascii-matrix.c)
OBJS = $(SRCS:.c=.o)

INSTALL_DIR = $(HOME)/.malware
ALIAS = matrix

ASCII-MATRIX_URL = "https://gitlab.com/christosangel/ascii-matrix.git"
ASCII-MATRIX_DIR = $(INSTALL_DIR)/ascii-matrix

NAME = $(INSTALL_DIR)/ascii_matrix

BASHRC = $(HOME)/.bashrc
ZSHRC = $(HOME)/.zshrc

MATRIX_FLAGS = -m1 grey
FULL_ALIAS = alias $(ALIAS)=\"$(NAME) $(MATRIX_FLAGS)\"

all: $(NAME)

$(SRCS): | $(ASCII-MATRIX_DIR)
$(OBJS): $(SRCS)

$(INSTALL_DIR):
	@mkdir -p $(INSTALL_DIR)

$(ASCII-MATRIX_DIR):
	@echo "Dodging bullets, please wait..."
	@git clone --quiet $(ASCII-MATRIX_URL) $(ASCII-MATRIX_DIR)

%.o: %.c
	@$(COMPILER) -c $(CFLAGS) $< -o $@

$(NAME): $(OBJS)
	@$(COMPILER) $(CFLAGS) $^ -o $@

clean:
	@rm -rf $(NAME) $(OBJS)

fclean: clean
	@rm -rf $(ASCII-MATRIX_DIR)
	sed -i '\|$(FULL_ALIAS)|d' $(BASHRC)
	sed -i '\|$(FULL_ALIAS)|d' $(ZSHRC)

$(BASHRC):
	@touch $(BASHRC)

$(ZSHRC):
	@touch $(ZSHRC)

install: $(NAME) $(INSTALL_DIR)
	@if ! grep -q "$(FULL_ALIAS)" $(BASHRC); then echo "$(FULL_ALIAS)" >> $(BASHRC); fi
	@if ! grep -q "$(FULL_ALIAS)" $(ZSHRC); then echo "$(FULL_ALIAS)" >> $(ZSHRC); fi

.PHONY: all clean fclean install
