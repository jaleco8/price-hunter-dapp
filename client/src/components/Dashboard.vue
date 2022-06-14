<template>
  <v-container>
    <v-card class="d-flex justify-center mb-6" flat tile>
      <v-img
        :src="require('../assets/platzi-large.png')"
        class="my-3"
        aspect-ratio="1"
        max-width="100"
        max-height="100"
        height="100"
      />
      <v-img
        :src="require('../assets/Celo_Glyph_Color.svg')"
        class="my-3"
        aspect-ratio="1"
        max-width="100"
        max-height="100"
        height="100"
      />
    </v-card>

    <v-row class="text-center">
      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">Bienvenido a la Dapps</h1>

        <p class="subheading font-weight-regular">
          Es un proyecto como parte de reto para contruir soluciones y dar
          <br />
          nuestros primeros pasos por el ecosistema de CELO de la mano de
          Platzi.
        </p>
      </v-col>

      <v-col class="mb-5" cols="12">
        <h2 class="headline font-weight-bold mb-3">🐷Price Hunter💸</h2>

        <p class="subheading font-weight-regular">
          Entérate de los precios de los productos de tu interés, ahorra tiempo
          y dinero.
        </p>
      </v-col>

      <v-col class="mb-5" cols="12" sm="6">
        <v-card class="mx-auto" max-width="344">
          <v-list-item three-line>
            <v-list-item-content>
              <div class="text-overline mb-4">Cargar Datos</div>
              <v-list-item-title class="text-h5 mb-1">
                Incluye tu factura
              </v-list-item-title>
              <v-list-item-subtitle
                >Al ingresar recibes una recompensa</v-list-item-subtitle
              >
            </v-list-item-content>

            <v-list-item-avatar tile size="80" color="grey">
              <v-img :src="require('../assets/qr-frame.png')"></v-img>
            </v-list-item-avatar>
          </v-list-item>
          <v-divider class="mx-4"></v-divider>
          <v-card-actions>
            <v-text-field
              v-model="chave"
              :append-outer-icon="chave ? 'mdi-send' : ''"
              label="Código"
              placeholder="2922 0528 3882 7300 0174 6515 9000 0123 5690 0020 7402"
              color="success"
              :rules="[rules.required, rules.counter]"
              clearable
              solo
              @click:append-outer="getFincalNote"
            ></v-text-field>
          </v-card-actions>
        </v-card>
      </v-col>

      <v-col class="mb-5" cols="12" sm="6">
        <v-card class="mx-auto" max-width="344">
          <v-list-item three-line>
            <v-list-item-content>
              <div class="text-overline mb-4">Consultar Comercio</div>
              <v-list-item-title class="text-h5 mb-1">
                Casar Precios
              </v-list-item-title>
              <v-list-item-subtitle
                >Entérate de los precios</v-list-item-subtitle
              >
            </v-list-item-content>

            <v-list-item-avatar tile size="80" color="grey"
              ><v-img
                :src="
                  require('../assets/top-view-black-friday-sales-assortment-with-copy-space.png')
                "
              ></v-img
            ></v-list-item-avatar>
          </v-list-item>
          <v-divider class="mx-4"></v-divider>
          <v-card-actions>
            <v-btn block dark @click="goToPriceList"> Consultar </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>

    <!-- <v-btn dark @click="verSaldoClickHandler"> ver Saldo </v-btn> -->
  </v-container>
</template>

<script>
import Web3 from "web3";
import { newKitFromWeb3 } from "@celo/contractkit";
import { getFicalNote } from "@/services/fiscalNote";
const fiscalNote = require("@/config/fiscalNote.json");

export default {
  name: "Dashboard",

  data: () => ({
    chave: "",
    rules: {
      required: (value) => !!value || "Required.",
      counter: (value) => value.length <= 44 || "Max 44 characters",
    },
    prod: [],
  }),
  methods: {
    async verSaldoClickHandler() {
      const web3 = new Web3("https://alfajores-forno.celo-testnet.org");
      const kit = newKitFromWeb3(web3);

      let accounts = await kit.web3.eth.getAccounts();
      kit.defaultAccount = accounts[0];
      let totalBalance = await kit.getTotalBalance(
        "0x6B2e7c53c07E60bAEed910EC258684cD8D3f882c"
      );
      console.log(totalBalance["CELO"]["c"][0]);
    },
    sendMessage() {
      this.clearMessage();
    },
    async getFincalNote() {
      try {
        const data = {
          qrcode: `${process.env.VUE_APP_URL_SEFAZ}?p=${this.chave}`,
          estado: "TO",
        };
        const res = await getFicalNote(data);
        if (res.status === 200) {
          //console.log(res.data);
          for (let i = 0; i < res.data.produtos.length; i++) {
            this.prod.push({
              nome: res.data.produtos[i].nome,
              quantidade: res.data.produtos[i].quantidade,
              subtotal: res.data.produtos[i].subtotal,
              total: res.data.produtos[i].total,
              chave: this.chave,
            });
          }

          const web3 = new Web3("https://alfajores-forno.celo-testnet.org");
          const kit = newKitFromWeb3(web3);
          const fiscalNoteContract = new web3.eth.Contract(
            fiscalNote.abi,
            "0x9828F99985a337c41fE3Ef1B72932365d3EA4e58"
          );
          const saveFiscalNote = await fiscalNoteContract.methods
            .saveFiscalNote(res.data.emitente.cnpj, this.prod)
            .send({
              from: kit.defaultAccount,
              gas: "1000000",
            });

          console.log(saveFiscalNote);
        }
      } catch (error) {
        console.log(error);
      }
    },
    clearMessage() {
      this.chave = "";
    },
    goToPriceList() {
      this.$router.push("/price-list");
    },
    /* async liberacionArbitralContractKitHandler() {
      if (window.ethereum) {
        const web3 = new Web3(window.ethereum);
        try {
          // Request account access if needed
          const accounts = await window.ethereum.request({
            method: "eth_requestAccounts",
          });
          const account = accounts[0];
          console.log(account);
          // Acccounts now exposed
          return web3;
        } catch (error) {
          console.error(error);
        }
      }
    }, */
  },
};
</script>
