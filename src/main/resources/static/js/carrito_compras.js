$(document).ready(function() {
    $(".minusButton").on("click", function(evt) {
            evt.preventDefault();
            decreaseCantidad($(this));
        });

        $(".plusButton").on("click", function(evt) {
                evt.preventDefault();
                increaseCantidad($(this))
            });


    updateTotal();
});

function decreaseCantidad(link) {
    productoId = link.attr("pid");
                ctlInput = $("#cantidad" + productoId);

                newCtl = parseInt(ctlInput.val()) - 1;
                if(newCtl > 0) {
                 ctlInput.val(newCtl);
                 updateCantidad();
                 }
}

function increaseCantidad(link) {

    productoId = link.attr("pid");
                    ctlInput = $("#cantidad" + productoId);

                    newCtl = parseInt(ctlInput.val()) + 1;
                    let cantidad = disponibles;
                    if(newCtl <= cantidad) {
                    ctlInput.val(newCtl);
                    updateCantidad()
                    }

}

function updateCantidad() {

}

function updateTotal() {
    total = 0;

    $(".productosSubtotal").each(function(index, element) {

        total = total + parseFloat(element.innerHTML);
    })

    $("#totalAmount").text("$ " + total);
}
