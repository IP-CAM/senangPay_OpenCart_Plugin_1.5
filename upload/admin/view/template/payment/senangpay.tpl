<?php echo $header; ?>
  <div id="content">

    <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?>
          <a href="<?php echo $breadcrumb['href']; ?>">
            <?php echo $breadcrumb['text']; ?>
          </a>
          <?php } ?>
    </div>

    <?php if ($error_warning) { ?>
          <div class="warning">
            <?php echo $error_warning; ?>
          </div>
          <?php } ?>

          <div class="box">
                  <div class="heading">
                    <h1>
                      <img src="view/image/payment.png" alt="" />
                      <?php echo $heading_title; ?>
                      &nbsp;

                    </h1>
                    <div class="buttons">
                      <a onclick="$('#form').submit();" class="button">
                        <?php echo $button_save; ?>
                      </a>
                      <a onclick="location = '<?php echo $cancel; ?>';" class="button">
                        <?php echo $button_cancel; ?>
                      </a>
                    </div>
                  </div>


                          <div class="content">
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                              <table class="form">
                                <tr>
                                  <td>Payment Gateway By:</td>
                                  <td>
                                    <img src="https://app.senangpay.my/public/img/logo_senangpay.png" height="50px" halt="" />
                                    <p><a href="http://www.jomos.com.my">Develop By JOMos (JOM Online Services)</a></p>
                                    <p>Contact Us For Additional Service: Email at idham@jomos.com.my or Whatsapp / telegram at 0196688147</p>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_merchant_id; ?>
                                  </td>
                                  <td>
                                    <input type="text" name="senangpay_merchant_id" value="<?php echo $senangpay_merchant_id; ?>" />
                                    <span><?php echo $help_merchant_id; ?></span>
                                  </td>
                                </tr>

                                <tr>
                                  <td>
                                    <?php echo $entry_secret_key; ?>
                                  </td>
                                  <td>
                                    <input type="text" name="senangpay_secret_key" value="<?php echo $senangpay_secret_key; ?>" />
                                    <span><?php echo $help_secret_key; ?></span>
                                  </td>
                                </tr>

                                <tr>
                                  <td><?php echo $entry_order_status; ?></td>
                                  <td>
                                    <select name="senangpay_order_status_id" id="input-order-status" class="form-control">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $senangpay_order_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                          </select>
                                          <span><?php echo $help_order_status; ?></span>
                                  </td>
                                </tr>

                                <tr>
                                  <td><?php echo $entry_order_fail_status; ?></td>
                                  <td>
                                    <select name="senangpay_order_fail_status_id" id="input-order-fail-status" class="form-control">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $senangpay_order_fail_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                          </select>
                                          <span><?php echo $help_order_fail_status; ?></span>
                                  </td>
                                </tr>

                                <tr>
                                  <td><?php echo $entry_status; ?></td>
                                  <td>
                                    <select name="senangpay_status" id="input-status" class="form-control">
                                      <?php if ($senangpay_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                          <option value="1"><?php echo $text_enabled; ?></option>
                                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                          <?php } ?>
                                        </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td></td>
                                  <td>Develop By <a href="http://www.jomos.com.my">JOMos</a>
                              </table>
                            </form>
                          </div>
                        </div>
                  </div>
                  <?php echo $footer; ?>
