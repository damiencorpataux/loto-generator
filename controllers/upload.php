<?php

class UploadController extends xWebController {

    protected $folder = '/tmp/loto-generator';

    protected function getUploadFolder() {
        $session_id = session_id();
        return "{$this->folder}/{$session_id}";
    }

    function defaultAction() {
        // FIXME: saved file should preserve extension
        $folder = $this->getUploadFolder();
        $file = "{$folder}/".uniqid(null, true);
        // Ensures upload folder exists
        @mkdir($folder, 0777, true);
        // Saves uploaded file
        if (count($_FILES)) {
            $moved = move_uploaded_file(
                $_FILES['upload']['tmp_name'],
                $file //$folder.'/'.$_FILES['upload']['name']
            );
            if ($moved) echo 'done';
        } else if (@$_REQUEST['up']) {
            // Retrieves uploaded file content
            if(@$_REQUEST['base64']) $content = base64_decode(file_get_contents('php://input'));
            else $content = file_get_contents('php://input');
            // Dumps content into local file
            if (file_put_contents($file, $content)) echo 'done';
        } else {
            echo 'No file provided.';
        }
        exit();
    }

    function getAction() {
        $id = @$this->params['id'];
        if (!$id) throw new xExeption('Missing id parameter', 400);
        $file = $this->getUploadFolder().'/'.$id;
        if (!file_exists($file)) throw new xExeption('File not found', 404);
        print file_get_contents($file);
        exit();
    }

    function resetAction() {
        $this->reset();
        xWebFront::messages('All images were sucessfully removed', 'success');
        xUtil::redirect(xUtil::url('', true));
    }

    function reset() {
        array_walk($this->files(), function($file) { unlink($file); });
    }

    function files() {
        $folder = $this->getUploadFolder();
        return glob("{$folder}/*");
    }

    function urls() {
        $folder = $this->getUploadFolder();
        $url = xUtil::url('upload/get', true);
        return array_map(
            function($file) use ($folder, $url) { return str_replace($folder, $url, $file); },
            $this->files()
        );
    }
}