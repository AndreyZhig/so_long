# Имя создаваемого исполняемого файла
NAME = so_long

# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g

MLX_PATH = mlx/
LIBS = -L$(MLX_PATH)build -lMLX42 -lglfw -framework OpenGL -framework Cocoa
INCLUDES = -I$(MLX_PATH)include/MLX42 -I$(MLX_PATH)build

# Target to install Homebrew and dependencies
install_brew:
	@if ! command -v brew &> /dev/null; then \
		echo "Homebrew not found. Installing..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@brew install glfw cmake

# Target to install MLX42 if not found
mlx42:
	@if [ ! -d "$(MLX_PATH)build" ]; then \
		echo "MLX42 not found, installing..."; \
		./install_mlx.sh; \
	fi

# Исходные файлы и объектные файлы
SRCS = main.c
OBJS = $(SRCS:.c=.o)

# Команда для удаления файлов
RM = rm -f

# Основная цель - сборка проекта
all: mlx42 $(NAME)

# Сборка исполняемого файла
$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(NAME)

# Правила для компиляции объектных файлов
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Цель для очистки объектных файлов
clean:
	$(RM) $(OBJS)

# Полная очистка (включая исполняемый файл)
fclean: clean
	$(RM) $(NAME)

# Пересборка проекта
re: fclean all

# Цель для запуска программы с файлом карты по умолчанию
run: all
	@./$(NAME) ./maps/map.ber

.PHONY: all clean fclean re run install_brew mlx42
