# Projeto ABAP - Search Help e Botão "Aceitar Viagem"

Este repositório contém objetos ABAP desenvolvidos como parte de um exercício de manipulação de **CDS Views**, **Service Definitions** e **Behavior Definitions**. O foco principal foi a adição de duas funcionalidades:

1. **Search Help no campo `travel_ID`**
2. **Botão personalizado para aceitar viagem**

---

## Estrutura do Projeto

O diretório `src/` contém os artefatos ABAP divididos em:

* **CDS Views (`.ddls.asddls`, `.ddlx.asddlxs`)**

  * Ex.: `zc_fe_booking_2174`, `zc_fe_travel_2174`, `zc_fe_travel_2174_vh` (View de ajuda de pesquisa para `travel_ID`)
* **Behavior Definitions (`.bdef.asbdef`)**

  * Ex.: `zc_fe_travel_2174.bdef.asbdef` e `zi_fe_travel_2174.bdef.asbdef`
* **Service Definitions (`.srvd.srvdsrv`)**

  * Ex.: `zfe_ui_travel_2174.srvd.srvdsrv`
* **Classes ABAP (`.clas.abap`, `.clas.locals_imp.abap`)**

  * Ex.: `zfe_bp_r_traveltp_2174` (implementação do behavior com o botão **Aceitar Viagem**)
  * Ex.: `zfe_data_generator_2174` (geração de dados de teste)

---

## Destaques da Implementação

### 🔍 Search Help em `travel_ID`

Foi criado o objeto **`zc_fe_travel_2174_vh.ddls.asddls`**, que funciona como uma *Value Help* associada ao campo `travel_ID`. Assim, ao criar ou editar registros, o usuário pode selecionar um `travel_ID` válido a partir da lista de valores disponíveis.

### 🖱️ Botão "Aceitar Viagem"

Na classe de implementação **`zfe_bp_r_traveltp_2174.clas.abap`**, foi adicionado um **Action** customizado para permitir que o usuário aceite uma viagem. Esse botão aparece na interface Fiori associada ao objeto de viagem, alterando o status da viagem ao ser acionado.

---

## Como Utilizar

1. **Importar os objetos** para o sistema ABAP.
2. Ativar todos os artefatos no pacote correspondente.
3. Testar via **SAP Fiori Elements**:

   * Na tela de *Travel*, usar o **search help** para selecionar o `travel_ID`.
   * Executar a ação **Aceitar Viagem** pelo botão adicionado.

---

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.
