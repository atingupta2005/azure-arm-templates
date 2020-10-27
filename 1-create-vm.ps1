#-------------#First Time---------------------------------
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the Location"
vim parameters.json 	# Edit this parameters file and specify your custom values in it

New-AzResourceGroup -Name $resourceGroupName -Location "$location"

#-------------# Multiple time for many VMs-----------------
$Virtual_Machine_Suffix = Read-Host -Prompt "Virtual Machine_Suffix"

New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/atingupta2005/azure-arm-templates/main/virtual-machine.json" `
	-TemplateParameterFile parameters.json `
    -virtualMachine_Suffix $Virtual_Machine_Suffix

(Get-AzVm -ResourceGroupName $resourceGroupName).name

#--------------------------------------------------------------
