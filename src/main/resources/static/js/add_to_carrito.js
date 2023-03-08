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
        $("#modalBody").text(response);
        $("#myModal").modal("show");
    }).fail(function() {
              $("#modalTitle").text("Carrito de compras");
              $("#modalBody").text("hubo un error inesperado al intentar agregar el producto al carrito de compras");
              $("#myModal").modal("show");
          })
}