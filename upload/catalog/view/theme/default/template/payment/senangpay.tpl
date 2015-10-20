<form action="<?php echo $senangpay_url; ?>" method="post">
  <input type="hidden" name="detail" value="<?php echo $senangpay_detail; ?>" />
  <input type="hidden" name="amount" value="<?php echo $senangpay_amount; ?>" />
  <input type="hidden" name="order_id" value="<?php echo $senangpay_order_id; ?>" />
  <input type="hidden" name="hash" value="<?php echo $senangpay_hash; ?>" />
  
  <div class="buttons">
    <div class="pull-right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="btn btn-primary" />
    </div>
  </div>
</form>