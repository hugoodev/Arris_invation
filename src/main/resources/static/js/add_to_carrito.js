$(document).ready(function() {
    $("#addCarrito").on("click", function(e) {
        addToCarrito();
    })
});
function addToCarrito() {
    cantidad = $("#cantidades" + productoId).val();

    url = contextPath + "carrito/agregar/" + productoId + "/" + cantidad;

    $.ajax({
        type: "POST",
        url: url,
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfValue)
        }
    }).done(function(response) {
        $("#modalTitle").text("Carrito de compras");
        $("#modalBody").html(response);
        $("#myModal").modal("show");
        $.get("/actualizar_carrito?id="+productoId+"&nocache=" + new Date().getTime(), function(data) {$("#seccion_carrito").html(data);});
        $.get("/actualizar_producto?id="+productoId+"&nocache=" + new Date().getTime(), function(data) {$(".seccion_menu").html(data);});
        $('body').removeClass('modal-open');

    }).fail(function() {
              $("#modalTitle").text("Carrito de compras");
              $("#modalBody").text("hubo un error inesperado al intentar agregar el producto al carrito de compras");
              $("#myModal").modal("show");
          })
}