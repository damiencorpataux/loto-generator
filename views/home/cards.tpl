<?php
    function makeLines($numLines=3) {
        $numRows = 9;
        $itemsPerRow = 5;
        $urls = xController::load('upload')->urls();
        $lines = array();
        for ($i=0; $i<$numLines; $i++) {
            if (count($urls) < $itemsPerRow) {
                throw new xException('Not enough images to create cards');
            }
            $line = array();
            $keys = array_rand($urls, $itemsPerRow);
            $line = array_map(function($key)use($urls){return $urls[$key];}, $keys);
            while (count($line) < $numRows) array_push($line, null);
            foreach ($keys as $key) unset($urls[$key]);
            shuffle($line);
            $lines[] = $line;
        }
        return $lines;
    }
?>

<style>
table {
}
td {
    border: 1px solid black;
    text-align: center;
    vertical-align: middle;
    width: 100px;
}
table img {
    width: 85px;
}
</style>

<?php for ($i=0; $i<$d['num-cards']; $i++): ?>
<table>
<?php foreach (makeLines() as $line): ?>
    <tr>
<?php foreach ($line as $value): ?>
        <td>
<?php if ($value): ?>
            <img src="<?php echo $value ?>">
<?php else: ?>
            &nbsp;
<?php endif ?>
        </td>
<?php endforeach ?>
    <tr>
<?php endforeach ?>
</table>
<br/>
<?php endfor ?>