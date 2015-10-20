<?php
class ModelPaymentSenangpay extends Model
{
    public function getMethod($address, $total)
    {
        $this->load->language('payment/senangpay');

        $method_data = array();
        $status = true;
        
        if($status)
        {
            $method_data = array(
                'code'       => 'senangpay',
                'title'      => $this->language->get('text_title'),
                'terms'      => '',
                'sort_order' => $this->config->get('cod_sort_order')
            );
        }

        return $method_data;
    }
}