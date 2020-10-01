#Install Azure powershell module
Install-Module -Name az -Scope AllUsers -AllowClobber

#Login to azure
Login-AzAccount

#Read the list of resource group
Get-AzResourceGroup | Format-Table

#New Resource group
New-AzResourceGroup -Name ps-lab-grp -Location 'East US'

#Declare a variable
$tags += @{Environment="Lab"}
Set-AzResourceGroup -ResourceGroupName ps-lab-grp -Tag $tags

#Remove-AzResourceGroup -Name ps-lab-grp

$appurl = "https://github.com/Azure-Samples/app-service-web-dotnet-get-started.git"
$myurl= "https://github.com/triptakaku/myaz204repository_Tripta.git"

$webappname = "mywebapp$(Get-Random)"
$location="eastus"

New-AzAppServicePlan -ResourceGroupName ps-lab-grp -Location 'East US' -Tier Free -Name ps-asp-009
New-AzWebApp -Name $webappname -Location $location -AppServicePlan ps-asp-009 -ResourceGroupName ps-lab-grp

    
# Create deployment resource manually using ARM
$PropertiesObject = @{
    repoUrl = "$myurl";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName ps-lab-grp -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force

Remove-AzResourceGroup -Name ps-lab-grp
