// Protege contra cliques múltiplos enquanto o herói já estiver atacando
if (instance_exists(obj_personagem_bom) && obj_personagem_bom.estado != "idle") {
    exit;
}

var ctrl = obj_controlador;
var dados = ctrl.pergunta_atual_dados;

// 1. Lógica de Acerto ou Erro
if (!is_undefined(dados)) {
    if (indice == dados[$ "correta"]) {
        // Acertou: Dano no vilão e ganha energia
        ctrl.vida_mau -= ctrl.dano_padrao;
        if (ctrl.vida_mau < 0) ctrl.vida_mau = 0;
        ctrl.energia_bom += 25;
        
        if (instance_exists(obj_personagem_bom)) {
            with(obj_personagem_bom) {
                estado = "avanco";
                image_index = 0;
                image_speed = 0;
            }
        }
        
        if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 15;
    } else {
        // Errou: Dano no herói
        ctrl.vida_bom -= ctrl.dano_padrao;
        if (ctrl.vida_bom < 0) ctrl.vida_bom = 0;
        if (instance_exists(obj_personagem_bom)) obj_personagem_bom.tremor = 15;
        
        if (instance_exists(obj_personagem_mau)) {
            obj_personagem_mau.estado = "ataque";
            obj_personagem_mau.sprite_index = spr_cavaleiro_atack;
            obj_personagem_mau.image_index = 0;
        }
    }
}

// 2. Remove a pergunta atual da lista ativa
ds_list_delete(ctrl.lista_ativa, 0);

// 3. Verificação do Fim da Rodada ou Fim da Batalha
if (ctrl.vida_mau <= 0) {
    // --- VITÓRIA ---
    // Avisa a aplicação web (Next.js) que a fase foi concluída com vitória
    notificar_vitoria_js();
} else if (ctrl.vida_bom <= 0) {
    // --- DERROTA ---
    if (instance_exists(obj_personagem_bom)) {
        obj_personagem_bom.estado = "morte";
        obj_personagem_bom.sprite_index = spr_morte;
        obj_personagem_bom.image_index = 0;
        obj_personagem_bom.image_speed = 0.5;
    }
    // Avisa a aplicação web (Next.js) que o jogador foi derrotado
    notificar_derrota_js();
} else {
    // --- AMBOS AINDA VIVOS ---
    if (ds_list_empty(ctrl.lista_ativa)) {
        // As perguntas da fase acabaram mas o combate ainda não terminou:
        // Recarrega as perguntas para continuar a batalha!
        ctrl.recarregar_perguntas();
    } else {
        // Passa para a próxima pergunta da fila
        ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];
    }
}
