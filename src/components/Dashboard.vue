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
              v-model="message"
              :append-outer-icon="message ? 'mdi-send' : ''"
              label="Código"
              placeholder="2922 0528 3882 7300 0174 6515 9000 0123 5690 0020 7402"
              color="success"
              :rules="[rules.required, rules.counter]"
              clearable
              solo
              @click:append-outer="sendMessage"
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
  </v-container>
</template>

<script>
export default {
  name: "Dashboard",

  data: () => ({
    message: "",
    rules: {
      required: (value) => !!value || "Required.",
      counter: (value) => value.length <= 44 || "Max 44 characters",
    },
  }),
  methods: {
    sendMessage() {
      this.clearMessage();
    },
    clearMessage() {
      this.message = "";
    },
    goToPriceList() {
      this.$router.push('/price-list')
    },
  },
};
</script>
