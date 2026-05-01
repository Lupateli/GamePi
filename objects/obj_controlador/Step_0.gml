// Garante que a energia não passe de 100
energia_bom = clamp(energia_bom, 0, 100);

// Lógica de Ativação do Pulo
if (instance_exists(obj_personagem_bom)) {
    // Se a energia estiver em 100%, libera o pulo no samurai
    if (energia_bom >= 100) {
        obj_personagem_bom.pode_pular = true;
    } else {
        obj_personagem_bom.pode_pular = false;
    }
}
// Lógica de Ativação da cura
if (instance_exists(obj_personagem_bom)) {
    // Regra da Cura: Disponível com 50% de energia
    if (energia_bom >= 50) {
        obj_personagem_bom.pode_curar = true;
    } else {
        obj_personagem_bom.pode_curar = false;
    }
	
}