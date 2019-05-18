;
(function ($, undefined) {
    var defaults = {
        serverURL: "functions.php",
        numberOfSuggestionsToShow: 5,
        textNoDBtable: "JS_TagBox: Database table is not specified.",
        textNoDBItemId: "JS_TagBox: Database row id is not specified.",
        textBtnAdd: "Add"
    };


    function TagBox($elem, databaseTable, databaseItemId, options) {
        this.$elem = $elem;
        this.elem = $elem[0];
        this.table = databaseTable || this.elem.getAttribute("data-table");
        this.tableId = databaseItemId || this.elem.getAttribute("data-id");
        
        this.settings = $.extend({}, defaults, options);
        if (!this.table) {
            console.error(this.settings.textNoDBtable);
            return null;
        }
        if (!this.tableId) {
            console.error(this.settings.textNoDBItemId);
            return null;
        }
        
        this.$elem.removeClass("js_tb_init").addClass("js_tagbox").data("js_tagbox_initiated", true); //Set init flag
        init(this);

        return this;
    };



//    TagBox.prototype = {
//        // Public variables
//        settings: $.extend({}, defaults, this.options)
//    }
    
    
    
    

    
    
    /**
     * On document ready: search for elements with class "js_tb_init"
     * an initiate plugin on those.
     */
     $(function () { // Document ready 
        var inits = document.getElementsByClassName("js_tb_init");
        var i = 0,
            l = inits.length;

        for (i; i < l; i++) {
            $(inits[0]).js_tb();
        }
    });
    
    

    /**
     * Initiates plugin.
     * @param {TagBox} tagBox - an instance of TagBox constructor.
     */
    function init(tagBox) {
        var $input = $("<input>", {
            type: "text",
            class: "js_tb_input",
            placeholder: "Tags...",
            keyup: (function (e) {
                onInputKeyup(e);
            })
        });

        var $addBtn = $("<button>", {
            text: tagBox.settings.textBtnAdd,
            class: "js_tb_addBtn",
            click: onAddTagClick

        });

        var $resultsList = $("<ul>", {
            class: "js_tb_resultsList"
        });

        var $tagPane = $("<div>", {
            class: "js_tb_tagPane"
        }).on("click", ".js_tb_removeTagBtn", function () {
            removeTag(this);
        });


        tagBox.$elem.append($("<div>", {
            class: "js_tb_wrapper"
        }).append($("<div>", {
            class: "js_tb_searchWrapper"
        }).append($input, $addBtn, $resultsList), $tagPane));


        /**
         * Assigns a new tag to an item. 
         * @param {int} tagId - if this parameter is not given, function will first serach 
         * in suggestions list and if not found, it will be assumed that it is a brand new tag, 
         * so new db enrty will be created for it. 
         * @param {string} tagText = text of the tag.
         */
        function showTag(tid, tagText) {
            $tagPane.prepend($("<p>", {
                text: tagText,
                class: "js_tb_tag",
                tid: tid
            }).append($("<span>", {
                class: "js_tb_removeTagBtn",
                tid: tid
            })).hide().fadeIn());
        }

        /**
         * Assigns a new tag to an item. 
         * @param {int} tagId - if this parameter is not given, function will first serach 
         * in suggestions list and if not found, it will be assumed that it is a brand new tag, 
         * so new db enrty will be created for it. 
         * @param {string} tagText = text of the tag.
         */
        function addTag(tagId, tagText) {
            // Check if tag has already been assigned to this item
            var $assignedTag = isTagAlredyAssigned();
            var $text = tagText.trim();
            if ($assignedTag) {
                tmpClass(tagBox.$elem, "js_tb_fail");
                tmpClass($assignedTag, "js_tb_highlight");
                $input.val("");
                return 100;
            }

            //Check if tag is in sugestions list (already exists in db)
            if (!tagId) {
                // If there are suggestions
                if ($resultsList.children().length > 0) {
                    var $firstChild = $resultsList.children(":first");
                    if ($text == $firstChild.text()) { // if text mathces
                        var tagId = $firstChild.attr("tid"); // get tagId
                    }
                }
            }

            if ($text && $text != "") {
                AJAX({
                    action: "addTag",
                    tableName: tagBox.table,
                    itemId: tagBox.tableId,
                    tagId: tagId,
                    tagText: $text

                }, addTagAJAXCallback)
            }

            function isTagAlredyAssigned() {
                var $existingTags = $tagPane.find(":contains(" + tagText + ")");
                var exists = false;
                $existingTags.each(function () {
                    if ($(this).text() === tagText) {
                        exists = $(this);
                        return false;
                    }
                });
                return exists;
            }

            function addTagAJAXCallback(json) {
                if (json.code == 100) {
                    tmpClass(tagBox.$elem, "js_tb_success");
                    $input.val("");
                    showTag(json.data, $text);
                } else if (json.code == 806) { // tag already assigned (returned by server)
                    tmpClass(tagBox.$elem, "js_tb_fail");
                    tmpClass($tagPane.find("[tid=" + json.data + "]"), "js_tb_highlight");
                    $input.val("");
                }
            }
        }

        (function getAllTags() {
            AJAX({
                action: "getTags",
                tableName: tagBox.table,
                itemId: tagBox.tableId
            }, getAllTagsAJAXCallback);

            function getAllTagsAJAXCallback(json) {
                $.each(json.data, function (key, value) {
                    showTag(value.tid, value.tag)
                });
            }
        })()

        /**
         * Function which is called upon user input. Searches for suggestions in the database 
         * and outputs them to the user.
         * @param {string} like - string pattern to search for. 
         */
        function searchTags(like) {
            AJAX({
                action: "search",
                tableName: "tags",
                search: "tag",
                like: like,
            }, searchTagsAJAXCallback);

            function searchTagsAJAXCallback(json) {
                $.each(json.data, function (key, value) {
                    var $li = $("<li>", {
                        text: value.tag,
                        tid: value.id
                    }).click(function () {
                        addTag(value.id, value.tag);
                        $resultsList.empty();
                    })
                    $resultsList.append($li);
                    return key < tagBox.settings.numberOfSuggestionsToShow - 1;
                });
                $resultsList.onClickOutside(function () {
                    $resultsList.empty();
                });
            }
        }



        /**
         * Removes assigned tag. 
         * @param {DOM} deleteBtn - delete button element within a tag. 
         */
        function removeTag(deleteBtn) {
            var $tag = $(deleteBtn).parent();
            var tagId = $tag.attr("tid");
            $tag.fadeOut(function () {
                this.remove();
            });
            AJAX({
                action: "removeTag",
                tableName: tagBox.table,
                tagId: tagId
            });
        }

        /**
         * AJAX Function allows interactions with server.
         * @param {JSON} data - data to send to server. 
         * @param {function} callback - callback function to be exeuted on success. 
         */
        function AJAX(data, callback) {
            $.ajax({
                url: tagBox.settings.serverURL,
                type: "GET",
                data: data,
                success: function (message) {
                    var json = null;
                    try {
                        json = JSON.parse(message);
                    } catch (error) {
                        console.log(error + "\n\nServer Message: " + message);
                    }
                    if (json) {
                        if (json.code === 100) {
                            callback && callback(json);
                        } else if (json.code !== 901) {
                            console.log(json.msg);
                        }
                    }
                }
            });
        }

        //============EVENT HANDLERS==========//
        /**
         * Button click handler
         */
        function onAddTagClick() {
            $resultsList.empty();
            addTag(null, $input.val());
            return false;
        }

        /**
         * Controls key events once focused on input.
         * @param {event} e - keyup event. 
         */
        function onInputKeyup(e) {
            if (e.which == 13) { // Enter
                e.preventDefault();
                $resultsList.empty();
                addTag(null, $input.val());
            } else if (e.which == 38) { // up
                if ($resultsList.html() != "") { //if reuslts list not empty
                    var $current = $resultsList.find(".js_tb_activeLi");
                    if ($current.length == 0) {
                        $current = $resultsList.children().last();
                    } else {
                        $current.removeClass("js_tb_activeLi");
                        if ($current.prev().length == 0) {
                            $current = $resultsList.children().last();
                        } else {
                            $current = $current.prev();
                        }
                    }
                    $current.addClass("js_tb_activeLi");
                    $input.val($current.text());
                }
            } else if (e.which == 40) { // down
                if ($resultsList.html() != "") { //if reuslts list not empty
                    var $current = $resultsList.find(".js_tb_activeLi");
                    if ($current.length == 0) {
                        $current = $resultsList.children().first();
                    } else {
                        $current.removeClass("js_tb_activeLi");
                        if ($current.next().length == 0) {
                            $current = $resultsList.children().first();
                        } else {
                            $current = $current.next();
                        }
                    }
                    $current.addClass("js_tb_activeLi");
                    $input.val($current.text());
                }
            } else {
                $resultsList.empty();
                if ($input.val() != "") {
                    searchTags($input.val());
                }
            }

        }


        //============HELPERS==========//
        /**
         * This functions assings a class to an elementen and removes it after 2 seconds. 
         * @param {DOM} $element - element to assign class to. 
         * @param {string} classText - class. 
         */
        function tmpClass($element, classText) {
            $element.addClass(classText);
            setTimeout(function () {
                $element.removeClass(classText);
            }, 2000);
        }
    }



    $.fn.js_tb = function (databaseTable, databaseItemId, options) {
        if (this !== null && typeof this !== "undefined" && this.length !== 0) {
            if (this.data("js_tagbox_initiated")) {
                console.warn("Already initiated");
                return this;
            } else {
                return new TagBox(this, databaseTable, databaseItemId, options);
            }
        } else {
            console.error("Cannot initiate plugin on null or undefined object");
            return null;
        }
    };

    /**
     * Listens to click events outside of a DOM element bounds.
     * @param {function} callback - function to be executed on outside click.
     */
    $.fn.onClickOutside = function (callback) {
        $element = $(this);
        $(document).mouseup(function (e) {
            if (!$element.is(e.target) && $element.has(e.target).length === 0) {
                callback();
            }
            $(document).unbind('mouseup');
        });
        return $element;
    };

    function echo(text) {
        console.log(text);
    }
})(jQuery);










