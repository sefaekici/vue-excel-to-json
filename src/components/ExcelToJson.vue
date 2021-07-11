<template>
    <div>
        <input ref="file" type="file" style="display: none;" @change="onChange($event)" class="form-control">
        <span>{{selectedFile.name}}</span>
        <button class="btn btn-outline-secondary " type="button" @click="$refs.file.click()">Excel Dosyası Seç</button>
        <button @click="excelToJson()">Dönüştür</button>
        <pre>{{jsonFile}}</pre>
    </div>
</template>




<script>
import XLSX from "xlsx";
export default {
    data(){
        return{
        selectedFile:null,
        jsonFile:null,
        }
    },
     methods:{
    onChange(e) {
      const file = e.target.files[0];
      this.selectedFile =file;
    },
    excelToJson(){
      if(this.selectedFile){
        console.log(this.selectedFile);
        let fileReader=new FileReader();
        fileReader.readAsBinaryString(this.selectedFile);
        fileReader.onload=(e)=>{
          let data=e.target.result;
          let workbook=XLSX.read(data,{type:"binary"});
          workbook.SheetNames.forEach(sheet=>{
            let rowObject=XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheet]);
            this.jsonFile=rowObject;
          })

        }
      }
      else{
        alert("Lütfen dönüştüreceğiniz dosyayı seçiniz!");
      }
    }

  }   
}
</script>