fetch("/courseorder/html/testiframe3.html")
    .then(response => {
        if (response.ok) {
            return response.text();
        }
    }).then(data => {
        document.querySelector('#fetch').innerHTML = data;
    })