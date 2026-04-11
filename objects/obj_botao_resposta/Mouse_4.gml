var ctrl = obj_controlador;
var dados = ctrl.pergunta_atual_dados;

// 1. Lógica de Acerto ou Erro
if (indice == dados.correta) {
    // Acertou: Dano no vilão e ganha energia
    ctrl.vida_mau -= ctrl.dano_padrao;
    ctrl.energia_bom += 25;
    if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 15;
} else {
    // Errou: Dano no herói
    ctrl.vida_bom -= ctrl.dano_padrao;
    if (instance_exists(obj_personagem_bom)) obj_personagem_bom.tremor = 15;
}

// 2. Remove a pergunta atual da lista
ds_list_delete(ctrl.lista_ativa, 0);

// 3. Verifica se a lista esvaziou (Momento do "Fatal")
if (ds_list_empty(ctrl.lista_ativa)) {
    // Se o vilão ainda tem vida, o jogador falhou por não acertar o suficiente
    if (ctrl.vida_mau > 0) {
        show_message("FATAL! Você não acertou o suficiente. O vilão venceu!");
        game_restart();
    } else {
        // Se o vilão morreu, vitória!
        show_message("Vitória! Você derrotou o vilão!");
        game_restart();
    }
} else {
    // 4. Se a lista ainda tem perguntas, continua normalmente
    ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];
    
    // Checagem de vida para Game Over imediato (se o herói morrer antes da lista acabar)
    if (ctrl.vida_bom <= 0) { 
        show_message("Game Over! Sua vida acabou."); 
        game_restart(); 
    }
}