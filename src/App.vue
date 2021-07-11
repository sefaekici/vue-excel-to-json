<template>
  <div id="app">
    <h1>Excel To Json App</h1>
    <hr>
    <excel-to-json></excel-to-json>
  </div>
</template>

<script>
import excelToJson from "./components/ExcelToJson.vue"
export default {
  name: 'App',
  components: {
    excelToJson,
  },
 
}
</script>

<style>
  *{
    font-family: 'Courier New', Courier, monospace;
  }
  h1{
    text-align: center;
    margin-bottom: 2rem;
    font-size: 35px;
    color: #7C83FD;
  }

  #app{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
</style>
