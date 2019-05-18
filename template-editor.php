<?php
//$time = microtime();
//$time = explode(' ', $time);
//$time = $time[1] + $time[0];
//$start = $time;


?>
<link rel="stylesheet" type="text/css" href="css/main.css">


<style>

</style>

<?php require_once('functions.php') ?>

<body>
    <?php include('modules/cms-menu.php'); ?>



    <main>

        <div id="js_te"></div>



    </main>



    <?php include('modules/footer.php') ?>
</body>

<script src="js/jQuery.js"></script>
<script src="js/js_tagbox.js"></script>
<script src="js/js_loader.js"></script>
<script src="js/file_manager.js"></script>
<script src="js/js_select.js"></script>
<script src="js/dragula.js"></script>
<script src="js/trumbowyg/trumbowyg.min.js"></script>
<script src="js/js_template_editor.js"></script>


<script>
    <?php 
        if (isset($_GET["loadI"]) && $_GET["loadI"]){
             echo "var te = $('#js_te').js_te({mode:3}).loadItem(".$_GET["loadI"].");";
        }
        else if (isset($_GET["name"]) && $_GET["name"] && isset($_GET["cat"]) && $_GET["cat"]) {
             echo "var te = $('#js_te').js_te({mode:3}).loadItem(".createItem($_GET["name"],$_GET["cat"]).");";
             unset($_GET);
            header("Location: ".$_SERVER['PHP_SELF']);
            exit;
            
        }
        else if (isset($_GET["loadThis"]) && $_GET["loadThis"]){
                echo "var te = $('#js_te').js_te({mode:3}).loadThis('".$_GET["loadThis"]."');";
//                echo $_GET["loadThis"];
        }
        else{
            echo "var te = $('#js_te').js_te();";
        }
    ?>
    
    
    


    ///////////////////////////TESTING////////////

</script>


<?php
//$time = microtime();
//$time = explode(' ', $time);
//$time = $time[1] + $time[0];
//$finish = $time;
//$total_time = round(($finish - $start), 4);
//echo 'Page generated in '.$total_time.' seconds.';
?>
