
    $(document).ready(function() {
    $(".minusButton").on("click", function(evt) {
        evt.preventDefault();
        productoId = $(this).attr("pid");
        ctlInput = $("#cantidad" + productoId);

        newCtl = parseInt(ctlInput.val()) - 1;
        if(newCtl > 0) ctlInput.val(newCtl);
    });

    $(".plusButton").on("click", function(evt) {
            evt.preventDefault();
            productoId = $(this).attr("pid");
            ctlInput = $("#cantidad" + productoId);

            newCtl = parseInt(ctlInput.val()) + 1;
            let cantidad = disponibles;
            if(newCtl <= disponibles) ctlInput.val(newCtl);
        });
});
