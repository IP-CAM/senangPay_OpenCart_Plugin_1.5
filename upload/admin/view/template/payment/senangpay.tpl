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
                      <img src="https://app.senangpay.my/public/img/logo_senangpay.png" alt="" />
                      <?php echo $heading_title; ?>
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

                  <div class="box">
                          <div class="heading">
                            <h1>
                              <img src="https://app.senangpay.my/public/img/logo_senangpay.png" alt="" />
                              <?php echo $heading_title; ?>
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
                                  <td>
                                    <span class="required">*</span>
                                    <?php echo $entry_email; ?>
                                  </td>
                                  <td>
                                    <input type="text" name="pp_standard_email" value="<?php echo $pp_standard_email; ?>" />
                                    <?php if ($error_email) { ?>
                                      <span class="error">
                                        <?php echo $error_email; ?>
                                      </span>
                                      <?php } ?>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_test; ?>
                                  </td>
                                  <td>
                                    <?php if ($pp_standard_test) { ?>
                                      <input type="radio" name="pp_standard_test" value="1" checked="checked" />
                                      <?php echo $text_yes; ?>
                                        <input type="radio" name="pp_standard_test" value="0" />
                                        <?php echo $text_no; ?>
                                          <?php } else { ?>
                                            <input type="radio" name="pp_standard_test" value="1" />
                                            <?php echo $text_yes; ?>
                                              <input type="radio" name="pp_standard_test" value="0" checked="checked" />
                                              <?php echo $text_no; ?>
                                                <?php } ?>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_transaction; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_transaction">
                                      <?php if (!$pp_standard_transaction) { ?>
                                        <option value="0" selected="selected">
                                          <?php echo $text_authorization; ?>
                                        </option>
                                        <?php } else { ?>
                                          <option value="0">
                                            <?php echo $text_authorization; ?>
                                          </option>
                                          <?php } ?>
                                            <?php if ($pp_standard_transaction) { ?>
                                              <option value="1" selected="selected">
                                                <?php echo $text_sale; ?>
                                              </option>
                                              <?php } else { ?>
                                                <option value="1">
                                                  <?php echo $text_sale; ?>
                                                </option>
                                                <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_debug; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_debug">
                                      <?php if ($pp_standard_debug) { ?>
                                        <option value="1" selected="selected">
                                          <?php echo $text_enabled; ?>
                                        </option>
                                        <option value="0">
                                          <?php echo $text_disabled; ?>
                                        </option>
                                        <?php } else { ?>
                                          <option value="1">
                                            <?php echo $text_enabled; ?>
                                          </option>
                                          <option value="0" selected="selected">
                                            <?php echo $text_disabled; ?>
                                          </option>
                                          <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_total; ?>
                                  </td>
                                  <td>
                                    <input type="text" name="pp_standard_total" value="<?php echo $pp_standard_total; ?>" />
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_canceled_reversal_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_canceled_reversal_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_canceled_reversal_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_completed_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_completed_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_completed_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_denied_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_denied_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_denied_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_expired_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_expired_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_expired_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_failed_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_failed_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_failed_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_pending_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_pending_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_pending_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_processed_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_processed_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_processed_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_refunded_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_refunded_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_refunded_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_reversed_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_reversed_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_reversed_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_voided_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_voided_status_id">
                                      <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_standard_voided_status_id) { ?>
                                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>">
                                              <?php echo $order_status['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_geo_zone; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_geo_zone_id">
                                      <option value="0">
                                        <?php echo $text_all_zones; ?>
                                      </option>
                                      <?php foreach ($geo_zones as $geo_zone) { ?>
                                        <?php if ($geo_zone['geo_zone_id'] == $pp_standard_geo_zone_id) { ?>
                                          <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected">
                                            <?php echo $geo_zone['name']; ?>
                                          </option>
                                          <?php } else { ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>">
                                              <?php echo $geo_zone['name']; ?>
                                            </option>
                                            <?php } ?>
                                              <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_status; ?>
                                  </td>
                                  <td>
                                    <select name="pp_standard_status">
                                      <?php if ($pp_standard_status) { ?>
                                        <option value="1" selected="selected">
                                          <?php echo $text_enabled; ?>
                                        </option>
                                        <option value="0">
                                          <?php echo $text_disabled; ?>
                                        </option>
                                        <?php } else { ?>
                                          <option value="1">
                                            <?php echo $text_enabled; ?>
                                          </option>
                                          <option value="0" selected="selected">
                                            <?php echo $text_disabled; ?>
                                          </option>
                                          <?php } ?>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <?php echo $entry_sort_order; ?>
                                  </td>
                                  <td>
                                    <input type="text" name="pp_standard_sort_order" value="<?php echo $pp_standard_sort_order; ?>" size="1" />
                                  </td>
                                </tr>
                              </table>
                            </form>
                          </div>
                        </div>
                  </div>
                  <?php echo $footer; ?>





                  --------------------------

    <div class="container-fluid">
      <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="alert alert-danger">
          <i class="fa fa-exclamation-circle"></i>
          <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title"><i class="fa fa-pencil"></i>
                <?php echo $text_edit; ?>
              </h3>
            </div>
            <div class="panel-body">
              <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-cod" class="form-horizontal">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-total">
                    <span data-toggle="tooltip" title="<?php echo $help_merchant_id; ?>">
                      <?php echo $entry_merchant_id; ?>
                    </span>
                  </label>
                  <div class="col-sm-10">
                    <input type="text" name="senangpay_merchant_id" value="<?php echo $senangpay_merchant_id; ?>" placeholder="<?php echo $senangpay_merchant_id; ?>" id="input-total" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-total">
                    <span data-toggle="tooltip" title="<?php echo $help_secret_key; ?>">
                      <?php echo $entry_secret_key; ?>
                    </span>
                  </label>
                  <div class="col-sm-10">
                    <input type="text" name="senangpay_secret_key" value="<?php echo $senangpay_secret_key; ?>" placeholder="<?php echo $senangpay_secret_key; ?>" id="input-total" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-order-status">
                    <span data-toggle="tooltip" title="<?php echo $help_order_status; ?>">
                      <?php echo $entry_order_status; ?>
                    </span>
                  </label>
                  <div class="col-sm-10">
                    <select name="senangpay_order_status_id" id="input-order-status" class="form-control">
                      <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if ($order_status['order_status_id'] == $senangpay_order_status_id) { ?>
                          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                            <?php echo $order_status['name']; ?>
                          </option>
                          <?php } else { ?>
                            <option value="<?php echo $order_status['order_status_id']; ?>">
                              <?php echo $order_status['name']; ?>
                            </option>
                            <?php } ?>
                              <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-status">
                    <?php echo $entry_status; ?>
                  </label>
                  <div class="col-sm-10">
                    <select name="senangpay_status" id="input-status" class="form-control">
                      <?php if ($senangpay_status) { ?>
                        <option value="1" selected="selected">
                          <?php echo $text_enabled; ?>
                        </option>
                        <option value="0">
                          <?php echo $text_disabled; ?>
                        </option>
                        <?php } else { ?>
                          <option value="1">
                            <?php echo $text_enabled; ?>
                          </option>
                          <option value="0" selected="selected">
                            <?php echo $text_disabled; ?>
                          </option>
                          <?php } ?>
                    </select>
                  </div>
                </div>
              </form>
            </div>
          </div>
    </div>
  </div>
  <?php echo $footer; ?>
