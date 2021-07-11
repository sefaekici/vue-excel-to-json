<template>
    <div>
        <input ref="file" type="file" style="display: none;" @change="onChange($event)" class="form-control">
        <span>{{selectedFile ? selectedFile.name:"Dosya Seçilmedi"}}</span>
        <button  class="selectFile" type="button" @click="$refs.file.click()">Excel Dosyası Seç</button>
        <button  @click="excelToJson()" class="transformFile" >Dönüştür</button>
        <button class="copyToClipboard" v-if="jsonFile"  v-clipboard:copy="JSON.stringify(jsonFile)" v-clipboard:success="onCopy"  v-clipboard:error="onError">Json Kopyala</button>
        <pre>{{jsonFile}}</pre>  
    </div>
</template>




<script>
import XLSX from "xlsx";

export default {
    name:"ExcelToJson",
    data(){
        return{
            selectedFile:null,
            jsonFile:null,
        }
    },
    methods:{
        onCopy: function () {
            alert("Kopyalama Başarılı");
            
        },
        onError: function () {
            alert('Kopyalama Başarısız!');
        },
        deleteJson(){
            this.jsonFile=null;
        },
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


<style scoped>
    div{
        text-align: center;
        height: 100vh;
        width: 800px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    div span{
        font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        padding: 10px;
        width:90%;
        margin-bottom: 2rem;
        color: blue;
    }

    div button{
        width: 200px;
        min-height: 50px;
        margin-bottom: 1rem;
        margin-bottom: 1rem;
        border-radius: 10px;
        border: none;
        cursor: pointer;
        font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        font-size: 15px;
        color: #fff;
    }

    div pre{
        padding: 20px;
        width: 100vw;
        text-align: justify;
        color: #04009A;
    }

    .selectFile{
        background-color:#7C83FD;
        outline: none;
    }
    .transformFile{
        background-color:#66DE93;
    }

    .copyToClipboard{
        background: #476072;
        
    }
</style>