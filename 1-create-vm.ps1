# Connect to Azure with a browser sign in token
#Connect-AzAccount
#Get-AzSubscription
#Get-AzSubscription -SubscriptionId "83c07bcb-1ba8-4fb5-beb5-2a30c680d4fc" -TenantId "6bb2f9af-a0af-4c32-a5ec-5f7011d37551" | Set-AzContext

#-------------#First Time---------------------------------
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the Location"
$Virtual_Machine_Suffix = Read-Host -Prompt "Virtual Machine_Suffix (vm)"
$vmCount = Read-Host -Prompt "How many VMs to Create? "

#notepad parameters.json 	# Edit this parameters file and specify your custom values in it

New-AzResourceGroup -Name $resourceGroupName -Location "$location"

#-------------# Multiple time for many VMs-----------------
for($i = 1; $i -le $vmCount; $i++){
	New-AzResourceGroupDeployment `
		-ResourceGroupName $resourceGroupName `
		-TemplateUri "https://raw.githubusercontent.com/atingupta2005/azure-arm-templates/main/virtual-machine.json" `
		-TemplateParameterFile parameters.json `
		-virtualMachine_Suffix "$Virtual_Machine_Suffix$i"

	(Get-AzVm -ResourceGroupName $resourceGroupName).name

}

#--------------------------------------------------------------