<template>
  <v-app>
    <v-app-bar app color="indigo darken-3" dark>
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
};
</script>
