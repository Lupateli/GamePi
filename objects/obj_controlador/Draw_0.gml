// 1. Configurações de Fonte
draw_set_font(global.fonte_jogo);

// Coleta o texto do enunciado
var texto = "Carregando dados da API...";
if (!is_undefined(pergunta_atual_dados)) {
    var dados = pergunta_atual_dados;
    if (variable_struct_exists(dados, "enunciado") && !is_undefined(dados[$ "enunciado"])) {
        texto = dados[$ "enunciado"];
    }
}

// 2. Parâmetros de Layout Dinâmico
var centro_x = room_width / 2; // 683px (centralizado na tela)
var topo_y   = 14;             // Posição Y fixa do topo da caixa (abaixo da borda da tela)

// Limites da caixa (espaço entre as barras de vida: 345 a 1021)
var max_largura = 660; // Largura máxima entre as barras de vida
var min_largura = 380; // Largura mínima elegante para perguntas curtas
var max_altura  = 112; // Altura máxima que a caixa pode expandir (não encosta nos personagens)
var min_altura  = 54;  // Altura mínima para pergunta de 1 linha

var pad_x = 24; // Padding horizontal interno
var pad_y = 12; // Padding vertical interno
var sep   = 20; // Espaçamento entre linhas

var max_area_texto_w = max_largura - (pad_x * 2); // 612px
var max_area_texto_h = max_altura - (pad_y * 2);  // 88px

// 3. Cálculo de Escala Dinâmica (NUNCA permite que o texto ultrapasse a caixa)
var escala = 1.0;
var cur_w = string_width_ext(texto, sep, max_area_texto_w);
var cur_h = string_height_ext(texto, sep, max_area_texto_w);

if (cur_h > max_area_texto_h || cur_w > max_area_texto_w) {
    // Estimativa inicial proporcional
    var escala_h = max_area_texto_h / max(cur_h, 1);
    var escala_w = max_area_texto_w / max(cur_w, 1);
    escala = min(escala_h, escala_w);
    
    // Refinamento iterativo seguro: reduz suavemente até garantir 100% de encaixe
    var iter = 0;
    while (iter < 12) {
        var test_wrap = max_area_texto_w / escala;
        var test_h = string_height_ext(texto, sep, test_wrap) * escala;
        var test_w = string_width_ext(texto, sep, test_wrap) * escala;
        
        if (test_h <= max_area_texto_h && test_w <= max_area_texto_w) {
            break;
        }
        escala *= 0.93;
        iter++;
    }
}

// Largura de quebra unscaled correspondente à área máxima
var wrap_w = max_area_texto_w / escala;
var texto_w_final = string_width_ext(texto, sep, wrap_w) * escala;
var texto_h_final = string_height_ext(texto, sep, wrap_w) * escala;

// A caixa expande dinamicamente de acordo com o texto até os limites máximos
var caixa_w = clamp(texto_w_final + (pad_x * 2), min_largura, max_largura);
var caixa_h = clamp(texto_h_final + (pad_y * 2), min_altura, max_altura);

var x1 = centro_x - (caixa_w / 2);
var y1 = topo_y;
var x2 = centro_x + (caixa_w / 2);
var y2 = y1 + caixa_h;

// 4. Desenho do Container
var c_fundo = make_color_rgb(56, 58, 62);
var c_borda = make_color_rgb(26, 28, 30);

// Fundo escuro com cantos
draw_set_color(c_fundo);
draw_rectangle(x1, y1, x2, y2, false);

// Borda escura
draw_set_color(c_borda);
draw_rectangle(x1, y1, x2, y2, true);

// 5. Desenho do Texto Centralizado dentro do Container
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var texto_cx = (x1 + x2) / 2;
var texto_cy = (y1 + y2) / 2;

draw_text_ext_transformed(texto_cx, texto_cy, texto, sep, wrap_w, escala, escala, 0);

// 6. Verificação de Segurança para as variáveis de vida
var max_vida = (variable_instance_exists(id, "vida_maxima") && vida_maxima > 0) ? vida_maxima : 100;
// 7. Barras de Vida
var perc_bom = (vida_bom / vida_maxima_bom) * 100;
var perc_mau = (vida_mau / vida_maxima_mau) * 100;

draw_healthbar(40, 20, 340, 45, perc_bom, c_black, c_red, c_lime, 0, true, true);
draw_healthbar(room_width-340, 20, room_width-40, 45, perc_mau, c_black, c_red, c_lime, 1, true, true);

// 8. Barra de Energia
draw_set_color(c_aqua);
var largura_energia = min(energia_bom * 3, 300); 
draw_rectangle(40, 50, 40 + largura_energia, 60, false);
draw_set_color(c_white);
draw_rectangle(40, 50, 340, 60, true);

// 9. RESET OBRIGATÓRIO (Evita que outros objetos fiquem desalinhados)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
