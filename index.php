<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/js_select.js"></script>
    <script src="js/js_tagbox.js"></script>

</head>


<body class="visual">
     <?php include('modules/cms-menu.php') ?>
    <?php include('modules/header.php') ?>
    
    <main id="module-seach">
        <div id="sortForm-block">
            <span id="resultsNumber">Результаты: </span>
            <div>
                <span>Сортировать:</span>
                <select id="sortBy" name="sortBy">
                    <option value="">None</option>
                    <option value="productionDate">Дата Производства</option>
                    <option value="alphabet">Алфавит А-Я</option>
                    <option value="produced">Пороизведено</option>
                </select>
            </div>
        </div>
        <a href="editor.php">EDITOR</a><br />
        <a href="template-editor.php">Template EDITOR</a>
        <br/>
<!--        <a href="test.php">Test</a>-->
        <div class="js_tagbox"></div>
    </main>
    
    <?php include('modules/footer.php') ?>

</body>

</html>
