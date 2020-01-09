<html>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <style>
        #uploadBtn{
            border: 1px solid grey;
            padding: 5px;
            border-radius : 5px;
            width: 90px;
            height: 40px;
            color: grey;
        }
        #uploadBtn:hover{
            background-color: #E1ECFF;
            color : #0E2E67;
            border : 1px solid #0E2E67;
            
        }
        
        #dropdownMenuButton{
            border: 1px solid grey;
            font-weight: bold;
            color: grey;
        }
        #dropdownMenuButton:hover{
            background-color: #E1ECFF;
            color : #0E2E67;
            border : 1px solid #0E2E67;
        }
        #dropMenu{
            background-color: #E1ECFF;
            color : #0E2E67;
        }
    </style>
    <cfoutput>
    <div class="container mt-3 " style="width: 50%">
        <ul class="list-inline">
            <a href="./?page=#URL.upload#" id="uploadFile"><li class="list-inline-item" id="uploadBtn"><center><b>Upload</b></center></li></a>
            <li class="list-inline-item" >
                <div class="dropdown">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                       Report
                    </button>
                    <div class="dropdown-menu" id="dropMenu">
                        <a class="dropdown-item" id="reportCreation" href="./?page=#URL.report#">Report 1</a>
                        <a class="dropdown-item" id="reportCreation" href="./?page=#URL.report2#">Report 2</a>
                        <a class="dropdown-item" id="reportCreation" href="./?page=#URL.report3#">Report 3</a>
                    </div>
                </div>
            </li>
        </ul>
        <hr>
    </div>
    </cfoutput>
</html>