// MODE
// 1 - load more on scroll
// 2 - load more button
// 3 - pagination

;
(function ($, undefined) {


    var defaults = {
        serverURL: "functions.php",
        serverAction: "getRows", //Server function to execute
        tableName: null, // SQL table to load data from
        mode: 1,

        distanceToLoadMore: 100, //Scroll distace to the bottom of the page to trigger load next page event

        btnMoreOutsideContainer: true, //If set to true, 'Show more' btn wil be appended outside scrollpane


        paginationPrevAdnNext: true, //Mode 3: Pagination previous/next buttons
        paginationButtons: true, //Mode 3: Pagination page buttons
        paginationButtonsLimit: 7, //Mode 3: Pagination page buttons max (if over, advanced pagination is built)
        paginationSearchField: true, //Mode 3: Page search
        paginationSearchPlaceholder: "...", //Mode 3: Page search


        itemsPerPage: 5,
        orderBy: "id",
        desc: true,
        textBtnMore: "Show More",
        textBtnPrev: "Prev",
        textBtnNext: "Next"
    };









    function Loader($elem, callback, options) {
        this.$elem = $elem;
        this.elem = $elem[0];
        this.numberOfItems = null;
        this.numberOfPages = null;
        this.currentPage = 0;
        this.callback = callback;
        this.settings = $.extend({}, defaults, options);
        this.$elem.data("loadMore_initiated", true); //Set init flag
        this.$items = null; // Items loaded in (cache purposes)
        init(this);
        return this;
    };


    Loader.prototype = {
        // Public Methods
        reinit: function () {},
        refresh: function () {
            this.$elem.empty();
            getRowsCount(this);
            showItems(this, 0);
        },
        destroy: function () {
            destroy(this);
        },

        updateRowsCount: function () {
            getRowsCount(this);
            return this;
        },
        emptyPane: function () {
            this.$elem.empty();
            return this;
        },
        setSQLTable: function (table) {
            if (table && table !== "") {
                this.settings.tableName = table;
            }
            return this;
        },
        getSQLTable: function () {
            return this.settings.tableName;
        },

        // SERACHING AND SORTING
        search: function (field, like) {
            if (this.searchLike !== like) { // If search request is not the same as previous one
                this.searchField = field;
                this.searchLike = like;
                this.emptyPane();
                showItems(this, 0);

            }
            return this;
        },
        resetSearch: function () {
            this.searchLike = null;
            this.refresh();
            return this;
        },
        filter: function (field, value) {
            if (this.whereValue !== value) { // If filter request is not the same as previous one
                this.where = field;
                this.whereValue = value;
                this.emptyPane();


                if (this.settings.mode = 3 ) { //pagination
                    //Find new number of results and update pagination
                    getRowsCount(this, redrawPaginationCallback);
                }
                showItems(this, 0);
            }
            return this;
        },
        resetFilter: function () {
            this.where = null;
            this.whereValue = null;
            this.refresh();
            return this;
        },
        orderBy: function (field) {
            if(field){
                 this.settings.orderBy = field;
            }
             return this;
        },

        desc: function (flag) {
            if (typeof (flag) === "boolean" && this.settings.desc !== flag) {
                this.settings.desc = flag;
                this.refresh();
                if (this.settings.mode = 3 && this.settings.paginationButtons) { //if showing pagination and showing page buttons
                    redrawNavPages(this);
                }
            }
            return this;


        },

        // NAVIGATION
        showPage: function (pageNumber) { // page numbers start with 0
            if (pageNumber < this.numberOfPages && pageNumber >= 0) {
                this.emptyPane();
                showItems(this, pageNumber);
            }
        },
        next: function () {
            if (this.currentPage < this.numberOfPages - 1) {
                showItems(this, this.currentPage + 1);
            }
        },
        prev: function () {
            if (this.currentPage > 0) {
                showItems(this, this.currentPage - 1);
            }
        },
        
        // GETTERS
         getCurrentPage: function () {
            return this.currentPage;
        }
    }

    /**
     * A callbeck function to redraw pagination on an instance of Loader
     * with updated values of number of items (and pages)
     */
    function redrawPaginationCallback(json, loader) {
        redrawNavPages(loader);
        updatePrevAdnNextBtns(loader, 0);
        //        paginationNavigate(loader, 0, loader.pagination.children().first())
    }


    function init(loader) {
        loader.elem.classList.add("js_loader");
        getRowsCount(loader, getRowsCountCallback);

        function getRowsCountCallback(json, loader) {
            showItems(loader, 0);
            switch (loader.settings.mode) {
                case 1:
                    loader.$elem.on("scroll", function () {
                        onContainerScroll(loader);
                    });
                    break;
                case 2:
                    if (loader.settings.btnMoreOutsideContainer) {
                        loader.$elem.after(createShowMoreButton(loader));
                    }
                    break;
                case 3:
                    if (loader.numberOfPages > 1) {
                        loader.$elem.after(initPagination(loader));
                    }
                    break;
                case 4:
                    if (loader.numberOfPages > 1) {
                        loader.$elem.after(initScrollPagination(loader));
                    }
                    break;
            }
        }
    }








    function getRowsCount(loader, callback) {
        //Getting total number of items and number of pages required
        AJAX(loader, {
            action: "getRowsCount",
            tableName: loader.settings.tableName,
            where: loader.where,
            whereValue: loader.whereValue,
            search: loader.searchField,
            like: loader.searchLike
        }, function (json, loader) {
            if (json && json.code == 100) {
                loader.numberOfItems = json.data.count;
                loader.numberOfPages = Math.ceil(json.data.count / loader.settings.itemsPerPage);
            }
        }, null, callback);

    }

    function destroy(loader) {
        loader.$elem.removeClass("js_loader").removeData("loadMore_initiated");
        switch (loader.settings.mode) {
            case 1:
                loader.$elem.off("scroll");
                break;
            case 2:
                if (loader.settings.btnMoreOutsideContainer) {
                    var $showMoreElement = loader.$elem.parent().find(".js_loader_more");
                } else {
                    var $showMoreElement = loader.$elem.find(".js_loader_more");
                }
                $showMoreElement.find(".js_loader_btn_more").off("click");
                $showMoreElement.remove();
                break;
            case 3:
                loader.pagination.off("click");
                loader.$elem.parent().find(".js_loader_pagination").remove();

                break;
            case 4:
                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                break;
        }
        loader = null;
        return null;
    }





    //////////////////////////////////////////////////////////////////////////////////////
    ////******************************************************************************////
    ////            MODE 4: Scroll Pagination                                         ////
    ////******************************************************************************////
    //////////////////////////////////////////////////////////////////////////////////////

    //    function initScrollPagination(loader) {
    //        var navPages = loader.settings.paginationButtons;
    //        var navBtns = loader.settings.paginationPrevAdnNext;
    //        var prevBtn = "",
    //            nextBtn = "";
    //
    //        if (navPages) {
    //            var liElements = "";
    //            var i = 0;
    //            var l = loader.numberOfPages - 1;
    //
    //            for (i; i < l && i < 5; i++) {
    //                liElements += "<li data-page='" + i + "' class='js_loader_page'>" + (i + 1) + "</li>";
    //            }
    //
    //            loader.pagination = $("<ul>").on("scroll", ".js_loader_page", function (e) {
    //                onPaginationScroll(e, loader);
    //            }).append(liElements);
    //            loader.currentPaginationLi = loader.pagination.find("li:first").addClass("active"); // Page 0 (First page oppened)
    //        }
    //        if (navBtns) {
    //
    //
    //
    //        }
    //
    //        if (navPages || navBtns) {
    //            return $("<div>", {
    //                class: "js_loader_scrollPagination"
    //            }).append(prevBtn, loader.pagination, nextBtn);
    //        }
    //        return "";
    //    }
    //
    //
    //    function onPaginationScroll() {
    //
    //    }

    //////////////////////////////////////////////////////////////////////////////////////
    ////******************************************************************************////
    ////            MODE 3: Pagination                                                ////
    ////******************************************************************************////
    //////////////////////////////////////////////////////////////////////////////////////

    function initPagination(loader) {
        var prevBtn = "",
            nextBtn = "";

        ////===============ADD PAGE LINKS==============////
        redrawNavPages(loader);

        ////===============CREATE PREV&NEXT BTNS==============////
        if (loader.settings.paginationPrevAdnNext) {
            prevBtn = document.createElement("button");
            prevBtn.innerHTML = loader.settings.textBtnPrev;
            prevBtn.classList.add("btn-prev", "disabled");
            prevBtn.setAttribute("disabled", "");
            prevBtn.addEventListener("click", function () {
                onPaginationPrevClick(loader)
            });

            loader.paginationPrevious = prevBtn; //Set button element refference

            nextBtn = document.createElement("button");
            nextBtn.innerHTML = loader.settings.textBtnNext;
            nextBtn.classList.add("btn-next");
            nextBtn.addEventListener("click", function () {
                onPaginationNextClick(loader)
            });
            loader.paginationNext = nextBtn; //Set button element refference
        }
        if (loader.settings.paginationButtons || loader.settings.paginationPrevAdnNext) {
            return $("<div>", {
                class: "js_loader_pagination"
            }).append(prevBtn, loader.pagination, nextBtn);
        }
        return "";
    }


    /**
     * This function is used to redraw page links in pagination and to update preve & next button state.
     * 
     */
    function redrawNavPages(loader) {
        if (loader.settings.paginationButtons) {
            var i = 0;
            var l = loader.numberOfPages - 1;
            var liElements = "";
            var buttonsLimit = loader.settings.paginationButtonsLimit;



            if (!loader.pagination) { //If pagination UL not defined yet
                loader.pagination = $("<ul>").on("click", ".js_loader_page", function (e) {
                    onPaginationClick(e, loader);
                });
            } else { //If it is - empty it
                loader.pagination.empty();
            }


            if (l < buttonsLimit) { // If there is <limit pages = create simple pagination
                for (i; i <= l; i++) {
                    liElements += "<li data-page='" + i + "' class='js_loader_page'>" + (i + 1) + "</li>";
                }
                loader.pagination.append(liElements);
                loader.currentPaginationLi = loader.pagination.find("li:first").addClass("active"); // Page 0 (First page oppened)
            } else { // Ceate advanced pagination
                if (loader.settings.paginationSearchField) { //If showing serach inputs
                    loader.pagination.on("keyup ", ".js_loader_paginationSearch", function (e) {
                        onPaginationSearch(e, loader);
                    });
                }
                loader.currentPaginationLi = $("<li>", {
                    "data-page": 0,
                    text: "1",
                    class: "js_loader_page active"
                });
                redrawPagination(loader);
            }
        }



    }

    /**
     * Function to update pagination buttons when moving through pages
     * @param {Loader} loader - an instance of Loader object. 
     */
    function redrawPagination(loader) {
        var $activeLi = loader.currentPaginationLi;
        var activePage = $activeLi.data("page");
        var numberOfPages = loader.numberOfPages;
        var liBefore = "";
        var liAfter = "";
        echo(numberOfPages);
        if (activePage !== 0) { //Not first page 
            liBefore += "<li data-page='0' class='js_loader_page'>1</li>"; // page 1
            if (activePage > 1) {
                if (activePage > 2) {
                    liBefore += createSeparator();
                }
                liBefore += "<li data-page='" + (activePage - 1) + "' class='js_loader_page'>" + activePage + "</li>"; // before current
            }
        }
        if (activePage !== numberOfPages - 1) { //Not last page 
            if (activePage < numberOfPages - 2) {
                liAfter += "<li data-page='" + (activePage + 1) + "' class='js_loader_page'>" + (activePage + 2) + "</li>"; // After current
                if (activePage < numberOfPages - 3) {
                    liAfter += createSeparator();
                }
            }
            liAfter += "<li data-page='" + (numberOfPages - 1) + "' class='js_loader_page'>" + numberOfPages + "</li>"; // Last
        }

        loader.pagination.empty().append(liBefore, $activeLi, liAfter);

        function createSeparator() {
            if (loader.settings.paginationSearchField) {
                return "<li class='js_loader_paginationSeparator'><input class='js_loader_paginationSearch' type='text' placeholder='" + loader.settings.paginationSearchPlaceholder + "'></li>";
                //                return "<li class='js_loader_paginationSeparator'><input class='js_loader_paginationSearch' type='number'  min='1' max='" + numberOfPages + "' placeholder='" + loader.settings.paginationSearchPlaceholder + "'></li>";
            }
            return "<li class='js_loader_paginationSeparator'>...</li>";
        }
    }


    function onPaginationClick(e, loader) {
        var $li = $(e.currentTarget);
        var page = $li.data("page");
        if (page != loader.currentPage) {
            paginationNavigate(loader, page, $li);
        }
    }

    function onPaginationSearch(e, loader) {
        if (e.which == 13) { //Enter key pressed
            var input = e.currentTarget;
            var page = input.value - 1;
            if ($.isNumeric(page) && page >= 0 && page < loader.numberOfPages) {
                paginationNavigate(loader, page, $("<li>", {
                    "data-page": page,
                    text: page + 1,
                    class: "js_loader_page"
                }));
            } else {
                tmpClass($(input).parent(), "js_loader_inputError")
            }
        }
    }


    /**
     * This functions controlls what happens when user clicks to open a different page.
     * Pagination re-drawn?
     * Next / Previous button disabled?
     * @param {Loader} loader - an instance of Loader object. 
     * @param {int} page - page number that is about to be shown (pages begin from 0). 
     * @param {DOM} $newPaginationLi - JQ refference to the pagination item (li) of the new page. 
     */

    function paginationNavigate(loader, page, $newPaginationLi) {
        if (loader.settings.paginationButtons) { //If showing page buttons
            loader.currentPaginationLi.removeClass("active");
            loader.currentPaginationLi = $newPaginationLi.addClass("active");
            if (loader.numberOfPages > loader.settings.paginationButtonsLimit) { //If advanced pagination
                redrawPagination(loader);
            }
        }
        updatePrevAdnNextBtns(loader, page);
        loader.showPage(page);
    }


    function updatePrevAdnNextBtns(loader, page) {
        //Update prev and next button
        if (loader.settings.paginationPrevAdnNext) { // IF showing prev&next buttons
            var prevBtn = loader.paginationPrevious;
            var nextBtn = loader.paginationNext;
            if (page === 0) { // If first page
                prevBtn.classList.add("disabled");
                prevBtn.setAttribute("disabled", "");
                nextBtn.classList.remove("disabled");
                nextBtn.removeAttribute("disabled");
            } else if (page === loader.numberOfPages - 1) { // If last page
                nextBtn.classList.add("disabled");
                nextBtn.setAttribute("disabled", "");
                prevBtn.classList.remove("disabled");
                prevBtn.removeAttribute("disabled");
            } else {
                prevBtn.classList.remove("disabled");
                prevBtn.removeAttribute("disabled");
                nextBtn.classList.remove("disabled");
                nextBtn.removeAttribute("disabled");
            }
        }
    }



    function onPaginationPrevClick(loader) {

        if (!loader.paginationPrevious.hasAttribute("disabled")) {
            paginationNavigate(loader, loader.currentPage - 1, loader.currentPaginationLi ? loader.currentPaginationLi.prev() : null);
        }
    }


    function onPaginationNextClick(loader) {
        if (!loader.paginationNext.hasAttribute("disabled")) {
            paginationNavigate(loader, loader.currentPage + 1, loader.currentPaginationLi ? loader.currentPaginationLi.next() : null);
        }
    }


    /**
     * Not used yet
     */
    function destroyPagination(loader) {
        loader.pagination.off("click", ".js_loader_page");
        $(loader.paginationPrevious).off("click");
        $(loader.paginationNext).off("click");

        if (loader.settings.paginationSearchField) { //If showing serach inputs
            loader.pagination.off("keyup ", ".js_loader_paginationSearch", function (e) {
                onPaginationSearch(e, loader);
            });
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////
    ////******************************************************************************////
    ////           Main Functionality                                                 ////
    ////******************************************************************************////
    //////////////////////////////////////////////////////////////////////////////////////

    
    /**
     * This function is used to send AJAX request on retrieving rows from SQL table.
     * These rows then get processed by callback functions.
     * @param {Loader} loader - an instance of Loader constructor. 
     * @param {int} page - pagination (which page to display? 0 - first page)
     *  
     */
    function showItems(loader, page) {
        AJAX(loader, {
            action: loader.settings.serverAction,
            tableName: loader.settings.tableName,
            joinWith: loader.settings.joinWith,
            joinOn: loader.settings.joinOn,
            offset: loader.settings.itemsPerPage * page,
            quantity: loader.settings.itemsPerPage,
            orderBy: loader.settings.orderBy,
            where: loader.where,
            whereValue: loader.whereValue,
            desc: loader.settings.desc,
            search: loader.searchField,
            like: loader.searchLike
        }, loader.callback, preCallback, postCallback);
        loader.currentPage = page; // 0 - is the first page      
    }



    function preCallback(loader) {
        loader.$elem.data("loading", false).removeClass("js_loader_loading");
        if (loader.settings.mode === 1) {
            loader.$elem.find(".js_loader_preloader").remove();
        }
    }

    function postCallback(json, loader) {
        if (loader.settings.mode === 2 && !loader.settings.btnMoreOutsideContainer) {
            loader.$elem.find(".js_loader_btn_more").remove(); //Removing old button
            loader.$elem.append(createShowMoreButton(loader)); //Inserting new button, so it always stays at the bottom
        }
    }






    function AJAX(loader, data, mainCallback, preCallback, postCallback) {
        $.ajax({
            url: loader.settings.serverURL,
            type: "GET",
            data: data,
            success: function (message) {
                preCallback && preCallback(loader);
                var json = null;
                try {
                    json = JSON.parse(message);
                } catch (error) {
                    console.log(error + "\n\nServer Message: " + message);
                }
                if (json.code == 100) {
                    mainCallback && mainCallback(json, loader);
                    postCallback && postCallback(json, loader);
                }
            }
//                        ,
//                        complete: function(message){
//                        echo (message.responseText);
//                    }
        });
    }



    //////////////////////////////////////////////////////////////////////////////////////
    ////******************************************************************************////
    ////            MODE 1: Show More on Scroll                                       ////
    ////******************************************************************************////
    //////////////////////////////////////////////////////////////////////////////////////

    function onContainerScroll(loader) {
        if (loader.currentPage < loader.numberOfPages - 1) {
            if ((loader.elem.scrollHeight - (loader.elem.scrollTop + loader.elem.offsetHeight)) < loader.settings.distanceToLoadMore && !loader.$elem.data("loading")) {
                loader.$elem.append("<div  class='js_loader_preloader loading'></div>").addClass("js_loader_loading").data("loading", true);
                loader.next(); //Load more items
            }
        }
        //        else {
        // Remove listener once there is no more items to load
        //            loader.$elem.off("scroll");
        //        }
    }

    //////////////////////////////////////////////////////////////////////////////////////
    ////******************************************************************************////
    ////            MODE 2: Show More Button                                          ////
    ////******************************************************************************////
    //////////////////////////////////////////////////////////////////////////////////////


    function createShowMoreButton(loader) {
        var $btnMore = $("<button>", {
            class: "js_loader_btn_more",
            text: loader.settings.textBtnMore
        });

        //Do not attach listener if there is no more items to load
        if (loader.currentPage < loader.numberOfPages - 1) {
            $btnMore.on("click", function (e) {
                onShowMoreClick(e, loader)
            });
        } else {
            $btnMore.attr("disabled", "").addClass("disabled");
        }
        var $more = $("<div>", {
            class: "js_loader_more"
        }).append($btnMore);
        return $more;
    }


    function onShowMoreClick(e, loader) {
        echo("Click!");
        var $btnMore = $(e.currentTarget);
        loader.$elem.addClass("js_loader_loading").data("loading", true);
        loader.next(); //Load more items in

        if (loader.currentPage === loader.numberOfPages - 1) {
            $btnMore.off("click").attr("disabled", "").addClass("disabled");
        } else if (!loader.settings.btnMoreOutsideContainer) {
            $btnMore.off("click");
        }

    }








    //============FUNCTION==========//

    $.fn.js_loader = function (callback, options) {
        if (this !== null && typeof this !== "undefined" && this.length !== 0) {
            if (this.data("loadMore_initiated")) {
                console.warn("Already initiated");
                return this;
            } else {
                return new Loader(this, callback, options);
            }
        } else {
            console.error("Cannot initiate plugin on null or undefined object");
            return null;
        }
    };

    function echo(text) {
        console.log(text);
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

})(jQuery);





//$(function () { // Document ready 
//        var inits = document.getElementsByClassName("plugin_init");
//        var i = 0,
//            l = inits.length;
//
//        for (i; i < l; i++) {
//            init(i);
//        }
//
//        function init(i) {
//            $(inits[i]).plugin().showText();
//        }
//
//    });
