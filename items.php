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
            <h4 class="itemlist-menu-heading">Category: </h4>

            <select id="itemlist-category-select">
                <option disabled selected value>All</option>
                <option value="1">Fuits</option>
                <option value="2">News</option>
                <option value="3">Posts</option>
                <option value="4">Lollipops</option>
            </select>



            <h4 class="itemlist-menu-heading">Sort: </h4>
            <select id="itemlist-sorting-select">
                <option value="0" selected>Newest first</option>
                <option value="1">Oldest first</option>
            </select>

            <button id="itemlist-menu-add">+</button>
        </div>


        <div id="new-item-form">
            <p>
                <span>New Item</span>
                <input id="item-name-input" type="text" />
            </p>
            <p>
                Category:
                <select id="newItem-category-select">
                    <option value="1">Fuits</option>
                    <option value="2">News</option>
                    <option value="3">Posts</option>
                    <option value="4">Lollipops</option>
                </select>
            </p>
            <p>
                Template:
                <select id="newItem-template-select">
                    <option value="">Create New</option>
                    <?php
                        $templates = getItemsListShort();
                        foreach($templates as $templ){
                            echo "<option value='".$templ["id"]."'>".$templ["name"]."</option>";
                        }
                    ?>


                </select>
            </p>
            <button id="create-item-btn">Create</button>
        </div>
        <div id="itemlist-pane"></div>
    </main>




    <?php include('modules/footer.php') ?>
</body>

<script>
    var templateTypes = ["Page", "Block", "Product"];
    var $pane = $("#itemlist-pane");
    var $categoryFilter = $("#itemlist-category-select");
    var $templateFilter = $("#itemlist-type-select");
    var $sorting = $("#itemlist-sorting-select");
    var $addBtn = $("#itemlist-menu-add");
    var $newItemForm = $("#new-item-form");
    var $formInput = $("#item-name-input");
    var $newItemFormActive = false;
    var $formCreateBtn = $("#create-item-btn");
    var $formCategorySelect = $("#newItem-category-select");
    var $formTemplateSelect = $("#newItem-template-select");



    $addBtn.on("click", function() {
        $pane.toggleClass("active");
        $newItemForm.toggleClass("active");
        $newItemFormActive = $newItemFormActive ? false : true;
        if ($newItemFormActive) {
            $formInput.select();
            $addBtn.text("-");
        } else {
            $addBtn.text("+");
        }

    });




    $formCreateBtn.on("click", onCreateNewItemBtnClick);









    function onCreateNewItemBtnClick() {
        var name = $formInput.val();
        if (name && name != " ") { //If not empty
            $formCreateBtn.off("click", onCreateNewItemBtnClick).addClass("disabled");
            $newItemForm.append("<div class='overlay'></div>").addClass("loading");
            AJAX("POST", {
                action: "createItem",
                name: name,
                cat: $formCategorySelect.val(),
                templ: $formTemplateSelect.val()
            }, function(json) {
                window.location.href = "template-editor.php?loadI=" + json.data;
            });

        } else { //Highliht that the name field is empty
            $formInput.addClass("attention");
            setTimeout(function() {
                $formInput.removeClass('attention');
            }, 1000);
        }
    }



    var $loader = $pane.js_loader(showItems, {
        mode: 3, //Pagination,
        tableName: "items",
        serverAction: "getItemsList",
        itemsPerPage: 10,
        orderBy: "id",
        desc: true,
    });


    $categoryFilter.change(function() {
        $loader.filter("category", $categoryFilter.val());
    });




    $sorting.change(function() {
        $loader.orderBy("id").desc($sorting.val() == 0 ? true : false);
    });



    /**
     * AJAX callback. Once SQL rows are retrieved, this method iterates through results
     * and creates an instance of Item, which in turn displays item on the item pane.
     * @param {JSON} json - server response. 
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
                $pane.append("<div class='itemlist-item' data-id='" + itemsArray[i].id + "'><h3 class='itemlist-name'>" + itemsArray[i].name + "</h3><h4 class='itemlist-type'><strong>Category: </strong><span>" + itemsArray[i].catName + "<span></h4><div class='itemlist-btns'><button class='btn-delete' data-id='" + itemsArray[i].id + "'>Delete</button><button class='btn-view'>View</button><a class='btn btn-edit' href='template-editor.php?loadI=" + itemsArray[i].id + "'>Edit</a></div><ul class='itemlist-dates'><li><strong>Created: </strong>" + itemsArray[i].dateCreated + "<strong> At: </strong>" + itemsArray[i].timeCreated + "<strong> By: </strong>" + itemsArray[i].username + "</li><li><strong>Modified: </strong>" + itemsArray[i].dateModified + "<strong> At: </strong>" + itemsArray[i].timeModified + "<strong> By: </strong>" + itemsArray[i].username + "</li></ul></div>");
            }
        } else {
            console.log("Error");
        }
    }







    function AJAX(method, data, callback) {
        $.ajax({
            url: "functions.php",
            type: method,
            data: data,
            success: function(message) {
                var json = null;
                try {
                    json = JSON.parse(message);
                } catch (error) {
                    console.log(error + "\n\nServer Message: " + message);
                }
                if (json && json.code == 100) {
                    callback && callback(json);
                }
            },
            complete: function(message) {
                console.log(message.responseText);
            }
        });
    }



    $pane.on("click", ".btn-delete", function() {
        deleteItem(this.getAttribute("data-id"));
    });

    /**
     * Removes files as well as associated database entries.
     * @param {string} tableName - database table name. 
     * @param {array} ids - an array of element ids. 
     */
    function deleteItem(id) {

        AJAX("GET", {
            action: "deleteItem",
            id: id,
        }, null);

        $pane.find("[data-id='" + id + "']").fadeOut(function() {
            this.remove();
        });

    }

    // Item JSON data example:

    //    {
    //        "id": "2",
    //        "itemName": "Product 1",
    //        "templateId": "6",
    //        "itemAuthorId": "1",
    //        "content": "",
    //        "itemId": "2",
    //        "itemVersion": "1",
    //        "dateCreated": "2019-03-07",
    //        "timeCreated": "47:00:00",
    //        "dateModified": "2019-03-14",
    //        "timeModified": "15:00:00",
    //        "category": "1",
    //        "catName": "Fruits",
    //        "username": "user1",
    //        "templateName": "Product Template",
    //        "templateAuthorId": "1",
    //        "templateType": "2"
    //    }

</script>
