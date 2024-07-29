Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to delete user using OneSpan API
function DeleteUser {
    param (
        [string]$email
    )

    # Define the OneSpan API endpoint and the API key (replace with your actual API key)
    $apiUrl = "https://apps.esignlive.eu/api/packages"
    $apiKey = "YOUR_API_KEY"

    # Retrieve the user ID using the email
    $user = Invoke-RestMethod -Uri "$apiUrl?email=$email" -Method Get -Headers @{ "Authorisation" = "Bearer $apiKey" }

    if ($user -and $user.id) {
        # Make the API call to delete the user
        $response = Invoke-RestMethod -Uri "$apiUrl/$($user.id)" -Method Delete -Headers @{ "Authorisation" = "Bearer $apiKey" }

        # Check the response and display a message
        if ($response -eq $null) {
            [System.Windows.Forms.MessageBox]::Show("User Deleted Successfully!")
        } else {
            [System.Windows.Forms.MessageBox]::Show("Failed To Delete User.")
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("User Not Found.")
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "OneSpan User Deletion"
$form.Size = New-Object System.Drawing.Size(300, 200)

# Create the email label and textbox
$emailLabel = New-Object System.Windows.Forms.Label
$emailLabel.Text = "Email:"
$emailLabel.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($emailLabel)

$emailTextbox = New-Object System.Windows.Forms.TextBox
$emailTextbox.Location = New-Object System.Drawing.Point(60, 20)
$emailTextbox.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($emailTextbox)

# Create the submit button
$submitButton = New-Object System.Windows.Forms.Button
$submitButton.Text = "Delete"
$submitButton.Location = New-Object System.Drawing.Point(100, 60)
$submitButton.Add_Click({
    $email = $emailTextbox.Text
    DeleteUser -email $email
})
$form.Controls.Add($submitButton)

# Show the form
[void]$form.ShowDialog()
