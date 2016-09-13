jQuery(function ($) {
 var show_error, stripeResponseHandler;
 $("#credit_card_form").submit(function (event) {
var $form;
$form = $("#credit_card_form");
$form.find("input[type=submit]").prop("disabled", true);
$("#wait-message").show();
Stripe.card.createToken($form, stripeResponseHandler);
return false;
 });

stripeResponseHandler = function (status, response) {
var $form, token;
$form = $("#new_reservation");
if (response.error) {
 $("#wait-message").hide();
 show_error(response.error.message);
 $form.find("input[type=submit]").prop("disabled", false);
} else {
 token = response.id;
 $form.append($("<input type=\"hidden\" name=\"reservation[stripe_token]\"
/>").val(token));
 $("[data-stripe=number]").remove();
 $("[data-stripe=cvv]").remove();
 $("[data-stripe=exp-year]").remove();
 $("[data-stripe=exp-month]").remove();
 $("[data-stripe=address-zip]").remove();
 $form.get(0).submit();
}
return false;
 };

show_error = function (message) {
$("#flash-messages").html('<div class="alert"><div
id="flash_alert"><p class="error-color">' + message +
'</p></div></div>');
return false;
 };
