<template>
  <v-app>
    <v-app-bar app color="indigo darken-3" dark>
      <v-btn v-if="currentRouteName == '/price-list'" to="/" icon>
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>
      <div class="d-flex align-center">
        <h1>🐷Price Hunter💸</h1>
      </div>
    </v-app-bar>

    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "App",
  computed: {
    currentRouteName() {
      //console.log(this.$route.path);
      return this.$route.path;
    }
  }
};
</script>
