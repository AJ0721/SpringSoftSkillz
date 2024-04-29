<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="/css/background.css">
        <script src="/js/backend.js"></script>
        <script>

            fetch("/html/backendPage2.html")
                .then(response => {
                    if (response.ok) {
                        return response.text();
                    }
                }).then(data => {
                    document.querySelector('#header').innerHTML = data;
                })


        </script>
    </head>

    <body>
        <div id="header"></div>

    </body>

    </html>