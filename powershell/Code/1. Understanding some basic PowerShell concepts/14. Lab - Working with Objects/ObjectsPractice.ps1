$Mobiles=@(
    [PSCustomObject]@{
        Brand = "Samsung"
        Model= "Galaxy S22 Ultra"
        Storage=@("128GB","256GB","512GB")
        Colors=@("Black","White","Red","Blue")
        Defaultapps=@(
            @{
                Name="Assist App"
                Status="Installed"
                Version=1.0
            },
            @{
                Name="Samsung Pay"
                Status="Installed"
                Version=2.0
            }
            
        )
        

    },
    [PSCustomObject]@{
        Brand = "Apple"
        Model= "iPhone 13 Pro Max"
        Storage=@("128GB","256GB","512GB")
        Colors=@("Black","White","Red","Blue")
        Defaultapps=@(
            @{
                Name="Health App"
                Status="Installed"
                Version=1.0
            },
            @{
                Name="Apple Pay"
                Status="Installed"
                Version=2.0
            }
            
        )
    }
)

$Mobiles


##Acces the properties of the object
$Mobiles.Brand

##Access by index
$Mobiles[1]

##Pipe operator to take what is on the left and pass it to the right
$Mobiles | Where-Object {$_.Model -eq "Galaxy S22 Ultra"}
# $_ is a special variable that represents the current object in the pipeline

##Accessing the properties of the object
$Mobiles | Where-Object {$_.Model -eq "Galaxy S22 Ultra"} | Select-Object -Property Brand,Model


$Mobiles[0].Defaultapps[0].Name


foreach($app in $Mobiles[0].Defaultapps)
{
    $app.Version
    $app.Name
    $app.Status
}