#ifndef GAME_HPP
#define GAME_HPP

#include "Init.hpp"
#include <vector>
#include <iostream>
#include <allegro5/allegro.h>
#include <allegro5/allegro_font.h>

// Declaración externa de la función de ensamblador
extern "C" {
    int check_collision_arm(int x1, int y1, int w1, int h1,
                           int x2, int y2, int w2, int h2);
}

// Estructura para estrellas del fondo
struct Star {
    float x, y;
    int type;

    Star(float x, float y, int type) : x(x), y(y), type(type) {}
};

// Declaraciones forward para las estructuras
struct Bala;
struct personaje;
struct navesenemigas;

// Definición de tipos puntero
typedef Bala* ptr_bala;
typedef personaje* ptr_nave;
typedef navesenemigas* ptr_est;

class Game {
public:
    Game(ALLEGRO_FONT* font, int width, int height);
    ~Game();
    
    int run(SystemResources& sys);
    void draw() const;
    int getCurrentScore() const;

private:
    ALLEGRO_FONT* font;
    ALLEGRO_FONT* smallFont;
    int width, height;
    int currentScore;
    int highScore;
    bool gameOver;
    bool showExplosion;
    float explosionTimer;
    float gameOverTimer;
    float starSpeed;
    float speedMultiplier;
    float elapsedTime;
    ALLEGRO_BITMAP* explosionImg;
    ALLEGRO_BITMAP* livesSprite;
    std::vector<Star> stars;

    // Variables miembro (antes estáticas)
    int nivel;                    // Nivel actual del juego
    bool derecha;                 // Flag movimiento derecha
    bool izquierda;               // Flag movimiento izquierda
    double tiempoUltimoAtaque;    // Cronómetro para ataques

    // Listas (antes estáticas)
    ptr_bala Balas;               // Lista de balas
    ptr_est enemigos;            // Lista de enemigos
    ptr_nave nave;               // Nave del jugador

    // Array de imágenes de enemigos
    ALLEGRO_BITMAP* enemy_bitmaps[4];

    // Funciones privadas
    void dibujarenemigos() const;
    void dibujarnave() const;
    void dibujarbala() const;
    void crearnivel();
    void crearbala(int dy, int x, int y, SystemResources& sys);
    void colisiones(SystemResources& sys);
    void actualizarenemigos(SystemResources& sys);
    void actualizarbala(SystemResources& sys);
    void actualizarNave(SystemResources& sys);
    void crearnave();
    void generateStars();
    void update(SystemResources& sys);
    
    // Funciones de ayuda
    void agregaralfinal(ptr_est& lista, ptr_est Nuevo);
    void agregarBala(ptr_bala& lista, ptr_bala Nuevo);
    void limpiarbalas();
    void limpiarenemigos();
    bool puedeAtacar(ptr_est e);
};

#endif // GAME_HPP