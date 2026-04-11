var ctrl = obj_controlador;
var dados = ctrl.pergunta_atual_dados;

if (indice == dados.correta) {
    ctrl.vida_mau -= ctrl.dano_padrao;
    ctrl.energia_bom += 25; // Ganha 25 de energia por acerto
    if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 15;
} else {
    ctrl.vida_bom -= ctrl.dano_padrao;
    if (instance_exists(obj_personagem_bom)) obj_personagem_bom.tremor = 15;
}

// Passar para a próxima pergunta
ds_list_delete(ctrl.lista_ativa, 0);
if (ds_list_empty(ctrl.lista_ativa)) ctrl.recarregar_perguntas();
ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];

// Checar fim de jogo
if (ctrl.vida_mau <= 0) { show_message("Vitória!"); game_restart(); }
if (ctrl.vida_bom <= 0) { show_message("Game Over!"); game_restart(); }