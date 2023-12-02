function price (){
  if(null != document.getElementById("item-price")) {
    const itemPrice  = document.getElementById("item-price");
    itemPrice.addEventListener("keyup", () => {
      const item_price = itemPrice.value;
      const addTax  = document.getElementById("add-tax-price");
      addTax.innerHTML = Math.floor(item_price * 0.1).toLocaleString();
      const profit  = document.getElementById("profit");
      profit.innerHTML = Math.ceil(item_price * 0.9).toLocaleString();
    })
  };
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);