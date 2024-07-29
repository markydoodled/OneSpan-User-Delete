Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to delete user using OneSpan API
function DeleteUser {
    param (
        [string]$senderID
    )

    # Define the OneSpan API endpoint and the API key (replace with your actual API key)
    $apiUrl = "https://api.onespan.com/api/account/sender/$senderID"
    $apiKey = "YOUR_API_KEY"

    # Make the API call to delete the user
    try {
        $response = Invoke-RestMethod -Uri $apiUrl -Method Delete -Headers @{ "Authorization" = "Bearer $apiKey" }

        # Check the response and display a message
        if ($response -eq $null) {
            [System.Windows.Forms.MessageBox]::Show("User Deleted Successfully!")
        } else {
            [System.Windows.Forms.MessageBox]::Show("Failed To Delete User.")
        }
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: $_")
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "OneSpan User Deletion"
$form.Size = New-Object System.Drawing.Size(300, 150)

# Create the sender ID label and textbox
$senderIDLabel = New-Object System.Windows.Forms.Label
$senderIDLabel.Text = "Sender ID:"
$senderIDLabel.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($senderIDLabel)

$senderIDTextbox = New-Object System.Windows.Forms.TextBox
$senderIDTextbox.Location = New-Object System.Drawing.Point(80, 20)
$senderIDTextbox.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($senderIDTextbox)

# Create the delete button
$deleteButton = New-Object System.Windows.Forms.Button
$deleteButton.Text = "Delete"
$deleteButton.Location = New-Object System.Drawing.Point(100, 60)
$deleteButton.Add_Click({
    $senderID = $senderIDTextbox.Text
    DeleteUser -senderID $senderID
})
$form.Controls.Add($deleteButton)

# Show the form
[void]$form.ShowDialog()
