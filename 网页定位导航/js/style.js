$(function(){
    $(window).scroll(function(){
        var items = $(".center").find(".item");
        var menu = $("#menu");
        var top = $(document).scrollTop();
        var currentId = "";
        items.each(function () {
            var m = $(this);
            //注意：m.offset().top代表每一个item的顶部位置
            if (top > m.offset().top - 300) {
                currentId = "#" + m.attr("id");
            } else {
                return false;
            }
        });

        var currentLink = menu.find(".active");
        if (currentId && currentLink.attr("href") != currentId) {
            currentLink.removeClass("active");
            menu.find("[href=" + currentId + "]").addClass("active");
        }
    });
});
