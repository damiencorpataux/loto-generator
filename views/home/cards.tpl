<?php
    function getSortedCardItems($card) {
        $items = array_reduce($card, function($result, $line) {
            return array_merge($result, array_filter($line));
        }, array());
        sort($items);
        return $items;
    }
    function makeCard($numLines, $numRows, $itemsPerRow, $urls) {
        $lines = array();
        for ($i=0; $i<$numLines; $i++) {
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
    function makeCards($numCards, $numLines, $numRows, $itemsPerRow, $urls) {
        $cards = array();
        while (count($cards) < $numCards) {
            $card = makeCard($numLines, $numRows, $itemsPerRow, $urls);
            // FIXME: Only add line if the symbols combinaison is unique (eg. does not already exist in generated cards)
            $valid = true;
            foreach ($cards as $existing_card) {
                if(!array_diff(getSortedCardItems($card), getSortedCardItems($existing_card))) {
                    $valid = false;
                }
            }
            // Adds valid card to cards
            if ($valid) $cards[] = $card;
        }
        return $cards;
    }
?>

<style>
table {
    border-collapse: collapse;
    margin-left: auto;
    margin-right: auto;
}
td {
    border: 1px solid black;
    text-align: center;
    vertical-align: middle;
    width: 100px;
    height: 150px;
}
table img {
    width: 85px;
}
table .img-placeholder {
    display: inline-block;
    height: 90%;
    width: 90%;
    background-color: #fca;
}
table caption {
    font-family: Helvetica, Sans-serif;
    margin-bottom: 10px;
}
</style>

<?php
    $cards = makeCards($d['cards'], $d['lines'], $d['rows'], $d['row-items'], $d['urls']);
?>

<?php foreach ($cards as $i => $card): ?>
<div style="border:2px solid black;padding:10px">
    <table>
    <caption>
        <div style="float:left">
            <?php echo $d['header'] ?>
        </div>
        <div style="float:right">
            N&deg; <?php echo $i+1 ?>
        </div>
    </caption>
    <?php foreach ($card as $line): ?>
        <tr>
    <?php foreach ($line as $value): ?>
            <td>
    <?php if ($value): ?>
                <img src="<?php echo $value ?>">
    <?php else: ?>
                <div class="img-placeholder">&nbsp;</div>
    <?php endif ?>
            </td>
    <?php endforeach ?>
        <tr>
    <?php endforeach ?>
    </table>
</div>
<br/>
<?php endforeach ?>