
    $(document).ready(function() {
    $(".minusButto"+idis).on("click", function(evt) {
        evt.preventDefault();
        productoId = $(this).attr("pid");
        ctlInput = $("#cantidades" + productoId);

        newCtl = parseInt(ctlInput.val()) - 1;
        if(newCtl > 0) ctlInput.val(newCtl);
    });

    $(".plusButto"+idis).on("click", function(evt) {
            evt.preventDefault();
            productoId = $(this).attr("pid");
            ctlInput = $("#cantidades" + productoId);

            newCtl = parseInt(ctlInput.val()) + 1;
            let cantidad = disponibles;
            if(newCtl <= disponibles) ctlInput.val(newCtl);
        });
});
