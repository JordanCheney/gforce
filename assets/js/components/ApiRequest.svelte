<script context="module">
  export function launchApiRequest(id, file, apiKey, targets, callback) {
    let reader = new FileReader();
    reader.onload = function(e) {
      let splitIdx = e.target.result.indexOf(',') + 1;
      let base64image = e.target.result.substr(splitIdx);
      
      const options = {
        method: 'POST',
        body: JSON.stringify({key: apiKey, image: base64image}),
        headers: {
          'Content-Type': 'application/json'
        }
      };

      fetch('api/recognize', options)
        .then(res => res.json())
        .then(res => {
          console.log("Response received for file " + id.toString());
          window.sessionStorage.setItem(id, JSON.stringify(res.responses[0]));
          callback(id);
        }
      );
    }
    reader.readAsDataURL(file);
  }
</script>

<div/>