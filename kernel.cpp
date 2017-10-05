

int main() {
	int row = 5;
	int col = 0;

	char *video_memory = (char *) 0xb8000;

	video_memory[(row * 80 + col) * 2 + 0] = 'X';
	video_memory[(row * 80 + col) * 2 + 1] = 0x0f;
}