<?php
$result = "";
$error = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $num1 = $_POST["num1"] ?? 0;
    $num2 = $_POST["num2"] ?? 0;
    $operation = $_POST["operation"] ?? "";

    if (!is_numeric($num1) || !is_numeric($num2)) {
        $error = "Please enter valid numbers.";
    } else {
        switch ($operation) {
            case "add":
                $result = $num1 + $num2;
                break;

            case "sub":
                $result = $num1 - $num2;
                break;

            case "mul":
                $result = $num1 * $num2;
                break;

            case "div":
                if ($num2 == 0) {
                    $error = "Division by zero is not allowed.";
                } else {
                    $result = $num1 / $num2;
                }
                break;

            default:
                $error = "Invalid operation.";
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>PHP Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
        }
        .calculator {
            width: 300px;
            margin: 80px auto;
            padding: 20px;
            background: #fff;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input, select, button {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
        }
        .result {
            margin-top: 15px;
            font-weight: bold;
            color: green;
        }
        .error {
            margin-top: 15px;
            color: red;
        }
    </style>
</head>
<body>

<div class="calculator">
    <h2>PHP Calculator</h2>

    <form method="post">
        <input type="number" step="any" name="num1" placeholder="First number" required>
        <input type="number" step="any" name="num2" placeholder="Second number" required>

        <select name="operation" required>
            <option value="">Select operation</option>
            <option value="add">Add (+)</option>
            <option value="sub">Subtract (-)</option>
            <option value="mul">Multiply (×)</option>
            <option value="div">Divide (÷)</option>
        </select>

        <button type="submit">Calculate</button>
    </form>

    <?php if ($result !== ""): ?>
        <div class="result">
            Result: <?= htmlspecialchars((string)$result) ?>
        </div>
    <?php endif; ?>

    <?php if ($error !== ""): ?>
        <div class="error">
            <?= htmlspecialchars($error) ?>
        </div>
    <?php endif; ?>
</div>

</body>
</html>
