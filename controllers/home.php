<?php

class HomeController extends xWebController {

    function defaultAction() {
        return xView::load('home/index')->render();
    }

    function cardsAction() {
        $data = array(
            'num-cards' => 10
        );
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