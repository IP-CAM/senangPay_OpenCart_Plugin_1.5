<?php
class ControllerPaymentSenangpay extends Controller
{
    public function index()
    {
        $data['button_confirm'] = $this->language->get('button_confirm');

        $data['continue'] = $this->url->link('checkout/success');
        
        # Prepare the data to send to senangPay
        $data['senangpay_url'] = 'https://app.senangpay.my/payment/'.$this->config->get('senangpay_merchant_id');
        $data['senangpay_order_id'] = $this->session->data['order_id'];
        $data['senangpay_detail'] = "Payment_for_order_".$this->session->data['order_id'];
        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
        $data['senangpay_amount'] = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);
        # need to strip the $ and comma
        $data['senangpay_amount'] = str_replace('$', '', $data['senangpay_amount']);
        $data['senangpay_amount'] = str_replace(',', '', $data['senangpay_amount']);
        $data['senangpay_hash'] = md5($this->config->get('senangpay_secret_key').$data['senangpay_detail'].$data['senangpay_amount'].$this->session->data['order_id']);

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/senangpay.tpl'))
            return $this->load->view($this->config->get('config_template') . '/template/payment/senangpay.tpl', $data);
        else
            return $this->load->view('default/template/payment/custom.tpl', $data);
    }
    
    public function callback()
    {
        $this->load->language('payment/senangpay');
        $this->document->setTitle($this->language->get('text_payment_title'));
        //$this->data['heading_title'] = $this->language->get('text_payment_title');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/home')
        );
        $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_payment_title'),
                'href' => $this->url->link('checkout/checkout')
        );
        
        $data['column_left'] = $this->load->controller('common/column_left');
	$data['column_right'] = $this->load->controller('common/column_right');
	$data['content_top'] = $this->load->controller('common/content_top');
	$data['content_bottom'] = $this->load->controller('common/content_bottom');
	$data['footer'] = $this->load->controller('common/footer');
	$data['header'] = $this->load->controller('common/header');
      
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
                $hash_value = md5($this->config->get('senangpay_secret_key').$status_id.$order_id.$transaction_id.$msg);
                if($hash_value == $hash)
                {
                    if($status_id == '1' || $status_id == 1)
                    {
                        $transaction_status = true;
                        $this->model_checkout_order->addOrderHistory($order_id, $this->config->get('senangpay_order_status_id'), 'Payment was made using senangPay. senangPay transaction id is '.$transaction_id, false);
                        if($this->cart->hasProducts())
                            $this->cart->clear();
                        
                        $data['continue'] = $this->url->link('checkout/success');
                        $data['text_payment_status'] = $this->language->get('text_payment_successful');
                        $data['color'] = 'green';
                    }
                }
            }
        }
        
        if(!$transaction_status)
        {
            $data['continue'] = $this->url->link('checkout/cart');
            $data['text_payment_status'] = $this->language->get('text_payment_failed');
            $data['color'] = 'red';
        }
        
        $data['text_payment_title'] = $this->language->get('text_payment_title');
        $this->response->setOutput($this->load->view('default/template/payment/senangpay_status.tpl', $data));
    }
}