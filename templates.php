<script src="js/jQuery.js"></script>
<script src="js/js_tagbox.js"></script>
<script src="js/js_loader.js"></script>
<script src="js/file_manager.js"></script>
<script src="js/js_select.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">


<?php require_once('functions.php') ?>




<body>
    <?php include('modules/cms-menu.php') ?>
    <main>
        <div id="itemlist-menu">
            <h3 id="itemlist-menu-name">Name</h3>
            
            
            <h4 class="itemlist-menu-heading">Type: </h4>
            <select id="itemlist-type-select">
                <option disabled selected value>All</option>
                <option value="0">Page</option>
                <option value="1">Block</option>
                <option value="2">Product</option>
            </select>

            <h4 class="itemlist-menu-heading">Sort: </h4>
            <select id="itemlist-sorting-select">
                <option value="0" selected>Newest first</option>
                <option value="1">Oldest first</option>
            </select>
            
            <button id="itemlist-menu-add">+</button>
        </div>

        <div id="itemlist-pane"></div>
    </main>

    <?php include('modules/footer.php') ?>
</body>

<script>
    var templateTypes = ["Page", "Block", "Product"];
    var $pane = $("#itemlist-pane");
    var $filter = $("#itemlist-type-select");
    var $sorting = $("#itemlist-sorting-select");
   
    
    
    var $loader = $pane.js_loader(showItems, {
        mode: 3, //Pagination
        tableName: "templates",
        itemsPerPage: 4,
        orderBy: "id",
        desc: true,
    });

    
     $filter.change(function (){
        $loader.filter("templateType", $filter.val());
    });
    
    
    $sorting.change(function (){
        $loader.desc($sorting.val() == 0 ? true : false);
    });
    
    /**
     * AJAX callback. Once SQL rows are retrieved, this method iterates through results
     * and creates an instance of Item, which in turn displays item on the item pane.
     * @param {JSON} json - php response. 
     */
    function showItems(json) {
        var itemsArray = json.data;
        if (itemsArray && itemsArray.length > 0) {
            var i = 0;
            var l = itemsArray.length;
            for (i; i < l; i++) {
                /*
                No references to this object.
                Will be removed by garbage collector.
                */
                $pane.append("<div class='itemlist-item' data-id='" + itemsArray[i].id + "'><h3 class='itemlist-name'>" + itemsArray[i].templateName + "</h3><h4 class='itemlist-type'><strong>Type: </strong><span>" + templateTypes[itemsArray[i].templateType] + "<span></h4><div class='itemlist-btns'><button class='btn-delete'>Delete</button><a class='btn btn-edit' href='template-editor.php?loadT=" + itemsArray[i].id + "'>Edit</a><button class='btn-populate'>Populate</button></div></div>");



            }
        } else {
            console.log("Error");
        }
    }

</script>
