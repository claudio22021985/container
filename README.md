# Workxit Jiu Mobile 0.1.0

Primeira base nativa para iPhone, em SwiftUI, com iOS 17 como versão mínima.
A aplicação demonstra o cartão do aluno, o bloqueio de check-in por tipo de
rede e o detalhamento da mensalidade e do consumo. Os dados são fictícios.

## Abrir no Mac

Com Xcode e XcodeGen instalados, execute na pasta extraída:

```bash
xcodegen generate
open WorkxitJiuMobile.xcodeproj
```

No Xcode, selecione um simulador de iPhone e execute com Command + R.
Para instalar em um iPhone físico, selecione sua equipe em Signing &
Capabilities e ajuste o Bundle Identifier caso necessário.

## Integração com o Workx-Jiu

- Sessão do aluno. Reutilizar a autenticação do sistema e resolver o aluno
  autenticado no servidor em cada operação.
- Cartão. Consultar o histórico oficial por aluno, turma e competência.
- Check-in. Exigir a rede Wi-Fi autorizada. Proposta para produção: um
  serviço acessível apenas pela rede dos alunos emite uma prova assinada
  de curta duração, vinculada ao aluno e à aula. O backend verifica a
  assinatura, a validade, a matrícula e a janela da aula, e registra uma
  única presença por aluno e aula. Testar se a rede de alunos permite
  alcançar o serviço local. A leitura de SSID/BSSID no iOS pode complementar
  o diagnóstico, conforme as permissões e capacidades da Apple.
- Pix. O backend consulta os débitos em aberto e gera a cobrança no
  provedor com os valores oficiais. A confirmação do provedor deve ser
  verificada e processada de forma idempotente antes de baixar mensalidade
  e consumo. A mesma dívida deve ser protegida contra cobranças concorrentes.

O projeto ainda depende do contrato da API, da configuração de rede e do
provedor Pix. A compilação e os testes em simulador dependem do Xcode no Mac.
