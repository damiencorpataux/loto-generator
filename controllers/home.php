<?php

class HomeController extends xWebController {

    function defaultAction() {
        if (is_null($this->session('1st-time'))) $this->session('1st-time', true);
        else $this->session('1st-time', true);
        $data = array(
            'cards' => @$this->params['n'] ? $this->params['n'] : 100,
            'header' => @$this->params['header'] ? $this->params['header'] : 'My Lotery!'
        );
        return xView::load('home/index', $data)->render();
    }

    function cardsAction() {
        $data = array(
            'lines' => 3,
            'rows' => 9,
            'row-items' => 5,
            'cards' => $this->params['cards'],
            'header' => $this->params['header'],
            'urls' => xController::load('upload')->urls()
        );
        // User input validation
        try {
            // Minimum images to create at least one card
            $min_images = $data['row-items']*$data['lines'];
            if (count($data['urls']) < $min_images)
                throw new xException("Not enough images to create cards (at least {$min_images} images are needed)");
            // Minimum cards to create
            $min_cards = 1;
            if ($data['cards'] < $min_cards)
                throw new xException('Please enter the number of cards to create');
        } catch (Exception $e) {
            xWebFront::messages($e->getMessage(), 'danger');
            xUtil::redirect(xUtil::url());
        }
        // HTML Generation
        $html = xView::load('home/cards', $data)->render();
        if (isset($this->params['html'])) die($html);
        // PDF Config
        $paper = 'a4';
        $orientation = 'portrait';
        require_once(xContext::$basepath.'/lib/dompdf/dompdf_config.inc.php');
        $dompdf = new DOMPDF();
        $dompdf->set_paper($paper, $orientation);
        $dompdf->set_base_path(xContext::$baseurl);
        // PDF Generation
        $dompdf->load_html($html);
        $dompdf->render();
        // Download
        $filename = 'lotto-cards.pdf';
        //header('Content-Type: application/csv');
        //header("Content-Disposition: attachment; filename={$filename}");
        $dompdf->stream("print.pdf");
    }
}
