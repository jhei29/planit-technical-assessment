*** Settings ***

*** Variables ***

${HOME_CONTACT_BUTTON}              //a[@href='#/contact']/..
${CONTACT_SUBMIT_BUTTON}            //a[@class='btn-contact btn btn-primary' and text()='Submit']
${CONTACT_FORENAME_TXTBOX}          //input[@name='forename']
${CONTACT_SURNAME_TXTBOX}           //input[@name='surname']
${CONTACT_EMAIL_TXTBOX}             //input[@name='email']
${CONTACT_TELEPHONE_TXTBOX}         //input[@name='telephone']
${CONTACT_FEEDBACK_TXTBOX}          //div//textarea[@name='message']
${CONTACT_BACK_BUTTON}              //a[@class='btn' and contains(text(), 'Back')]
${HOME_SHOP_BUTTON}                 //a[@href='#/shop']/..
${SHOP_BUY_STUFFED_FROG}            //img[@src='images/src-embed/frog.jpg']/parent::div/p/a[text()='Buy']
${SHOP_BUY_STUFFED_FROG_PRICE}      //img[@src='images/src-embed/frog.jpg']/parent::div/p/span[contains(@class,'product-price')]
${SHOP_BUY_FLUFFY_BUNNY}            //img[@src='images/src-embed/bunny.jpg']/parent::div/p/a[text()='Buy']
${SHOP_BUY_FLUFFY_BUNNY_PRICE}      //img[@src='images/src-embed/bunny.jpg']/parent::div/p/span[contains(@class,'product-price')]
${SHOP_BUY_VALENTINE_BEAR}          //img[@src='images/src-embed/valentine.jpg']/parent::div/p/a[text()='Buy']
${SHOP_BUY_VALENTINE_BEAR_PRICE}    //img[@src='images/src-embed/valentine.jpg']/parent::div/p/span[contains(@class,'product-price')]
${SHOP_CART_BUTTON}                 //li/a[@href='#/cart']
${SHOP_CHECKOUT_BUTTON}             //a[text()='Check Out']
