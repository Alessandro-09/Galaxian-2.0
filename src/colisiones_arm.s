/* colisiones_arm.s - Implementación en ARM AArch32 de detección de colisiones */

.syntax unified
.arch armv7-a
.fpu neon
.arm

.text
.align 4

/* Función: check_collision_arm
 * Parámetros:
 *   r0 - x1
 *   r1 - y1
 *   r2 - ancho1
 *   r3 - alto1
 *   [sp] - x2
 *   [sp, #4] - y2
 *   [sp, #8] - ancho2
 *   [sp, #12] - alto2
 * Retorno:
 *   r0 - 1 si hay colisión, 0 si no
 */
.global check_collision_arm
.type check_collision_arm, %function
check_collision_arm:
    push {r4-r6, lr}
    
    /* Cargar parámetros del stack */
    ldr r4, [sp, #16]   /* x2 */
    ldr r5, [sp, #20]   /* y2 */
    ldr r6, [sp, #24]   /* ancho2 */
    ldr lr, [sp, #28]   /* alto2 */
    
    /* Calcular límites del primer objeto */
    add r2, r0, r2      /* r2 = x1 + ancho1 */
    add r3, r1, r3      /* r3 = y1 + alto1 */
    
    /* Calcular límites del segundo objeto */
    add r6, r4, r6      /* r6 = x2 + ancho2 */
    add lr, r5, lr      /* lr = y2 + alto2 */
    
    /* Verificar colisión en X */
    cmp r0, r6          /* x1 > x2+ancho2? */
    bgt no_collision
    cmp r4, r2          /* x2 > x1+ancho1? */
    bgt no_collision
    
    /* Verificar colisión en Y */
    cmp r1, lr          /* y1 > y2+alto2? */
    bgt no_collision
    cmp r5, r3          /* y2 > y1+alto1? */
    bgt no_collision
    
    /* Hay colisión */
    mov r0, #1
    b end_collision_check
    
no_collision:
    mov r0, #0
    
end_collision_check:
    pop {r4-r6, pc}

.size check_collision_arm, .-check_collision_arm
