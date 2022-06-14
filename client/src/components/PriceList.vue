<template>
  <v-card :loading="loading" class="mx-auto my-12" max-width="374">
    <template slot="progress">
      <v-progress-linear
        color="deep-purple"
        height="10"
        indeterminate
      ></v-progress-linear>
    </template>

    <v-img
      height="250"
      :src="require('../assets/beautiful-young-family-with-child.png')"
    ></v-img>

    <v-list>
      <v-list-item three-line v-for="(item, index) in items" :key="item">
        <v-list-item-avatar>
          <v-img :src="require('../assets/grocery.png')"></v-img>
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>{{item.emitente.razao_social}}</v-list-item-title>
          <v-list-item-subtitle><span class="text--primary">Precio Promedio</span> &mdash; $ {{item.total}} </v-list-item-subtitle>
          <v-list-item-subtitle>
            <span class="text--primary">Coincidencia</span> &mdash; {{item.produtos[0].nome}} $ {{item.produtos[0].total}}
          </v-list-item-subtitle>
        </v-list-item-content>
        <v-list-item-action>
          <v-list-item-action-text>{{ ++index }}</v-list-item-action-text>
        </v-list-item-action>
      </v-list-item>

      <v-divider :inset="true"></v-divider>
    </v-list>
  </v-card>
</template>

<script>
import Web3 from "web3";
import { getFicalNoteJson } from "@/services/fiscalNote";
const fiscalNote = require("@/config/fiscalNote.json");
export default {
  name: "PriceList",
  data: () => ({
    loading: false,
    selection: 1,
    items: [],
  }),
  created() {
    this.reserve();
    this.getPriceHunter();
  },

  methods: {
    reserve() {
      this.loading = true;

      setTimeout(() => (this.loading = false), 2000);
    },
    async getPriceHunter() {
      try {
        const res = await getFicalNoteJson();
        if (res.status === 200) {
          this.items = res.data;
          console.log(res.data);
          this.snackbar = true;
          const web3 = new Web3("https://alfajores-forno.celo-testnet.org");
          const fiscalNoteContract = new web3.eth.Contract(
            fiscalNote.abi,
            "0x9828F99985a337c41fE3Ef1B72932365d3EA4e58"
          );

          const getAllMarkets = await fiscalNoteContract.methods
            .getAllMarkets();
          console.log(getAllMarkets);
        }
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
