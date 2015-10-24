<?php
class ControllerPaymentSenangpay extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('payment/senangpay');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if(($this->request->server['REQUEST_METHOD'] == 'POST'))
        {
            $this->model_setting_setting->editSetting('senangpay', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->redirect($this->url->link('extension/payment', 'token='.$this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_edit'] = $this->language->get('text_edit');
        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['entry_order_status'] = $this->language->get('entry_order_status');
        $this->data['entry_order_fail_status'] = $this->language->get('entry_order_fail_status');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_merchant_id'] = $this->language->get('entry_merchant_id');
        $this->data['entry_secret_key'] = $this->language->get('entry_secret_key');

        $this->data['help_order_status'] = $this->language->get('help_order_status');
        $this->data['help_order_fail_status'] = $this->language->get('help_order_fail_status');
        $this->data['help_merchant_id'] = $this->language->get('help_merchant_id');
        $this->data['help_secret_key'] = $this->language->get('help_secret_key');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token='.$this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_payment'),
            'href' => $this->url->link('extension/payment', 'token='.$this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('payment/senangpay', 'token='.$this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('payment/senangpay', 'token='.$this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/payment', 'token='.$this->session->data['token'], 'SSL');

        if (isset($this->error['warning'])) {
			       $this->data['error_warning'] = $this->error['warning'];
		    } else {
			       $this->data['error_warning'] = '';
		    }

        if (isset($this->request->post['senangpay_merchant_id']))
            $this->data['senangpay_merchant_id'] = $this->request->post['senangpay_merchant_id'];
        else
            $this->data['senangpay_merchant_id'] = $this->config->get('senangpay_merchant_id');

        if (isset($this->request->post['senangpay_secret_key']))
            $this->data['senangpay_secret_key'] = $this->request->post['senangpay_secret_key'];
        else
            $this->data['senangpay_secret_key'] = $this->config->get('senangpay_secret_key');

        if(isset($this->request->post['senangpay_order_status_id']))
            $this->data['senangpay_order_status_id'] = $this->request->post['senangpay_order_status_id'];
        else
            $this->data['senangpay_order_status_id'] = $this->config->get('senangpay_order_status_id');

        if(isset($this->request->post['senangpay_order_fail_status_id']))
            $this->data['senangpay_order_fail_status_id'] = $this->request->post['senangpay_order_fail_status_id'];
        else
            $this->data['senangpay_order_fail_status_id'] = $this->config->get('senangpay_order_fail_status_id');

        $this->load->model('localisation/order_status');

        $this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

        if (isset($this->request->post['senangpay_status'])) {
                $this->data['senangpay_status'] = $this->request->post['senangpay_status'];
        } else {
                $this->data['senangpay_status'] = $this->config->get('senangpay_status');
        }

        $this->template = 'payment/senangpay.tpl';
		    $this->children = array(
			          'common/header',
			          'common/footer'
		            );

		    $this->response->setOutput($this->render());

    }
}
