//ruiz mejia eugenio alejandro
//zetina martinez enrique

#include <dirent.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Utiliza mismo espacio de memoria para diferentes datos
union block {
  uint64_t sixfour[8];
  uint32_t threetwo[16];
  uint8_t eight[64];
  uint8_t eight_pad[64];
};

// Contexto MD5
typedef struct {
  uint32_t state[4];
} MD5_CTX;

//Declaracion de funciones MD5
void md5_init(MD5_CTX *md5_ctx);
FILE *md5_hash(MD5_CTX *md5_ctx, union block *B, char *file);

//Valores predefinidos para vueltas 1-4
const uint32_t K[64] = {
  0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
  0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
  0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
  0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
  0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
  0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
  0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
  0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
  0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
  0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
  0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
  0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
  0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
  0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
  0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
  0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391};

//macro directiva de procesador para corrimiento-rotacion
#define ROTLEFT(x, c) ((x << c) | (x >> (32 - c)))

//Definicion de funciones bit a bit
#define F(x, y, z) ((x & y) | (~x & z))
#define G(x, y, z) ((x & z) | (y & ~z))
#define H(x, y, z) (x ^ y ^ z)
#define I(x, y, z) (y ^ (x | ~z))

//Definicion de funciones para cambio de bits para vueltas 1-4
#define FF(a, b, c, d, m, s, t) { a += F(b, c, d) + m + t;  a = b + ROTLEFT(a, s); }
#define GG(a, b, c, d, m, s, t) { a += G(b, c, d) + m + t;  a = b + ROTLEFT(a, s); }
#define HH(a, b, c, d, m, s, t) { a += H(b, c, d) + m + t;  a = b + ROTLEFT(a, s); }
#define II(a, b, c, d, m, s, t) { a += I(b, c, d) + m + t;  a = b + ROTLEFT(a, s); }

//Constantes para corrimiento de bits
#define S7 7
#define S12 12
#define S17 17
#define S22 22
#define S5 5
#define S9 9
#define S14 14
#define S20 20
#define S4 4
#define S11 11
#define S16 16
#define S23 23
#define S6 6
#define S10 10
#define S15 15
#define S21 21
#define LongArch 128 //nombre del archivo 128 caracteres

// Bits para llenado manual padding
const uint8_t ZEROBIT = 0x00;
const uint8_t ONEBIT = 0x80;
const int FIVETWELVE_BITS = 512;

// Inicializa operaciones MD5
void md5_init(MD5_CTX *md5_ctx) {
  // Carga valores de inicialización
  md5_ctx -> state[0] = 0x67452301;
  md5_ctx -> state[1] = 0xefcdab89;
  md5_ctx -> state[2] = 0x98badcfe;
  md5_ctx -> state[3] = 0x10325476;
}

// Realiza el digest del mensaje
FILE *md5_hash(MD5_CTX *md5_ctx, union block *B, char *file) {
  // Puntero a archivo
  FILE *fptr;

  // Almacena valores previos de hash
  uint32_t a, b, c, d;
  uint64_t counter = 0;
  size_t size;
  
  bool keepAlive = true, paddingRequired = false;
  int i;
  
  // Asigna valores iniciales 
  a = md5_ctx -> state[0];
  b = md5_ctx -> state[1];
  c = md5_ctx -> state[2];
  d = md5_ctx -> state[3];

  // Abre el archivo
  fptr = fopen(file, "r");

  // Padding
  while (keepAlive) {
    size = fread(&B -> eight, 1, 64, fptr);

    /**
     * Padding operations
     * 
     * 1. If size is equal to 64, continue - no padding needed
     * 2. If size is greater than 56 and less than 64, not enough space for 64 bits at end of file
     * 3. If size is less than 56 and greater than 0, pad file at the end
     * 4. If size is equal to 0 and pad is equal to 0, end of file - file was a size of multiple 64
     * 5. If size is equal to 0 and pad is equal to 1, end of file - padding started in previous block, pad file with all zeros
     */ 
    if (size == 64) {
      counter += FIVETWELVE_BITS;
    } else if (size < 64 && size > 56) {
      //Actualiza contador a tamaño actual * 8 
      counter += (size * 8);

      // Pad out to end of block
      B -> eight_pad[size] = ONEBIT;

      for (i = size + 1; i < 64; i++) {
        B -> eight_pad[i] = ZEROBIT;
      }

      paddingRequired = true;
    } else if (size < 56 && size > 0) { 
      //Actualiza contador a tamaño actual * 8  
      counter += (size * 8);

      // Pad a final de bloque
      B -> eight_pad[size] = ONEBIT;

      for (i = size + 1; i < 56; i++) {
        B -> eight_pad[i] = ZEROBIT;
      }

      B -> sixfour[7] = counter;

      // Exit while loop
      keepAlive = false;
    } else if (size == 0 && paddingRequired == true) {
      B -> eight_pad[0] = ONEBIT;

      for(i = 1; i < 56; i++) {
        B -> eight_pad[i] = ZEROBIT;
      }

      B -> sixfour[7] = counter;

      // Salir ciclo
      keepAlive = false;
    } else if (size == 0) {
      B -> eight_pad[0]=ZEROBIT;

      for(i = 1; i < 56; i++) {
        B -> eight_pad[i] = ZEROBIT;
      }

      B -> sixfour[7] = counter;

      // Salir ciclo
      keepAlive = false;
    }
    
//Vueltas
    // Round 1 - FF 
    FF(a, b, c, d, B -> threetwo[0], S7, K[0]);
    FF(d, a, b, c, B -> threetwo[1], S12, K[1]);
    FF(c, d, a, b, B -> threetwo[2], S17, K[2]);
    FF(b, c, d, a, B -> threetwo[3], S22, K[3]);
    FF(a, b, c, d, B -> threetwo[4], S7, K[4]);
    FF(d, a, b, c, B -> threetwo[5], S12, K[5]);
    FF(c, d, a, b, B -> threetwo[6], S17, K[6]);
    FF(b, c, d, a, B -> threetwo[7], S22, K[7]);
    FF(a, b, c, d, B -> threetwo[8], S7, K[8]);
    FF(d, a, b, c, B -> threetwo[9], S12, K[9]);
    FF(c, d, a, b, B -> threetwo[10], S17, K[10]);
    FF(b, c, d, a, B -> threetwo[11], S22, K[11]);
    FF(a, b, c, d, B -> threetwo[12], S7, K[12]);
    FF(d, a, b, c, B -> threetwo[13], S12, K[13]);
    FF(c, d, a, b, B -> threetwo[14], S17, K[14]);
    FF(b, c, d, a, B -> threetwo[15], S22, K[15]);

    //Round 2 - GG 
    GG(a, b, c, d, B -> threetwo[1], S5, K[16]);
    GG(d, a, b, c, B -> threetwo[6], S9, K[17]);
    GG(c, d, a, b, B -> threetwo[11], S14, K[18]);
    GG(b, c, d, a, B -> threetwo[0], S20, K[19]);
    GG(a, b, c, d, B -> threetwo[5], S5, K[20]);
    GG(d, a, b, c, B -> threetwo[10], S9, K[21]);
    GG(c, d, a, b, B -> threetwo[15], S14, K[22]);
    GG(b, c, d, a, B -> threetwo[4], S20, K[23]);
    GG(a, b, c, d, B -> threetwo[9], S5, K[24]);
    GG(d, a, b, c, B -> threetwo[14], S9, K[25]);
    GG(c, d, a, b, B -> threetwo[3], S14, K[26]);
    GG(b, c, d, a, B -> threetwo[8], S20, K[27]);
    GG(a, b, c, d, B -> threetwo[13], S5, K[28]);
    GG(d, a, b, c, B -> threetwo[2], S9, K[29]);
    GG(c, d, a, b, B -> threetwo[7], S14, K[30]);
    GG(b, c, d, a, B -> threetwo[12], S20, K[31]);

    // Round 3 - HH function
    HH(a, b, c, d, B -> threetwo[5], S4, K[32]);
    HH(d, a, b, c, B -> threetwo[8], S11, K[33]);
    HH(c, d, a, b, B -> threetwo[11], S16, K[34]);
    HH(b, c, d, a, B -> threetwo[14], S23, K[35]);
    HH(a, b, c, d, B -> threetwo[1], S4, K[36]);
    HH(d, a, b, c, B -> threetwo[4], S11, K[37]);
    HH(c, d, a, b, B -> threetwo[7], S16, K[38]);
    HH(b, c, d, a, B -> threetwo[10], S23, K[39]);
    HH(a, b, c, d, B -> threetwo[13], S4, K[40]);
    HH(d, a, b, c, B -> threetwo[0], S11, K[41]);
    HH(c, d, a, b, B -> threetwo[3], S16, K[42]);
    HH(b, c, d, a, B -> threetwo[6], S23, K[43]);
    HH(a, b, c, d, B -> threetwo[9], S4, K[44]);
    HH(d, a, b, c, B -> threetwo[12], S11, K[45]);
    HH(c, d, a, b, B -> threetwo[15], S16, K[46]);
    HH(b, c, d, a, B -> threetwo[2], S23, K[47]);

    // Round 4 - II function
    II(a, b, c, d, B -> threetwo[0], S6, K[48]);
    II(d, a, b, c, B -> threetwo[7], S10, K[49]);
    II(c, d, a, b, B -> threetwo[14], S15, K[50]);
    II(b, c, d, a, B -> threetwo[5], S21, K[51]);
    II(a, b, c, d, B -> threetwo[12], S6, K[52]);
    II(d, a, b, c, B -> threetwo[3], S10, K[53]);
    II(c, d, a, b, B -> threetwo[10], S15, K[54]);
    II(b, c, d, a, B -> threetwo[1], S21, K[55]);
    II(a, b, c, d, B -> threetwo[8], S6, K[56]);
    II(d, a, b, c, B -> threetwo[15], S10, K[57]);
    II(c, d, a, b, B -> threetwo[6], S15, K[58]);
    II(b, c, d, a, B -> threetwo[13], S21, K[59]);
    II(a, b, c, d, B -> threetwo[4], S6, K[60]);
    II(d, a, b, c, B -> threetwo[11], S10, K[61]);
    II(c, d, a, b, B -> threetwo[2], S15, K[62]);
    II(c, d, a, b, B -> threetwo[2], S15, K[62]);
    II(b, c, d, a, B -> threetwo[9], S21, K[63]);
    
    // Actualiza despues de ciclos
    md5_ctx -> state[0] += a;
    md5_ctx -> state[1] += b;
    md5_ctx -> state[2] += c;
    md5_ctx -> state[3] += d;

    // Actualiza a valores finales
    for(int i = 0, j = 0; i < 4; i++, j += 4) {
      B -> threetwo[j] = (B -> eight[i] & 0xFF);
      B -> threetwo[j + 1] = ((B -> eight[i]) >> 8 & 0xFF);
      B -> threetwo[j + 2] = ((B -> eight[i]) >> 16 & 0xFF);
      B -> threetwo[j + 3] = ((B -> eight[i]) >> 24 & 0xFF);
    }
  }
}

int main(int argc, char **argv) {
  FILE *file = NULL; // Puntero a archivo en direccion de memoria
  MD5_CTX md5_ctx_val; // Contexto
  union block B; // Union block
  int i;
  char file_name[LongArch] = {0};

  printf("\nTarea MD5 \n");
        printf("Ingrese nombre de archivo con extension: ");
        if (scanf ("%127s%*c", file_name) != 1) { //verif existencia de archivo
          fprintf (stderr, "Ingrese nombre de archivo correctamente");
          return 1;
        }
        
        // Hash 
        md5_init(&md5_ctx_val);
        printf("Hash md5: ");

        file = md5_hash(&md5_ctx_val, &B, file_name);

        // imprimir md5
        for(i = 0; i < 4; i++) {
          printf("%02x", (md5_ctx_val.state[i] >> 0 ) & 0x000000ff);
          printf("%02x", (md5_ctx_val.state[i] >> 8) & 0x000000ff);
          printf("%02x", (md5_ctx_val.state[i] >> 16) & 0x000000ff); 
          printf("%02x", (md5_ctx_val.state[i] >> 24) & 0x000000ff);
        }
  return 0; 
}
