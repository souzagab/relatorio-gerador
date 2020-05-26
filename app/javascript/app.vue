<template>
  <div id="app">
    <div class="container h-100">
      <div class="row align-items-center h-100">
        <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 mx-auto">
          <div v-if="token">
            <button type="submit" class="btn btn-info my-2" @click="redirectToReport()"> Visualizar relatório </button>
          </div>
          <div class="jumbotron m-0 p-0">
            <vue-signature-pad ref="signaturePad"></vue-signature-pad>
          </div>
          <div class="btn-group mx-top">
              <button type="submit" class="btn btn-success" @click="save()">
                <span class="fas fa-check fa-lg" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-dark" @click="undo()">
                <span class="fas fa-undo fa-lg" aria-hidden="true"></span>
              </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: () => ({
    token: null,
    report_id: null
  }),

  created() {
    this.getParams();
  },

  computed: {
    baseURI() {
      return "http://localhost:3000";
      // return process.env.BASE_URI
    },

    signaturesURI() {
      return `${this.baseURI}/signatures`;
    },

    tokenParam () {
      return `?token=${this.token}`
    },

    printReportURI() {
      return `${this.baseURI}/reports/${this.report_id}/print.pdf${this.tokenParam}`
    },

    showReportURI() {
      return `${this.baseURI}/reports/${this.report_id}/`

    }
  },

  methods: {
    getParams() {
      let uri = window.location.search.substring(1)
      let params = new URLSearchParams(uri)
      this.token = params.get("token")
      this.report_id = params.get("rid")
    },

    undo() {
      this.$refs.signaturePad.undoSignature();
    },

    save() {
      const { isEmpty, data } = this.$refs.signaturePad.saveSignature();

      if (!isEmpty) {
        const payload = {
          token: this.token,
          sign: data
        };
        this.sendSignature(payload);
      } else {
        alert("Preencha a Assinatura");
      }
    },

    sendSignature(payload) {
      return axios
        .post(this.signaturesURI, payload)
        .then(() => {
          // Cofirm Sweetalert -> redireciona ?
          if(this.token){
            window.location.replace(`${this.baseURI}/obrigado.html`)
            alert("Assinatura Confirmada")
          } else {
            window.location.replace(`${this.showReportURI}`)
          }

        })
        .catch(error => {
          alert(error);
          if(this.token){
            window.location.replace(`${this.baseURI}/500.html`)
          }
        })
    },

    redirectToReport () {
      window.open(`${this.printReportURI}`,'_blank', 'toolbar=yes, scrollbars=yes, resizable=yes, top=100, left=500,width=800,height=600')
    }
  }
}
</script>

<style>
#app {
  min-height: 100%;
  height: 100%;
}
.mx-top {
  margin: 0.5rem 13.5rem;
}
</style>
