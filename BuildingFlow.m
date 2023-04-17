%% Carregar o OpenFOAM
addpath('/opt/openfoam7/matlab');

%% Configuração da simulação
simulacao = ofxSimulation('/home/user/simulacao'); % Diretório para a simulação
simulacao.setSolver('simpleFoam'); % Selecione o solver para a simulação

%% Configuração do caso
caso = simulacao.createCase('tubulacao'); % Nome do caso
caso.setDimension(3); % Setar as dimensões da simulação
caso.setGravity([0 0 -9.81]); % Gravidade
caso.setViscosity(0.001); % Viscosidade
caso.setTransportProperties({'nu', 'nut'}, {0.001, 'nut'}); % Propriedades de transporte

%% Configuração da geometria da tubulação
geometria = caso.createGeometry('tubulacao.stl'); % Arquivo de geometria
geometria.createMesh(); % Criar malha

%% Configuração das condições de contorno
entrada = caso.createPatch('entrada', 'inlet'); % Nome da entrada
entrada.setVelocity([1 0 0]); % Velocidade da entrada
entrada.setValues({'p', 'U'}, {101325, [1 0 0]}); % Pressão e velocidade

saida = caso.createPatch('saida', 'outlet'); % Nome da saída
saida.setValues('p', 0); % Pressão da saída

paredes = caso.createPatch('paredes', 'wall'); % Nome das paredes
paredes.setValues('U', [0 0 0]); % Velocidade das paredes

%% Execução da simulação
simulacao.run();

%% Visualização dos resultados
resultados = caso.readResults(); % Ler os resultados
plot(resultados.Ux); % Plotar a velocidade na direção x
