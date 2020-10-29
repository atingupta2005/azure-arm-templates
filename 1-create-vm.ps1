# Connect to Azure with a browser sign in token
#Connect-AzAccount
#Get-AzSubscription
#Get-AzSubscription -SubscriptionId "cab7799e-bdd5-4b31-a003-c56612e38f3e" -TenantId "6bb2f9af-a0af-4c32-a5ec-5f7011d37551" | Set-AzContext

#-------------#First Time---------------------------------
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name (Mandatory):"
$location = Read-Host -Prompt "Enter the Location (Mandatory):"
$Virtual_Machine_Suffix = Read-Host -Prompt "Virtual Machine_Suffix (Mandatory):"
$vmCount = Read-Host -Prompt "How many VMs to Create(Mandatory)?:"
$publicIPAllocationMethod = Read-Host -Prompt "IP Allocation Method (Static or Dynamic):"


#notepad parameters.json 	# Edit this parameters file and specify your custom values in it

New-AzResourceGroup -Name $resourceGroupName -Location "$location"

#-------------# Multiple time for many VMs-----------------
for($i = 1; $i -le $vmCount; $i++){
	New-AzResourceGroupDeployment `
		-ResourceGroupName $resourceGroupName `
		-TemplateUri "https://raw.githubusercontent.com/atingupta2005/azure-arm-templates/main/virtual-machine.json" `
		-TemplateParameterFile parameters.json  -virtualMachine_Suffix  "$Virtual_Machine_Suffix$i"  -pIPAllocMethod  "$publicIPAllocationMethod"

	(Get-AzVm -ResourceGroupName $resourceGroupName).name

}

#--------------------------------------------------------------