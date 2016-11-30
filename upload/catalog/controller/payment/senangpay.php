<?php
class ControllerPaymentSenangpay extends Controller
{
    public function index()
    {
        $this->data['button_confirm'] = $this->language->get('button_confirm');

        $this->data['continue'] = $this->url->link('checkout/success');
        
        # Prepare the data to send to senangPay
        $this->data['senangpay_url'] = 'https://app.senangpay.my/payment/'.$this->config->get('senangpay_merchant_id');
        $this->data['senangpay_order_id'] = $this->session->data['order_id'];
        $this->data['senangpay_detail'] = "Payment_for_order_".$this->session->data['order_id'];
        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
        $this->data['senangpay_amount'] = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);
        # need to strip the $ and comma
        $this->data['senangpay_amount'] = str_replace('$', '', $this->data['senangpay_amount']);
        $this->data['senangpay_amount'] = str_replace(',', '', $this->data['senangpay_amount']);
        $this->data['senangpay_hash'] = md5($this->config->get('senangpay_secret_key').$this->data['senangpay_detail'].$this->data['senangpay_amount'].$this->session->data['order_id']);

        if(isset($this->session->data['guest']))
        {
            $this->data['senangpay_name'] = $this->session->data['guest']['firstname'].' '.$this->session->data['guest']['lastname'];
            $this->data['senangpay_email'] = $this->session->data['guest']['email'];
            $this->data['senangpay_phone'] = $this->session->data['guest']['telephone'];
        } else {
            $customerId = $this->session->data['customer_id'];
            $this->data['senangpay_name'] = $this->customer->getFirstName().' '.$this->customer->getLastName();
            $this->data['senangpay_email'] = $this->customer->getEmail();
            $this->data['senangpay_phone'] = $this->customer->getTelephone();
        }

        //var_dump( 'senangpay_name: '.$this->data['senangpay_name'].' senangpay_email: '.$this->data['senangpay_email'].' senangpay_phone '.$this->data['senangpay_phone']  );
        //echo '<pre>';
        //var_dump( $this->customer  );
        //echo '</pre>';

        /*if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/senangpay.tpl'))
            return $this->load->view($this->config->get('config_template') . '/template/payment/senangpay.tpl', $this->data);
        else
            return $this->load->view('default/template/payment/custom.tpl', $this->data);*/

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/senangpay.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/payment/senangpay.tpl';
            } else {
                $this->template = 'default/template/payment/senangpay.tpl';
            }

            $this->render();
    }

    
    public function processing()
    {
       
        $this->load->language('payment/senangpay');
        $this->document->setTitle($this->language->get('text_payment_title'));
        //$this->data['heading_title'] = $this->language->get('text_payment_title');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/home'),
                'separator' => false
        );
        $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_payment_title'),
                'href' => $this->url->link('checkout/checkout'),
                'separator' => $this->language->get('text_separator')
        );
        
    /*$this->data['column_left'] = $this->load->controller('common/column_left');
	$this->data['column_right'] = $this->load->controller('common/column_right');
	$this->data['content_top'] = $this->load->controller('common/content_top');
	$this->data['content_bottom'] = $this->load->controller('common/content_bottom');
	$this->data['footer'] = $this->load->controller('common/footer');
	$this->data['header'] = $this->load->controller('common/header');*/
      
        $transaction_status = false;

        if(isset($this->request->get['status_id']) && isset($this->request->get['order_id']) && isset($this->request->get['msg']) && isset($this->request->get['transaction_id']) && isset($this->request->get['hash']))
        {
            $status_id = urldecode($this->request->get['status_id']);
            $order_id = urldecode($this->request->get['order_id']);
            $msg = urldecode($this->request->get['msg']);
            $transaction_id = urldecode($this->request->get['transaction_id']);
            $hash = urldecode($this->request->get['hash']);
            
            $this->load->model('checkout/order');
            $order_info = $this->model_checkout_order->getOrder($order_id);
            if($order_info)
            {
                $hash_value = md5($this->config->get('senangpay_secret_key').'&status_id='.$status_id.'&order_id='.$order_id.'&transaction_id='.$transaction_id.'&msg='.$msg.'&hash=[HASH]');
                //var_dump( $hash_value );
                if($hash_value == $hash)
                {
                    if($status_id == '1' || $status_id == 1)
                    {
                        $transaction_status = true;

                        if (!$order_info['order_status_id']) {
                            $this->model_checkout_order->confirm($order_id, $this->config->get('senangpay_order_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
                        } else {
                            $this->model_checkout_order->update($order_id, $this->config->get('senangpay_order_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
                        }

                        if($this->cart->hasProducts())
                            $this->cart->clear();
                        
                        $this->data['continue'] = $this->url->link('checkout/success');
                        $this->data['text_payment_status'] = $this->language->get('text_payment_successful');
                        $this->data['color'] = 'green';
                        $this->data['button_continue'] = $this->language->get('button_success_continue');

                    } 
                }
            }
        }

        
        if(!$transaction_status)
        {
            if (!$order_info['order_status_id']) {
                $this->model_checkout_order->confirm($order_id, $this->config->get('senangpay_order_fail_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
            } else {
                $this->model_checkout_order->update($order_id, $this->config->get('senangpay_order_fail_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
            }

            $this->data['continue'] = $this->url->link('checkout/cart');
            $msg = urldecode($this->request->get['msg']);
            if($msg == 'Minimum_transaction_amount_is_RM_2')
            {
                $this->data['text_payment_status'] = "We're sorry. Your order has fail. Minimum order must have total of RM 2";
            } else {
                $this->data['text_payment_status'] = $this->language->get('text_payment_failed');
            }
            $this->data['color'] = 'red';
            $this->data['button_continue'] = $this->language->get('button_fail_continue');
        }
        
        $this->data['text_payment_title'] = $this->language->get('text_payment_title');

        //$this->response->setOutput($this->load->view('default/template/payment/senangpay_status.tpl', $this->data));


        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/senangpay_status.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/payment/senangpay_status.tpl';
            } else {
                $this->template = 'default/template/payment/senangpay_status.tpl';
            }
            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom',
                'common/footer',
                'common/header'
            );
                    
            $this->response->setOutput($this->render());

    }


    /*--------------------------------------------------------------------------------------------------------------------/    
     *
     *    @description   This will be a return callback by Senangpay. Senangpay will call this function through a callback url when there is order that was not processed correctly.
     *    @author        Idham Hafidz JOMos    idham@jomos.com.my
     */
    public function callback()
    {
      
        $transaction_status = false;

        if(isset($this->request->get['status_id']) && isset($this->request->get['order_id']) && isset($this->request->get['msg']) && isset($this->request->get['transaction_id']) && isset($this->request->get['hash']))
        {
            $status_id = urldecode($this->request->get['status_id']);
            $order_id = urldecode($this->request->get['order_id']);
            $msg = urldecode($this->request->get['msg']);
            $transaction_id = urldecode($this->request->get['transaction_id']);
            $hash = urldecode($this->request->get['hash']);
            
            $this->load->model('checkout/order');
            $order_info = $this->model_checkout_order->getOrder($order_id);
            if($order_info)
            {
                $hash_value = md5($this->config->get('senangpay_secret_key').'&status_id='.$status_id.'&order_id='.$order_id.'&transaction_id='.$transaction_id.'&msg='.$msg.'&hash=[HASH]');
                if($hash_value == $hash)
                {
                    if($status_id == '1' || $status_id == 1)
                    {
                        $transaction_status = true;

                        if (!$order_info['order_status_id']) {
                            $this->model_checkout_order->confirm($order_id, $this->config->get('senangpay_order_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
                        } else {
                            $this->model_checkout_order->update($order_id, $this->config->get('senangpay_order_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
                        }
                    } 
                }
            }
        }
        
        if(!$transaction_status)
        {
            if (!$order_info['order_status_id']) {
                $this->model_checkout_order->confirm($order_id, $this->config->get('senangpay_order_fail_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
            } else {
                $this->model_checkout_order->update($order_id, $this->config->get('senangpay_order_fail_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id);
            }
        }

        //var_dump("ok");
        echo "OK";

    }
}
