<#
    .DESCRIPTION
        This DSC configuration manages access control lists on Active Directory Configuration objects.
    .PARAMETER DomainDN
        Distinguished Name (DN) of the domain.
    .PARAMETER Objects
        Specify a list of Active Directory objects.
#>
#Requires -Module ActiveDirectoryDsc

function Get-SchemaObjectGuid
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory)]
        [System.String]
        $Objectname
    )

    $schemaIdGuid = switch ($ObjectName)
    {
        'account' { '2628a46a-a6ad-4ae0-b854-2b12d9fe6f9e' }
        'Account-Expires' { 'bf967915-0de6-11d0-a285-00aa003049e2' }
        'Account-Name-History' { '031952ec-3b72-11d2-90cc-00c04fd91ab1' }
        'ACS-Aggregate-Token-Rate-Per-User' { '7f56127d-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Allocable-RSVP-Bandwidth' { '7f561283-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Cache-Timeout' { '1cb355a1-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Direction' { '7f56127a-5301-11d1-a9c5-0000f80367c1' }
        'ACS-DSBM-DeadTime' { '1cb355a0-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-DSBM-Priority' { '1cb3559e-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-DSBM-Refresh' { '1cb3559f-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Enable-ACS-Service' { '7f561287-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Enable-RSVP-Accounting' { 'f072230e-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-Enable-RSVP-Message-Logging' { '7f561285-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Event-Log-Level' { '7f561286-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Identity-Name' { 'dab029b6-ddf7-11d1-90a5-00c04fd91ab1' }
        'ACS-Max-Aggregate-Peak-Rate-Per-User' { 'f072230c-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-Max-Duration-Per-Flow' { '7f56127e-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Maximum-SDU-Size' { '87a2d8f9-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Max-No-Of-Account-Files' { 'f0722310-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-Max-No-Of-Log-Files' { '1cb3559c-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Max-Peak-Bandwidth' { '7f561284-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Max-Peak-Bandwidth-Per-Flow' { '7f56127c-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Max-Size-Of-RSVP-Account-File' { 'f0722311-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-Max-Size-Of-RSVP-Log-File' { '1cb3559d-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Max-Token-Bucket-Per-Flow' { '81f6e0df-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Max-Token-Rate-Per-Flow' { '7f56127b-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Minimum-Delay-Variation' { '9c65329b-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Minimum-Latency' { '9517fefb-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Minimum-Policed-Size' { '8d0e7195-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Non-Reserved-Max-SDU-Size' { 'aec2cfe3-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Non-Reserved-Min-Policed-Size' { 'b6873917-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Non-Reserved-Peak-Rate' { 'a331a73f-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Non-Reserved-Token-Size' { 'a916d7c9-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Non-Reserved-Tx-Limit' { '1cb355a2-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Non-Reserved-Tx-Size' { 'f072230d-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-Permission-Bits' { '7f561282-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Policy' { '7f561288-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Policy-Name' { '1cb3559a-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Priority' { '7f561281-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Resource-Limits' { '2e899b04-2834-11d3-91d4-0000f87a57d4' }
        'ACS-RSVP-Account-Files-Location' { 'f072230f-aef5-11d1-bdcf-0000f80367c1' }
        'ACS-RSVP-Log-Files-Location' { '1cb3559b-56d0-11d1-a9c6-0000f80367c1' }
        'ACS-Server-List' { '7cbd59a5-3b90-11d2-90cc-00c04fd91ab1' }
        'ACS-Service-Type' { '7f56127f-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Subnet' { '7f561289-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Time-Of-Day' { '7f561279-5301-11d1-a9c5-0000f80367c1' }
        'ACS-Total-No-Of-Flows' { '7f561280-5301-11d1-a9c5-0000f80367c1' }
        'Additional-Information' { '6d05fb41-246b-11d0-a9c8-00aa006c33ed' }
        'Additional-Trusted-Service-Names' { '032160be-9824-11d1-aec0-0000f80367c1' }
        'Address' { 'f0f8ff84-1191-11d0-a060-00aa006c33ed' }
        'Address-Book-Container' { '3e74f60f-3e73-11d1-a9c0-0000f80367c1' }
        'Address-Book-Roots' { 'f70b6e48-06f4-11d2-aa53-00c04fd7d83a' }
        'Address-Book-Roots2' { '508ca374-a511-4e4e-9f4f-856f61a6b7e4' }
        'Address-Entry-Display-Table' { '5fd42461-1262-11d0-a060-00aa006c33ed' }
        'Address-Entry-Display-Table-MSDOS' { '5fd42462-1262-11d0-a060-00aa006c33ed' }
        'Address-Home' { '16775781-47f3-11d1-a9c3-0000f80367c1' }
        'Address-Syntax' { '5fd42463-1262-11d0-a060-00aa006c33ed' }
        'Address-Template' { '5fd4250a-1262-11d0-a060-00aa006c33ed' }
        'Address-Type' { '5fd42464-1262-11d0-a060-00aa006c33ed' }
        'Admin-Context-Menu' { '553fd038-f32e-11d0-b0bc-00c04fd8dca6' }
        'Admin-Count' { 'bf967918-0de6-11d0-a285-00aa003049e2' }
        'Admin-Description' { 'bf967919-0de6-11d0-a285-00aa003049e2' }
        'Admin-Display-Name' { 'bf96791a-0de6-11d0-a285-00aa003049e2' }
        'Admin-Multiselect-Property-Pages' { '18f9b67d-5ac6-4b3b-97db-d0a406afb7ba' }
        'Admin-Property-Pages' { '52458038-ca6a-11d0-afff-0000f80367c1' }
        'Allowed-Attributes' { '9a7ad940-ca53-11d1-bbd0-0080c76670c0' }
        'Allowed-Attributes-Effective' { '9a7ad941-ca53-11d1-bbd0-0080c76670c0' }
        'Allowed-Child-Classes' { '9a7ad942-ca53-11d1-bbd0-0080c76670c0' }
        'Allowed-Child-Classes-Effective' { '9a7ad943-ca53-11d1-bbd0-0080c76670c0' }
        'Alt-Security-Identities' { '00fbf30c-91fe-11d1-aebc-0000f80367c1' }
        'ANR' { '45b01500-c419-11d1-bbc9-0080c76670c0' }
        'Application-Entity' { '3fdfee4f-47f4-11d1-a9c3-0000f80367c1' }
        'Application-Name' { 'dd712226-10e4-11d0-a05f-00aa006c33ed' }
        'Application-Process' { '5fd4250b-1262-11d0-a060-00aa006c33ed' }
        'Application-Settings' { 'f780acc1-56f0-11d1-a9c6-0000f80367c1' }
        'Application-Site-Settings' { '19195a5c-6da0-11d0-afd3-00c04fd930c9' }
        'Application-Version' { 'ddc790ac-af4d-442a-8f0f-a1d4caa7dd92' }
        'Applies-To' { '8297931d-86d3-11d0-afda-00c04fd930c9' }
        'App-Schema-Version' { '96a7dd65-9118-11d1-aebc-0000f80367c1' }
        'Asset-Number' { 'ba305f75-47e3-11d0-a1a6-00c04fd930c9' }
        'Assistant' { '0296c11c-40da-11d1-a9c0-0000f80367c1' }
        'associatedDomain' { '3320fc38-c379-4c17-a510-1bdf6133c5da' }
        'associatedName' { 'f7fbfc45-85ab-42a4-a435-780e62f7858b' }
        'Assoc-NT-Account' { '398f63c0-ca60-11d1-bbd1-0000f81f10c0' }
        'attributeCertificateAttribute' { 'fa4693bb-7bc2-4cb9-81a8-c99c43b7905e' }
        'Attribute-Display-Names' { 'cb843f80-48d9-11d1-a9c3-0000f80367c1' }
        'Attribute-ID' { 'bf967922-0de6-11d0-a285-00aa003049e2' }
        'Attribute-Schema' { 'bf967a80-0de6-11d0-a285-00aa003049e2' }
        'Attribute-Security-GUID' { 'bf967924-0de6-11d0-a285-00aa003049e2' }
        'Attribute-Syntax' { 'bf967925-0de6-11d0-a285-00aa003049e2' }
        'Attribute-Types' { '9a7ad944-ca53-11d1-bbd0-0080c76670c0' }
        'audio' { 'd0e1d224-e1a0-42ce-a2da-793ba5244f35' }
        'Auditing-Policy' { '6da8a4fe-0e52-11d0-a286-00aa003049e2' }
        'Authentication-Options' { 'bf967928-0de6-11d0-a285-00aa003049e2' }
        'Authority-Revocation-List' { '1677578d-47f3-11d1-a9c3-0000f80367c1' }
        'Auxiliary-Class' { 'bf96792c-0de6-11d0-a285-00aa003049e2' }
        'Bad-Password-Time' { 'bf96792d-0de6-11d0-a285-00aa003049e2' }
        'Bad-Pwd-Count' { 'bf96792e-0de6-11d0-a285-00aa003049e2' }
        'Birth-Location' { '1f0075f9-7e40-11d0-afd6-00c04fd930c9' }
        'BootableDevice' { '4bcb2477-4bb3-4545-a9fc-fb66e136b435' }
        'BootFile' { 'e3f3cb4e-0f20-42eb-9703-d2ff26e52667' }
        'BootParameter' { 'd72a0750-8c7c-416e-8714-e65f11e908be' }
        'Bridgehead-Server-List-BL' { 'd50c2cdb-8951-11d1-aebc-0000f80367c1' }
        'Bridgehead-Transport-List' { 'd50c2cda-8951-11d1-aebc-0000f80367c1' }
        'buildingName' { 'f87fa54b-b2c5-4fd7-88c0-daccb21d93c5' }
        'Builtin-Creation-Time' { 'bf96792f-0de6-11d0-a285-00aa003049e2' }
        'Builtin-Domain' { 'bf967a81-0de6-11d0-a285-00aa003049e2' }
        'Builtin-Modified-Count' { 'bf967930-0de6-11d0-a285-00aa003049e2' }
        'Business-Category' { 'bf967931-0de6-11d0-a285-00aa003049e2' }
        'Bytes-Per-Minute' { 'ba305f76-47e3-11d0-a1a6-00c04fd930c9' }
        'CA-Certificate' { 'bf967932-0de6-11d0-a285-00aa003049e2' }
        'CA-Certificate-DN' { '963d2740-48be-11d1-a9c3-0000f80367c1' }
        'CA-Connect' { '963d2735-48be-11d1-a9c3-0000f80367c1' }
        'Canonical-Name' { '9a7ad945-ca53-11d1-bbd0-0080c76670c0' }
        'Can-Upgrade-Script' { 'd9e18314-8939-11d1-aebc-0000f80367c1' }
        'carLicense' { 'd4159c92-957d-4a87-8a67-8d2934e01649' }
        'Catalogs' { '7bfdcb81-4807-11d1-a9c3-0000f80367c1' }
        'Categories' { '7bfdcb7e-4807-11d1-a9c3-0000f80367c1' }
        'Category-Id' { '7d6c0e94-7e20-11d0-afd6-00c04fd930c9' }
        'Category-Registration' { '7d6c0e9d-7e20-11d0-afd6-00c04fd930c9' }
        'CA-Usages' { '963d2738-48be-11d1-a9c3-0000f80367c1' }
        'CA-WEB-URL' { '963d2736-48be-11d1-a9c3-0000f80367c1' }
        'Certificate-Authority-Object' { '963d2732-48be-11d1-a9c3-0000f80367c1' }
        'Certificate-Revocation-List' { '1677579f-47f3-11d1-a9c3-0000f80367c1' }
        'Certificate-Templates' { '2a39c5b1-8960-11d1-aebc-0000f80367c1' }
        'Certification-Authority' { '3fdfee50-47f4-11d1-a9c3-0000f80367c1' }
        'Class-Display-Name' { '548e1c22-dea6-11d0-b010-0000f80367c1' }
        'Class-Registration' { 'bf967a82-0de6-11d0-a285-00aa003049e2' }
        'Class-Schema' { 'bf967a83-0de6-11d0-a285-00aa003049e2' }
        'Class-Store' { 'bf967a84-0de6-11d0-a285-00aa003049e2' }
        'Code-Page' { 'bf967938-0de6-11d0-a285-00aa003049e2' }
        'COM-ClassID' { 'bf96793b-0de6-11d0-a285-00aa003049e2' }
        'COM-CLSID' { '281416d9-1968-11d0-a28f-00aa003049e2' }
        'Com-Connection-Point' { 'bf967a85-0de6-11d0-a285-00aa003049e2' }
        'COM-InterfaceID' { 'bf96793c-0de6-11d0-a285-00aa003049e2' }
        'Comment' { 'bf96793e-0de6-11d0-a285-00aa003049e2' }
        'Common-Name' { 'bf96793f-0de6-11d0-a285-00aa003049e2' }
        'COM-Other-Prog-Id' { '281416dd-1968-11d0-a28f-00aa003049e2' }
        'Company' { 'f0f8ff88-1191-11d0-a060-00aa006c33ed' }
        'COM-ProgID' { 'bf96793d-0de6-11d0-a285-00aa003049e2' }
        'Computer' { 'bf967a86-0de6-11d0-a285-00aa003049e2' }
        'COM-Treat-As-Class-Id' { '281416db-1968-11d0-a28f-00aa003049e2' }
        'COM-Typelib-Id' { '281416de-1968-11d0-a28f-00aa003049e2' }
        'COM-Unique-LIBID' { '281416da-1968-11d0-a28f-00aa003049e2' }
        'Configuration' { 'bf967a87-0de6-11d0-a285-00aa003049e2' }
        'Connection-Point' { '5cb41ecf-0e4c-11d0-a286-00aa003049e2' }
        'Contact' { '5cb41ed0-0e4c-11d0-a286-00aa003049e2' }
        'Container' { 'bf967a8b-0de6-11d0-a285-00aa003049e2' }
        'Content-Indexing-Allowed' { 'bf967943-0de6-11d0-a285-00aa003049e2' }
        'Context-Menu' { '4d8601ee-ac85-11d0-afe3-00c04fd930c9' }
        'Control-Access-Right' { '8297931e-86d3-11d0-afda-00c04fd930c9' }
        'Control-Access-Rights' { '6da8a4fc-0e52-11d0-a286-00aa003049e2' }
        'Cost' { 'bf967944-0de6-11d0-a285-00aa003049e2' }
        'Country' { 'bf967a8c-0de6-11d0-a285-00aa003049e2' }
        'Country-Code' { '5fd42471-1262-11d0-a060-00aa006c33ed' }
        'Country-Name' { 'bf967945-0de6-11d0-a285-00aa003049e2' }
        'Create-Dialog' { '2b09958a-8931-11d1-aebc-0000f80367c1' }
        'Create-Time-Stamp' { '2df90d73-009f-11d2-aa4c-00c04fd7d83a' }
        'Create-Wizard-Ext' { '2b09958b-8931-11d1-aebc-0000f80367c1' }
        'Creation-Time' { 'bf967946-0de6-11d0-a285-00aa003049e2' }
        'Creation-Wizard' { '4d8601ed-ac85-11d0-afe3-00c04fd930c9' }
        'Creator' { '7bfdcb85-4807-11d1-a9c3-0000f80367c1' }
        'CRL-Distribution-Point' { '167758ca-47f3-11d1-a9c3-0000f80367c1' }
        'CRL-Object' { '963d2737-48be-11d1-a9c3-0000f80367c1' }
        'CRL-Partitioned-Revocation-List' { '963d2731-48be-11d1-a9c3-0000f80367c1' }
        'Cross-Certificate-Pair' { '167757b2-47f3-11d1-a9c3-0000f80367c1' }
        'Cross-Ref' { 'bf967a8d-0de6-11d0-a285-00aa003049e2' }
        'Cross-Ref-Container' { 'ef9e60e0-56f7-11d1-a9c6-0000f80367c1' }
        'Current-Location' { '1f0075fc-7e40-11d0-afd6-00c04fd930c9' }
        'Current-Parent-CA' { '963d273f-48be-11d1-a9c3-0000f80367c1' }
        'Current-Value' { 'bf967947-0de6-11d0-a285-00aa003049e2' }
        'Curr-Machine-Id' { '1f0075fe-7e40-11d0-afd6-00c04fd930c9' }
        'DBCS-Pwd' { 'bf96799c-0de6-11d0-a285-00aa003049e2' }
        'Default-Class-Store' { 'bf967948-0de6-11d0-a285-00aa003049e2' }
        'Default-Group' { '720bc4e2-a54a-11d0-afdf-00c04fd930c9' }
        'Default-Hiding-Value' { 'b7b13116-b82e-11d0-afee-0000f80367c1' }
        'Default-Local-Policy-Object' { 'bf96799f-0de6-11d0-a285-00aa003049e2' }
        'Default-Object-Category' { '26d97367-6070-11d1-a9c6-0000f80367c1' }
        'Default-Priority' { '281416c8-1968-11d0-a28f-00aa003049e2' }
        'Default-Security-Descriptor' { '807a6d30-1669-11d0-a064-00aa006c33ed' }
        'Delta-Revocation-List' { '167757b5-47f3-11d1-a9c3-0000f80367c1' }
        'Department' { 'bf96794f-0de6-11d0-a285-00aa003049e2' }
        'departmentNumber' { 'be9ef6ee-cbc7-4f22-b27b-96967e7ee585' }
        'Description' { 'bf967950-0de6-11d0-a285-00aa003049e2' }
        'Desktop-Profile' { 'eea65906-8ac6-11d0-afda-00c04fd930c9' }
        'Destination-Indicator' { 'bf967951-0de6-11d0-a285-00aa003049e2' }
        'Device' { 'bf967a8e-0de6-11d0-a285-00aa003049e2' }
        'Dfs-Configuration' { '8447f9f2-1027-11d0-a05f-00aa006c33ed' }
        'DHCP-Class' { '963d2756-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Classes' { '963d2750-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Flags' { '963d2741-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Identification' { '963d2742-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Mask' { '963d2747-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-MaxKey' { '963d2754-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Obj-Description' { '963d2744-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Obj-Name' { '963d2743-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Options' { '963d274f-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Properties' { '963d2753-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Ranges' { '963d2748-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Reservations' { '963d274a-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Servers' { '963d2745-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Sites' { '963d2749-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-State' { '963d2752-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Subnets' { '963d2746-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Type' { '963d273b-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Unique-Key' { '963d273a-48be-11d1-a9c3-0000f80367c1' }
        'dhcp-Update-Time' { '963d2755-48be-11d1-a9c3-0000f80367c1' }
        'Display-Name' { 'bf967953-0de6-11d0-a285-00aa003049e2' }
        'Display-Name-Printable' { 'bf967954-0de6-11d0-a285-00aa003049e2' }
        'Display-Specifier' { 'e0fa1e8a-9b45-11d0-afdd-00c04fd930c9' }
        'Display-Template' { '5fd4250c-1262-11d0-a060-00aa006c33ed' }
        'DIT-Content-Rules' { '9a7ad946-ca53-11d1-bbd0-0080c76670c0' }
        'Division' { 'fe6136a0-2073-11d0-a9c2-00aa006c33ed' }
        'DMD' { 'bf967a8f-0de6-11d0-a285-00aa003049e2' }
        'DMD-Location' { 'f0f8ff8b-1191-11d0-a060-00aa006c33ed' }
        'DMD-Name' { '167757b9-47f3-11d1-a9c3-0000f80367c1' }
        'DN-Reference-Update' { '2df90d86-009f-11d2-aa4c-00c04fd7d83a' }
        'Dns-Allow-Dynamic' { 'e0fa1e65-9b45-11d0-afdd-00c04fd930c9' }
        'Dns-Allow-XFR' { 'e0fa1e66-9b45-11d0-afdd-00c04fd930c9' }
        'DNS-Host-Name' { '72e39547-7b18-11d1-adef-00c04fd8d5cd' }
        'Dns-Node' { 'e0fa1e8c-9b45-11d0-afdd-00c04fd930c9' }
        'Dns-Notify-Secondaries' { 'e0fa1e68-9b45-11d0-afdd-00c04fd930c9' }
        'DNS-Property' { '675a15fe-3b70-11d2-90cc-00c04fd91ab1' }
        'Dns-Record' { 'e0fa1e69-9b45-11d0-afdd-00c04fd930c9' }
        'Dns-Root' { 'bf967959-0de6-11d0-a285-00aa003049e2' }
        'Dns-Secure-Secondaries' { 'e0fa1e67-9b45-11d0-afdd-00c04fd930c9' }
        'DNS-Tombstoned' { 'd5eb2eb7-be4e-463b-a214-634a44d7392e' }
        'Dns-Zone' { 'e0fa1e8b-9b45-11d0-afdd-00c04fd930c9' }
        'Dns-Zone-Scope' { '696f8a61-2d3f-40ce-a4b3-e275dfcc49c5' }
        'Dns-Zone-Scope-Container' { 'f2699093-f25a-4220-9deb-03df4cc4a9c5' }
        'document' { '39bad96d-c2d6-4baf-88ab-7e4207600117' }
        'documentAuthor' { 'f18a8e19-af5f-4478-b096-6f35c27eb83f' }
        'documentIdentifier' { '0b21ce82-ff63-46d9-90fb-c8b9f24e97b9' }
        'documentLocation' { 'b958b14e-ac6d-4ec4-8892-be70b69f7281' }
        'documentPublisher' { '170f09d7-eb69-448a-9a30-f1afecfd32d7' }
        'documentSeries' { '7a2be07c-302f-4b96-bc90-0795d66885f8' }
        'documentTitle' { 'de265a9c-ff2c-47b9-91dc-6e6fe2c43062' }
        'documentVersion' { '94b3a8a9-d613-4cec-9aad-5fbcc1046b43' }
        'Domain' { '19195a5a-6da0-11d0-afd3-00c04fd930c9' }
        'Domain-Certificate-Authorities' { '7bfdcb7a-4807-11d1-a9c3-0000f80367c1' }
        'Domain-Component' { '19195a55-6da0-11d0-afd3-00c04fd930c9' }
        'Domain-Cross-Ref' { 'b000ea7b-a086-11d0-afdd-00c04fd930c9' }
        'Domain-DNS' { '19195a5b-6da0-11d0-afd3-00c04fd930c9' }
        'Domain-ID' { '963d2734-48be-11d1-a9c3-0000f80367c1' }
        'Domain-Identifier' { '7f561278-5301-11d1-a9c5-0000f80367c1' }
        'Domain-Policy' { 'bf967a99-0de6-11d0-a285-00aa003049e2' }
        'Domain-Policy-Object' { 'bf96795d-0de6-11d0-a285-00aa003049e2' }
        'Domain-Policy-Reference' { '80a67e2a-9f22-11d0-afdd-00c04fd930c9' }
        'domainRelatedObject' { '8bfd2d3d-efda-4549-852c-f85e137aedc6' }
        'Domain-Replica' { 'bf96795e-0de6-11d0-a285-00aa003049e2' }
        'Domain-Wide-Policy' { '80a67e29-9f22-11d0-afdd-00c04fd930c9' }
        'drink' { '1a1aa5b5-262e-4df6-af04-2cf6b0d80048' }
        'Driver-Name' { '281416c5-1968-11d0-a28f-00aa003049e2' }
        'Driver-Version' { 'ba305f6e-47e3-11d0-a1a6-00c04fd930c9' }
        'DSA' { '3fdfee52-47f4-11d1-a9c3-0000f80367c1' }
        'DSA-Signature' { '167757bc-47f3-11d1-a9c3-0000f80367c1' }
        'DS-Core-Propagation-Data' { 'd167aa4b-8b08-11d2-9939-0000f87a57d4' }
        'DS-Heuristics' { 'f0f8ff86-1191-11d0-a060-00aa006c33ed' }
        'DS-UI-Admin-Maximum' { 'ee8d0ae0-6f91-11d2-9905-0000f87a57d4' }
        'DS-UI-Admin-Notification' { 'f6ea0a94-6f91-11d2-9905-0000f87a57d4' }
        'DS-UI-Settings' { '09b10f14-6f93-11d2-9905-0000f87a57d4' }
        'DS-UI-Shell-Maximum' { 'fcca766a-6f91-11d2-9905-0000f87a57d4' }
        'Dynamic-LDAP-Server' { '52458021-ca6a-11d0-afff-0000f80367c1' }
        'Dynamic-Object' { '66d51249-3355-4c1f-b24e-81f252aca23b' }
        'EFSPolicy' { '8e4eb2ec-4712-11d0-a1a0-00c04fd930c9' }
        'E-mail-Addresses' { 'bf967961-0de6-11d0-a285-00aa003049e2' }
        'Employee-ID' { 'bf967962-0de6-11d0-a285-00aa003049e2' }
        'Employee-Number' { 'a8df73ef-c5ea-11d1-bbcb-0080c76670c0' }
        'Employee-Type' { 'a8df73f0-c5ea-11d1-bbcb-0080c76670c0' }
        'Enabled' { 'a8df73f2-c5ea-11d1-bbcb-0080c76670c0' }
        'Enabled-Connection' { 'bf967963-0de6-11d0-a285-00aa003049e2' }
        'Enrollment-Providers' { '2a39c5b3-8960-11d1-aebc-0000f80367c1' }
        'Entry-TTL' { 'd213decc-d81a-4384-aac2-dcfcfd631cf8' }
        'Extended-Attribute-Info' { '9a7ad947-ca53-11d1-bbd0-0080c76670c0' }
        'Extended-Chars-Allowed' { 'bf967966-0de6-11d0-a285-00aa003049e2' }
        'Extended-Class-Info' { '9a7ad948-ca53-11d1-bbd0-0080c76670c0' }
        'Extension-Name' { 'bf967972-0de6-11d0-a285-00aa003049e2' }
        'Extra-Columns' { 'd24e2846-1dd9-4bcf-99d7-a6227cc86da7' }
        'Facsimile-Telephone-Number' { 'bf967974-0de6-11d0-a285-00aa003049e2' }
        'File-Ext-Priority' { 'd9e18315-8939-11d1-aebc-0000f80367c1' }
        'File-Link-Tracking' { 'dd712229-10e4-11d0-a05f-00aa006c33ed' }
        'File-Link-Tracking-Entry' { '8e4eb2ed-4712-11d0-a1a0-00c04fd930c9' }
        'Flags' { 'bf967976-0de6-11d0-a285-00aa003049e2' }
        'Flat-Name' { 'b7b13117-b82e-11d0-afee-0000f80367c1' }
        'Force-Logoff' { 'bf967977-0de6-11d0-a285-00aa003049e2' }
        'Foreign-Identifier' { '3e97891e-8c01-11d0-afda-00c04fd930c9' }
        'Foreign-Security-Principal' { '89e31c12-8530-11d0-afda-00c04fd930c9' }
        'friendlyCountry' { 'c498f152-dc6b-474a-9f52-7cdba3d7d351' }
        'Friendly-Names' { '7bfdcb88-4807-11d1-a9c3-0000f80367c1' }
        'From-Entry' { '9a7ad949-ca53-11d1-bbd0-0080c76670c0' }
        'From-Server' { 'bf967979-0de6-11d0-a285-00aa003049e2' }
        'Frs-Computer-Reference' { '2a132578-9373-11d1-aebc-0000f80367c1' }
        'Frs-Computer-Reference-BL' { '2a132579-9373-11d1-aebc-0000f80367c1' }
        'FRS-Control-Data-Creation' { '2a13257a-9373-11d1-aebc-0000f80367c1' }
        'FRS-Control-Inbound-Backlog' { '2a13257b-9373-11d1-aebc-0000f80367c1' }
        'FRS-Control-Outbound-Backlog' { '2a13257c-9373-11d1-aebc-0000f80367c1' }
        'FRS-Directory-Filter' { '1be8f171-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-DS-Poll' { '1be8f177-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-Extensions' { '52458020-ca6a-11d0-afff-0000f80367c1' }
        'FRS-Fault-Condition' { '1be8f178-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-File-Filter' { '1be8f170-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-Flags' { '2a13257d-9373-11d1-aebc-0000f80367c1' }
        'FRS-Level-Limit' { '5245801e-ca6a-11d0-afff-0000f80367c1' }
        'FRS-Member-Reference' { '2a13257e-9373-11d1-aebc-0000f80367c1' }
        'FRS-Member-Reference-BL' { '2a13257f-9373-11d1-aebc-0000f80367c1' }
        'FRS-Partner-Auth-Level' { '2a132580-9373-11d1-aebc-0000f80367c1' }
        'FRS-Primary-Member' { '2a132581-9373-11d1-aebc-0000f80367c1' }
        'FRS-Replica-Set-GUID' { '5245801a-ca6a-11d0-afff-0000f80367c1' }
        'FRS-Replica-Set-Type' { '26d9736b-6070-11d1-a9c6-0000f80367c1' }
        'FRS-Root-Path' { '1be8f174-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-Root-Security' { '5245801f-ca6a-11d0-afff-0000f80367c1' }
        'FRS-Service-Command' { 'ddac0cee-af8f-11d0-afeb-00c04fd930c9' }
        'FRS-Service-Command-Status' { '2a132582-9373-11d1-aebc-0000f80367c1' }
        'FRS-Staging-Path' { '1be8f175-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-Time-Last-Command' { '2a132583-9373-11d1-aebc-0000f80367c1' }
        'FRS-Time-Last-Config-Change' { '2a132584-9373-11d1-aebc-0000f80367c1' }
        'FRS-Update-Timeout' { '1be8f172-a9ff-11d0-afe2-00c04fd930c9' }
        'FRS-Version' { '2a132585-9373-11d1-aebc-0000f80367c1' }
        'FRS-Version-GUID' { '26d9736c-6070-11d1-a9c6-0000f80367c1' }
        'FRS-Working-Path' { '1be8f173-a9ff-11d0-afe2-00c04fd930c9' }
        'FSMO-Role-Owner' { '66171887-8f3c-11d0-afda-00c04fd930c9' }
        'FT-Dfs' { '8447f9f3-1027-11d0-a05f-00aa006c33ed' }
        'Garbage-Coll-Period' { '5fd424a1-1262-11d0-a060-00aa006c33ed' }
        'Gecos' { 'a3e03f1f-1d55-4253-a0af-30c2a784e46e' }
        'Generated-Connection' { 'bf96797a-0de6-11d0-a285-00aa003049e2' }
        'Generation-Qualifier' { '16775804-47f3-11d1-a9c3-0000f80367c1' }
        'GidNumber' { 'c5b95f0c-ec9e-41c4-849c-b46597ed6696' }
        'Given-Name' { 'f0f8ff8e-1191-11d0-a060-00aa006c33ed' }
        'Global-Address-List' { 'f754c748-06f4-11d2-aa53-00c04fd7d83a' }
        'Global-Address-List2' { '4898f63d-4112-477c-8826-3ca00bd8277d' }
        'Governs-ID' { 'bf96797d-0de6-11d0-a285-00aa003049e2' }
        'GPC-File-Sys-Path' { 'f30e3bc1-9ff0-11d1-b603-0000f80367c1' }
        'GPC-Functionality-Version' { 'f30e3bc0-9ff0-11d1-b603-0000f80367c1' }
        'GPC-Machine-Extension-Names' { '32ff8ecc-783f-11d2-9916-0000f87a57d4' }
        'GPC-User-Extension-Names' { '42a75fc6-783f-11d2-9916-0000f87a57d4' }
        'GPC-WQL-Filter' { '7bd4c7a6-1add-4436-8c04-3999a880154c' }
        'GP-Link' { 'f30e3bbe-9ff0-11d1-b603-0000f80367c1' }
        'GP-Options' { 'f30e3bbf-9ff0-11d1-b603-0000f80367c1' }
        'Group' { 'bf967a9c-0de6-11d0-a285-00aa003049e2' }
        'Group-Attributes' { 'bf96797e-0de6-11d0-a285-00aa003049e2' }
        'Group-Membership-SAM' { 'bf967980-0de6-11d0-a285-00aa003049e2' }
        'Group-Of-Names' { 'bf967a9d-0de6-11d0-a285-00aa003049e2' }
        'groupOfUniqueNames' { '0310a911-93a3-4e21-a7a3-55d85ab2c48b' }
        'Group-Policy-Container' { 'f30e3bc2-9ff0-11d1-b603-0000f80367c1' }
        'Group-Priority' { 'eea65905-8ac6-11d0-afda-00c04fd930c9' }
        'Groups-to-Ignore' { 'eea65904-8ac6-11d0-afda-00c04fd930c9' }
        'Group-Type' { '9a9a021e-4a5b-11d1-a9c3-0000f80367c1' }
        'Has-Master-NCs' { 'bf967982-0de6-11d0-a285-00aa003049e2' }
        'Has-Partial-Replica-NCs' { 'bf967981-0de6-11d0-a285-00aa003049e2' }
        'Help-Data16' { '5fd424a7-1262-11d0-a060-00aa006c33ed' }
        'Help-Data32' { '5fd424a8-1262-11d0-a060-00aa006c33ed' }
        'Help-File-Name' { '5fd424a9-1262-11d0-a060-00aa006c33ed' }
        'Hide-From-AB' { 'ec05b750-a977-4efe-8e8d-ba6c1a6e33a8' }
        'Home-Directory' { 'bf967985-0de6-11d0-a285-00aa003049e2' }
        'Home-Drive' { 'bf967986-0de6-11d0-a285-00aa003049e2' }
        'host' { '6043df71-fa48-46cf-ab7c-cbd54644b22d' }
        'houseIdentifier' { 'a45398b7-c44a-4eb6-82d3-13c10946dbfe' }
        'Icon-Path' { 'f0f8ff83-1191-11d0-a060-00aa006c33ed' }
        'IEEE802Device' { 'a699e529-a637-4b7d-a0fb-5dc466a0b8a7' }
        'Implemented-Categories' { '7d6c0e92-7e20-11d0-afd6-00c04fd930c9' }
        'IndexedScopes' { '7bfdcb87-4807-11d1-a9c3-0000f80367c1' }
        'Index-Server-Catalog' { '7bfdcb8a-4807-11d1-a9c3-0000f80367c1' }
        'inetOrgPerson' { '4828cc14-1437-45bc-9b07-ad6f015e5f28' }
        'Infrastructure-Update' { '2df90d89-009f-11d2-aa4c-00c04fd7d83a' }
        'Initial-Auth-Incoming' { '52458023-ca6a-11d0-afff-0000f80367c1' }
        'Initial-Auth-Outgoing' { '52458024-ca6a-11d0-afff-0000f80367c1' }
        'Initials' { 'f0f8ff90-1191-11d0-a060-00aa006c33ed' }
        'Install-Ui-Level' { '96a7dd64-9118-11d1-aebc-0000f80367c1' }
        'Instance-Type' { 'bf96798c-0de6-11d0-a285-00aa003049e2' }
        'Intellimirror-Group' { '07383086-91df-11d1-aebc-0000f80367c1' }
        'Intellimirror-SCP' { '07383085-91df-11d1-aebc-0000f80367c1' }
        'International-ISDN-Number' { 'bf96798d-0de6-11d0-a285-00aa003049e2' }
        'Inter-Site-Topology-Failover' { 'b7c69e60-2cc7-11d2-854e-00a0c983f608' }
        'Inter-Site-Topology-Generator' { 'b7c69e5e-2cc7-11d2-854e-00a0c983f608' }
        'Inter-Site-Topology-Renew' { 'b7c69e5f-2cc7-11d2-854e-00a0c983f608' }
        'Inter-Site-Transport' { '26d97376-6070-11d1-a9c6-0000f80367c1' }
        'Inter-Site-Transport-Container' { '26d97375-6070-11d1-a9c6-0000f80367c1' }
        'Invocation-Id' { 'bf96798e-0de6-11d0-a285-00aa003049e2' }
        'IpHost' { 'ab911646-8827-4f95-8780-5a8f008eb68f' }
        'IpHostNumber' { 'de8bb721-85dc-4fde-b687-9657688e667e' }
        'IpNetmaskNumber' { '6ff64fcd-462e-4f62-b44a-9a5347659eb9' }
        'IpNetwork' { 'd95836c3-143e-43fb-992a-b057f1ecadf9' }
        'IpNetworkNumber' { '4e3854f4-3087-42a4-a813-bb0c528958d3' }
        'IpProtocol' { '9c2dcbd2-fbf0-4dc7-ace0-8356dcd0f013' }
        'IpProtocolNumber' { 'ebf5c6eb-0e2d-4415-9670-1081993b4211' }
        'Ipsec-Base' { 'b40ff825-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Data' { 'b40ff81f-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Data-Type' { 'b40ff81e-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Filter' { 'b40ff826-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Filter-Reference' { 'b40ff823-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-ID' { 'b40ff81d-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-ISAKMP-Policy' { 'b40ff828-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-ISAKMP-Reference' { 'b40ff820-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Name' { 'b40ff81c-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Negotiation-Policy' { 'b40ff827-427a-11d1-a9c2-0000f80367c1' }
        'IPSEC-Negotiation-Policy-Action' { '07383075-91df-11d1-aebc-0000f80367c1' }
        'Ipsec-Negotiation-Policy-Reference' { 'b40ff822-427a-11d1-a9c2-0000f80367c1' }
        'IPSEC-Negotiation-Policy-Type' { '07383074-91df-11d1-aebc-0000f80367c1' }
        'Ipsec-NFA' { 'b40ff829-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-NFA-Reference' { 'b40ff821-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Owners-Reference' { 'b40ff824-427a-11d1-a9c2-0000f80367c1' }
        'Ipsec-Policy' { 'b7b13121-b82e-11d0-afee-0000f80367c1' }
        'Ipsec-Policy-Reference' { 'b7b13118-b82e-11d0-afee-0000f80367c1' }
        'IpService' { '2517fadf-fa97-48ad-9de6-79ac5721f864' }
        'IpServicePort' { 'ff2daebf-f463-495a-8405-3e483641eaa2' }
        'IpServiceProtocol' { 'cd96ec0b-1ed6-43b4-b26b-f170b645883f' }
        'Is-Critical-System-Object' { '00fbf30d-91fe-11d1-aebc-0000f80367c1' }
        'Is-Defunct' { '28630ebe-41d5-11d1-a9c1-0000f80367c1' }
        'Is-Deleted' { 'bf96798f-0de6-11d0-a285-00aa003049e2' }
        'Is-Ephemeral' { 'f4c453f0-c5f1-11d1-bbcb-0080c76670c0' }
        'Is-Member-Of-DL' { 'bf967991-0de6-11d0-a285-00aa003049e2' }
        'Is-Member-Of-Partial-Attribute-Set' { '19405b9d-3cfa-11d1-a9c0-0000f80367c1' }
        'Is-Privilege-Holder' { '19405b9c-3cfa-11d1-a9c0-0000f80367c1' }
        'Is-Recycled' { '8fb59256-55f1-444b-aacb-f5b482fe3459' }
        'Is-Single-Valued' { 'bf967992-0de6-11d0-a285-00aa003049e2' }
        'jpegPhoto' { 'bac80572-09c4-4fa9-9ae6-7628d7adbe0e' }
        'Keywords' { 'bf967993-0de6-11d0-a285-00aa003049e2' }
        'Knowledge-Information' { '1677581f-47f3-11d1-a9c3-0000f80367c1' }
        'labeledURI' { 'c569bb46-c680-44bc-a273-e6c227d71b45' }
        'Last-Backup-Restoration-Time' { '1fbb0be8-ba63-11d0-afef-0000f80367c1' }
        'Last-Content-Indexed' { 'bf967995-0de6-11d0-a285-00aa003049e2' }
        'Last-Known-Parent' { '52ab8670-5709-11d1-a9c6-0000f80367c1' }
        'Last-Logoff' { 'bf967996-0de6-11d0-a285-00aa003049e2' }
        'Last-Logon' { 'bf967997-0de6-11d0-a285-00aa003049e2' }
        'Last-Logon-Timestamp' { 'c0e20a04-0e5a-4ff3-9482-5efeaecd7060' }
        'Last-Set-Time' { 'bf967998-0de6-11d0-a285-00aa003049e2' }
        'Last-Update-Sequence' { '7d6c0e9c-7e20-11d0-afd6-00c04fd930c9' }
        'LDAP-Admin-Limits' { '7359a352-90f7-11d1-aebc-0000f80367c1' }
        'LDAP-Display-Name' { 'bf96799a-0de6-11d0-a285-00aa003049e2' }
        'LDAP-IPDeny-List' { '7359a353-90f7-11d1-aebc-0000f80367c1' }
        'Leaf' { 'bf967a9e-0de6-11d0-a285-00aa003049e2' }
        'Legacy-Exchange-DN' { '28630ebc-41d5-11d1-a9c1-0000f80367c1' }
        'Licensing-Site-Settings' { '1be8f17d-a9ff-11d0-afe2-00c04fd930c9' }
        'Link-ID' { 'bf96799b-0de6-11d0-a285-00aa003049e2' }
        'Link-Track-Object-Move-Table' { 'ddac0cf5-af8f-11d0-afeb-00c04fd930c9' }
        'Link-Track-OMT-Entry' { 'ddac0cf7-af8f-11d0-afeb-00c04fd930c9' }
        'Link-Track-Secret' { '2ae80fe2-47b4-11d0-a1a4-00c04fd930c9' }
        'Link-Track-Vol-Entry' { 'ddac0cf6-af8f-11d0-afeb-00c04fd930c9' }
        'Link-Track-Volume-Table' { 'ddac0cf4-af8f-11d0-afeb-00c04fd930c9' }
        'Lm-Pwd-History' { 'bf96799d-0de6-11d0-a285-00aa003049e2' }
        'Locale-ID' { 'bf9679a1-0de6-11d0-a285-00aa003049e2' }
        'Locality' { 'bf967aa0-0de6-11d0-a285-00aa003049e2' }
        'Locality-Name' { 'bf9679a2-0de6-11d0-a285-00aa003049e2' }
        'Localization-Display-Id' { 'a746f0d1-78d0-11d2-9916-0000f87a57d4' }
        'Localized-Description' { 'd9e18316-8939-11d1-aebc-0000f80367c1' }
        'Local-Policy-Flags' { 'bf96799e-0de6-11d0-a285-00aa003049e2' }
        'Local-Policy-Reference' { '80a67e4d-9f22-11d0-afdd-00c04fd930c9' }
        'Location' { '09dcb79f-165f-11d0-a064-00aa006c33ed' }
        'Lockout-Duration' { 'bf9679a5-0de6-11d0-a285-00aa003049e2' }
        'Lock-Out-Observation-Window' { 'bf9679a4-0de6-11d0-a285-00aa003049e2' }
        'Lockout-Threshold' { 'bf9679a6-0de6-11d0-a285-00aa003049e2' }
        'Lockout-Time' { '28630ebf-41d5-11d1-a9c1-0000f80367c1' }
        'LoginShell' { 'a553d12c-3231-4c5e-8adf-8d189697721e' }
        'Logo' { 'bf9679a9-0de6-11d0-a285-00aa003049e2' }
        'Logon-Count' { 'bf9679aa-0de6-11d0-a285-00aa003049e2' }
        'Logon-Hours' { 'bf9679ab-0de6-11d0-a285-00aa003049e2' }
        'Logon-Workstation' { 'bf9679ac-0de6-11d0-a285-00aa003049e2' }
        'Lost-And-Found' { '52ab8671-5709-11d1-a9c6-0000f80367c1' }
        'LSA-Creation-Time' { 'bf9679ad-0de6-11d0-a285-00aa003049e2' }
        'LSA-Modified-Count' { 'bf9679ae-0de6-11d0-a285-00aa003049e2' }
        'MacAddress' { 'e6a522dd-9770-43e1-89de-1de5044328f7' }
        'Machine-Architecture' { 'bf9679af-0de6-11d0-a285-00aa003049e2' }
        'Machine-Password-Change-Interval' { 'c9b6358e-bb38-11d0-afef-0000f80367c1' }
        'Machine-Role' { 'bf9679b2-0de6-11d0-a285-00aa003049e2' }
        'Machine-Wide-Policy' { '80a67e4f-9f22-11d0-afdd-00c04fd930c9' }
        'Mail-Recipient' { 'bf967aa1-0de6-11d0-a285-00aa003049e2' }
        'Managed-By' { '0296c120-40da-11d1-a9c0-0000f80367c1' }
        'Managed-Objects' { '0296c124-40da-11d1-a9c0-0000f80367c1' }
        'Manager' { 'bf9679b5-0de6-11d0-a285-00aa003049e2' }
        'MAPI-ID' { 'bf9679b7-0de6-11d0-a285-00aa003049e2' }
        'mapraagentid' { 'b7cc0257-fab1-419b-ab6d-38448b972574' }
        'mapra-agentid' { '1a6662ed-6fba-4419-92fb-a1b62f9a012a' }
        'mapralevel' { 'de203d3e-14d0-42f8-841e-b98a92e9b91e' }
        'mapra-level' { '37a5fa63-65c5-4fa3-aa7d-a31ffa07aa63' }
        'mapramultises' { '41023f18-f4fd-48b0-909e-14e726bb24b8' }
        'mapraroles' { 'c9cf3ffd-e7fb-4fe0-a37d-c12128da4299' }
        'mapra-roles' { '71d44409-ac8c-4511-a113-58bac90785d4' }
        'maprateam' { 'ace829d6-fbc9-4e80-9157-3b985431d6a4' }
        'mapra-team' { '99eb77f9-c57a-414e-a3a6-3803df860554' }
        'Marshalled-Interface' { 'bf9679b9-0de6-11d0-a285-00aa003049e2' }
        'Mastered-By' { 'e48e64e0-12c9-11d3-9102-00c04fd91ab1' }
        'Max-Pwd-Age' { 'bf9679bb-0de6-11d0-a285-00aa003049e2' }
        'Max-Renew-Age' { 'bf9679bc-0de6-11d0-a285-00aa003049e2' }
        'Max-Storage' { 'bf9679bd-0de6-11d0-a285-00aa003049e2' }
        'Max-Ticket-Age' { 'bf9679be-0de6-11d0-a285-00aa003049e2' }
        'May-Contain' { 'bf9679bf-0de6-11d0-a285-00aa003049e2' }
        'Meeting' { '11b6cc94-48c4-11d1-a9c3-0000f80367c1' }
        'meetingAdvertiseScope' { '11b6cc8b-48c4-11d1-a9c3-0000f80367c1' }
        'meetingApplication' { '11b6cc83-48c4-11d1-a9c3-0000f80367c1' }
        'meetingBandwidth' { '11b6cc92-48c4-11d1-a9c3-0000f80367c1' }
        'meetingBlob' { '11b6cc93-48c4-11d1-a9c3-0000f80367c1' }
        'meetingContactInfo' { '11b6cc87-48c4-11d1-a9c3-0000f80367c1' }
        'meetingDescription' { '11b6cc7e-48c4-11d1-a9c3-0000f80367c1' }
        'meetingEndTime' { '11b6cc91-48c4-11d1-a9c3-0000f80367c1' }
        'meetingID' { '11b6cc7c-48c4-11d1-a9c3-0000f80367c1' }
        'meetingIP' { '11b6cc89-48c4-11d1-a9c3-0000f80367c1' }
        'meetingIsEncrypted' { '11b6cc8e-48c4-11d1-a9c3-0000f80367c1' }
        'meetingKeyword' { '11b6cc7f-48c4-11d1-a9c3-0000f80367c1' }
        'meetingLanguage' { '11b6cc84-48c4-11d1-a9c3-0000f80367c1' }
        'meetingLocation' { '11b6cc80-48c4-11d1-a9c3-0000f80367c1' }
        'meetingMaxParticipants' { '11b6cc85-48c4-11d1-a9c3-0000f80367c1' }
        'meetingName' { '11b6cc7d-48c4-11d1-a9c3-0000f80367c1' }
        'meetingOriginator' { '11b6cc86-48c4-11d1-a9c3-0000f80367c1' }
        'meetingOwner' { '11b6cc88-48c4-11d1-a9c3-0000f80367c1' }
        'meetingProtocol' { '11b6cc81-48c4-11d1-a9c3-0000f80367c1' }
        'meetingRating' { '11b6cc8d-48c4-11d1-a9c3-0000f80367c1' }
        'meetingRecurrence' { '11b6cc8f-48c4-11d1-a9c3-0000f80367c1' }
        'meetingScope' { '11b6cc8a-48c4-11d1-a9c3-0000f80367c1' }
        'meetingStartTime' { '11b6cc90-48c4-11d1-a9c3-0000f80367c1' }
        'meetingType' { '11b6cc82-48c4-11d1-a9c3-0000f80367c1' }
        'meetingURL' { '11b6cc8c-48c4-11d1-a9c3-0000f80367c1' }
        'Member' { 'bf9679c0-0de6-11d0-a285-00aa003049e2' }
        'MemberNisNetgroup' { '0f6a17dc-53e5-4be8-9442-8f3ce2f9012a' }
        'MemberUid' { '03dab236-672e-4f61-ab64-f77d2dc2ffab' }
        'MHS-OR-Address' { '0296c122-40da-11d1-a9c0-0000f80367c1' }
        'Min-Pwd-Age' { 'bf9679c2-0de6-11d0-a285-00aa003049e2' }
        'Min-Pwd-Length' { 'bf9679c3-0de6-11d0-a285-00aa003049e2' }
        'Min-Ticket-Age' { 'bf9679c4-0de6-11d0-a285-00aa003049e2' }
        'Modified-Count' { 'bf9679c5-0de6-11d0-a285-00aa003049e2' }
        'Modified-Count-At-Last-Prom' { 'bf9679c6-0de6-11d0-a285-00aa003049e2' }
        'Modify-Time-Stamp' { '9a7ad94a-ca53-11d1-bbd0-0080c76670c0' }
        'Moniker' { 'bf9679c7-0de6-11d0-a285-00aa003049e2' }
        'Moniker-Display-Name' { 'bf9679c8-0de6-11d0-a285-00aa003049e2' }
        'Move-Tree-State' { '1f2ac2c8-3b71-11d2-90cc-00c04fd91ab1' }
        'ms-Authz-Central-Access-Policies' { '555c21c3-a136-455a-9397-796bbd358e25' }
        'ms-Authz-Central-Access-Policy' { 'a5679cb0-6f9d-432c-8b75-1e3e834f02aa' }
        'ms-Authz-Central-Access-Policy-ID' { '62f29b60-be74-4630-9456-2f6691993a86' }
        'ms-Authz-Central-Access-Rule' { '5b4a06dc-251c-4edb-8813-0bdd71327226' }
        'ms-Authz-Central-Access-Rules' { '99bb1b7a-606d-4f8b-800e-e15be554ca8d' }
        'ms-Authz-Effective-Security-Policy' { '07831919-8f94-4fb6-8a42-91545dccdad3' }
        'ms-Authz-Last-Effective-Security-Policy' { '8e1685c6-3e2f-48a2-a58d-5af0ea789fa0' }
        'ms-Authz-Member-Rules-In-Central-Access-Policy' { '57f22f7a-377e-42c3-9872-cec6f21d2e3e' }
        'ms-Authz-Member-Rules-In-Central-Access-Policy-BL' { '516e67cf-fedd-4494-bb3a-bc506a948891' }
        'ms-Authz-Proposed-Security-Policy' { 'b946bece-09b5-4b6a-b25a-4b63a330e80e' }
        'ms-Authz-Resource-Condition' { '80997877-f874-4c68-864d-6e508a83bdbd' }
        'ms-COM-DefaultPartitionLink' { '998b10f7-aa1a-4364-b867-753d197fe670' }
        'ms-COM-ObjectId' { '430f678b-889f-41f2-9843-203b5a65572f' }
        'ms-COM-Partition' { 'c9010e74-4e58-49f7-8a89-5e3e2340fcf8' }
        'ms-COM-PartitionLink' { '09abac62-043f-4702-ac2b-6ca15eee5754' }
        'ms-COM-PartitionSet' { '250464ab-c417-497a-975a-9e0d459a7ca1' }
        'ms-COM-PartitionSetLink' { '67f121dc-7d02-4c7d-82f5-9ad4c950ac34' }
        'ms-COM-UserLink' { '9e6f3a4d-242c-4f37-b068-36b57f9fc852' }
        'ms-COM-UserPartitionSetLink' { '8e940c8a-e477-4367-b08d-ff2ff942dcd7' }
        'Mscope-Id' { '963d2751-48be-11d1-a9c3-0000f80367c1' }
        'ms-DFS-Comment-v2' { 'b786cec9-61fd-4523-b2c1-5ceb3860bb32' }
        'ms-DFS-Deleted-Link-v2' { '25173408-04ca-40e8-865e-3f9ce9bf1bd3' }
        'ms-DFS-Generation-GUID-v2' { '35b8b3d9-c58f-43d6-930e-5040f2f1a781' }
        'ms-DFS-Last-Modified-v2' { '3c095e8a-314e-465b-83f5-ab8277bcf29b' }
        'ms-DFS-Link-Identity-GUID-v2' { 'edb027f3-5726-4dee-8d4e-dbf07e1ad1f1' }
        'ms-DFS-Link-Path-v2' { '86b021f6-10ab-40a2-a252-1dc0cc3be6a9' }
        'ms-DFS-Link-Security-Descriptor-v2' { '57cf87f7-3426-4841-b322-02b3b6e9eba8' }
        'ms-DFS-Link-v2' { '7769fb7a-1159-4e96-9ccd-68bc487073eb' }
        'ms-DFS-Namespace-Anchor' { 'da73a085-6e64-4d61-b064-015d04164795' }
        'ms-DFS-Namespace-Identity-GUID-v2' { '200432ce-ec5f-4931-a525-d7f4afe34e68' }
        'ms-DFS-Namespace-v2' { '21cb8628-f3c3-4bbf-bff6-060b2d8f299a' }
        'ms-DFS-Properties-v2' { '0c3e5bc5-eb0e-40f5-9b53-334e958dffdb' }
        'ms-DFSR-CachePolicy' { 'db7a08e7-fc76-4569-a45f-f5ecb66a88b5' }
        'ms-DFSR-CommonStagingPath' { '936eac41-d257-4bb9-bd55-f310a3cf09ad' }
        'ms-DFSR-CommonStagingSizeInMb' { '135eb00e-4846-458b-8ea2-a37559afd405' }
        'ms-DFSR-ComputerReference' { '6c7b5785-3d21-41bf-8a8a-627941544d5a' }
        'ms-DFSR-ComputerReferenceBL' { '5eb526d7-d71b-44ae-8cc6-95460052e6ac' }
        'ms-DFSR-ConflictPath' { '5cf0bcc8-60f7-4bff-bda6-aea0344eb151' }
        'ms-DFSR-ConflictSizeInMb' { '9ad33fc9-aacf-4299-bb3e-d1fc6ea88e49' }
        'ms-DFSR-Connection' { 'e58f972e-64b5-46ef-8d8b-bbc3e1897eab' }
        'ms-DFSR-Content' { '64759b35-d3a1-42e4-b5f1-a3de162109b3' }
        'ms-DFSR-ContentSet' { '4937f40d-a6dc-4d48-97ca-06e5fbfd3f16' }
        'ms-DFSR-ContentSetGuid' { '1035a8e1-67a8-4c21-b7bb-031cdf99d7a0' }
        'ms-DFSR-DefaultCompressionExclusionFilter' { '87811bd5-cd8b-45cb-9f5d-980f3a9e0c97' }
        'ms-DFSR-DeletedPath' { '817cf0b8-db95-4914-b833-5a079ef65764' }
        'ms-DFSR-DeletedSizeInMb' { '53ed9ad1-9975-41f4-83f5-0c061a12553a' }
        'ms-DFSR-DfsLinkTarget' { 'f7b85ba9-3bf9-428f-aab4-2eee6d56f063' }
        'ms-DFSR-DfsPath' { '2cc903e2-398c-443b-ac86-ff6b01eac7ba' }
        'ms-DFSR-DirectoryFilter' { '93c7b477-1f2e-4b40-b7bf-007e8d038ccf' }
        'ms-DFSR-DisablePacketPrivacy' { '6a84ede5-741e-43fd-9dd6-aa0f61578621' }
        'ms-DFSR-Enabled' { '03726ae7-8e7d-4446-8aae-a91657c00993' }
        'ms-DFSR-Extension' { '78f011ec-a766-4b19-adcf-7b81ed781a4d' }
        'ms-DFSR-FileFilter' { 'd68270ac-a5dc-4841-a6ac-cd68be38c181' }
        'ms-DFSR-Flags' { 'fe515695-3f61-45c8-9bfa-19c148c57b09' }
        'ms-DFSR-GlobalSettings' { '7b35dbad-b3ec-486a-aad4-2fec9d6ea6f6' }
        'ms-DFSR-Keywords' { '048b4692-6227-4b67-a074-c4437083e14b' }
        'ms-DFSR-LocalSettings' { 'fa85c591-197f-477e-83bd-ea5a43df2239' }
        'ms-DFSR-MaxAgeInCacheInMin' { '2ab0e48d-ac4e-4afc-83e5-a34240db6198' }
        'ms-DFSR-Member' { '4229c897-c211-437c-a5ae-dbf705b696e5' }
        'ms-DFSR-MemberReference' { '261337aa-f1c3-44b2-bbea-c88d49e6f0c7' }
        'ms-DFSR-MemberReferenceBL' { 'adde62c6-1880-41ed-bd3c-30b7d25e14f0' }
        'ms-DFSR-MinDurationCacheInMin' { '4c5d607a-ce49-444a-9862-82a95f5d1fcc' }
        'ms-DFSR-OnDemandExclusionDirectoryFilter' { '7d523aff-9012-49b2-9925-f922a0018656' }
        'ms-DFSR-OnDemandExclusionFileFilter' { 'a68359dc-a581-4ee6-9015-5382c60f0fb4' }
        'ms-DFSR-Options' { 'd6d67084-c720-417d-8647-b696237a114c' }
        'ms-DFSR-Options2' { '11e24318-4ca6-4f49-9afe-e5eb1afa3473' }
        'ms-DFSR-Priority' { 'eb20e7d6-32ad-42de-b141-16ad2631b01b' }
        'ms-DFSR-RdcEnabled' { 'e3b44e05-f4a7-4078-a730-f48670a743f8' }
        'ms-DFSR-RdcMinFileSizeInKb' { 'f402a330-ace5-4dc1-8cc9-74d900bf8ae0' }
        'ms-DFSR-ReadOnly' { '5ac48021-e447-46e7-9d23-92c0c6a90dfb' }
        'ms-DFSR-ReplicationGroup' { '1c332fe0-0c2a-4f32-afca-23c5e45a9e77' }
        'ms-DFSR-ReplicationGroupGuid' { '2dad8796-7619-4ff8-966e-0a5cc67b287f' }
        'ms-DFSR-ReplicationGroupType' { 'eeed0fc8-1001-45ed-80cc-bbf744930720' }
        'ms-DFSR-RootFence' { '51928e94-2cd8-4abe-b552-e50412444370' }
        'ms-DFSR-RootPath' { 'd7d5e8c1-e61f-464f-9fcf-20bbe0a2ec54' }
        'ms-DFSR-RootSizeInMb' { '90b769ac-4413-43cf-ad7a-867142e740a3' }
        'ms-DFSR-Schedule' { '4699f15f-a71f-48e2-9ff5-5897c0759205' }
        'ms-DFSR-StagingCleanupTriggerInPercent' { 'd64b9c23-e1fa-467b-b317-6964d744d633' }
        'ms-DFSR-StagingPath' { '86b9a69e-f0a6-405d-99bb-77d977992c2a' }
        'ms-DFSR-StagingSizeInMb' { '250a8f20-f6fc-4559-ae65-e4b24c67aebe' }
        'ms-DFSR-Subscriber' { 'e11505d7-92c4-43e7-bf5c-295832ffc896' }
        'ms-DFSR-Subscription' { '67212414-7bcc-4609-87e0-088dad8abdee' }
        'ms-DFSR-TombstoneExpiryInMin' { '23e35d4c-e324-4861-a22f-e199140dae00' }
        'ms-DFSR-Topology' { '04828aa9-6e42-4e80-b962-e2fe00754d17' }
        'ms-DFSR-Version' { '1a861408-38c3-49ea-ba75-85481a77c655' }
        'ms-DFS-Schema-Major-Version' { 'ec6d7855-704a-4f61-9aa6-c49a7c1d54c7' }
        'ms-DFS-Schema-Minor-Version' { 'fef9a725-e8f1-43ab-bd86-6a0115ce9e38' }
        'ms-DFS-Short-Name-Link-Path-v2' { '2d7826f0-4cf7-42e9-a039-1110e0d9ca99' }
        'ms-DFS-Target-List-v2' { '6ab126c6-fa41-4b36-809e-7ca91610d48f' }
        'ms-DFS-Ttl-v2' { 'ea944d31-864a-4349-ada5-062e2c614f5e' }
        'ms-DNS-DNSKEY-Records' { '28c458f5-602d-4ac9-a77c-b3f1be503a7e' }
        'ms-DNS-DNSKEY-Record-Set-TTL' { '8f4e317f-28d7-442c-a6df-1f491f97b326' }
        'ms-DNS-DS-Record-Algorithms' { '5c5b7ad2-20fa-44bb-beb3-34b9c0f65579' }
        'ms-DNS-DS-Record-Set-TTL' { '29869b7c-64c4-42fe-97d5-fbc2fa124160' }
        'ms-DNS-Is-Signed' { 'aa12854c-d8fc-4d5e-91ca-368b8d829bee' }
        'ms-DNS-Keymaster-Zones' { '0be0dd3b-041a-418c-ace9-2f17d23e9d42' }
        'ms-DNS-Maintain-Trust-Anchor' { '0dc063c1-52d9-4456-9e15-9c2434aafd94' }
        'ms-DNS-NSEC3-Current-Salt' { '387d9432-a6d1-4474-82cd-0a89aae084ae' }
        'ms-DNS-NSEC3-Hash-Algorithm' { 'ff9e5552-7db7-4138-8888-05ce320a0323' }
        'ms-DNS-NSEC3-Iterations' { '80b70aab-8959-4ec0-8e93-126e76df3aca' }
        'ms-DNS-NSEC3-OptOut' { '7bea2088-8ce2-423c-b191-66ec506b1595' }
        'ms-DNS-NSEC3-Random-Salt-Length' { '13361665-916c-4de7-a59d-b1ebbd0de129' }
        'ms-DNS-NSEC3-User-Salt' { 'aff16770-9622-4fbc-a128-3088777605b9' }
        'ms-DNS-Parent-Has-Secure-Delegation' { '285c6964-c11a-499e-96d8-bf7c75a223c6' }
        'ms-DNS-Propagation-Time' { 'ba340d47-2181-4ca0-a2f6-fae4479dab2a' }
        'ms-DNS-RFC5011-Key-Rollovers' { '27d93c40-065a-43c0-bdd8-cdf2c7d120aa' }
        'ms-DNS-Secure-Delegation-Polling-Period' { 'f6b0f0be-a8e4-4468-8fd9-c3c47b8722f9' }
        'ms-DNS-Server-Settings' { 'ef2fc3ed-6e18-415b-99e4-3114a8cb124b' }
        'ms-DNS-Signature-Inception-Offset' { '03d4c32e-e217-4a61-9699-7bbc4729a026' }
        'ms-DNS-Signing-Key-Descriptors' { '3443d8cd-e5b6-4f3b-b098-659a0214a079' }
        'ms-DNS-Signing-Keys' { 'b7673e6d-cad9-4e9e-b31a-63e8098fdd63' }
        'ms-DNS-Sign-With-NSEC3' { 'c79f2199-6da1-46ff-923c-1f3f800c721e' }
        'MS-DRM-Identity-Certificate' { 'e85e1204-3434-41ad-9b56-e2901228fff0' }
        'ms-DS-Additional-Dns-Host-Name' { '80863791-dbe9-4eb8-837e-7f0ab55d9ac7' }
        'ms-DS-Additional-Sam-Account-Name' { '975571df-a4d5-429a-9f59-cdc6581d91e6' }
        'ms-DS-Allowed-DNS-Suffixes' { '8469441b-9ac4-4e45-8205-bd219dbf672d' }
        'ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity' { '3f78c3e5-f79a-46bd-a0b8-9d18116ddc79' }
        'ms-DS-Allowed-To-Delegate-To' { '800d94d7-b7a1-42a1-b14d-7cae1423d07f' }
        'MS-DS-All-Users-Trust-Quota' { 'd3aa4a5c-4e03-4810-97aa-2b339e7a434b' }
        'ms-DS-App-Configuration' { '90df3c3e-1854-4455-a5d7-cad40d56657a' }
        'ms-DS-App-Data' { '9e67d761-e327-4d55-bc95-682f875e2f8e' }
        'ms-DS-Applies-To-Resource-Types' { '693f2006-5764-3d4a-8439-58f04aab4b59' }
        'ms-DS-Approximate-Last-Logon-Time-Stamp' { 'a34f983b-84c6-4f0c-9050-a3a14a1d35a4' }
        'ms-DS-Approx-Immed-Subordinates' { 'e185d243-f6ce-4adb-b496-b0c005d7823c' }
        'ms-DS-Assigned-AuthN-Policy' { 'b87a0ad8-54f7-49c1-84a0-e64d12853588' }
        'ms-DS-Assigned-AuthN-Policy-BL' { '2d131b3c-d39f-4aee-815e-8db4bc1ce7ac' }
        'ms-DS-Assigned-AuthN-Policy-Silo' { 'b23fc141-0df5-4aea-b33d-6cf493077b3f' }
        'ms-DS-Assigned-AuthN-Policy-Silo-BL' { '33140514-f57a-47d2-8ec4-04c4666600c7' }
        'ms-DS-AuthenticatedAt-DC' { '3e1ee99c-6604-4489-89d9-84798a89515a' }
        'ms-DS-AuthenticatedTo-Accountlist' { 'e8b2c971-a6df-47bc-8d6f-62770d527aa5' }
        'ms-DS-AuthN-Policies' { '3a9adf5d-7b97-4f7e-abb4-e5b55c1c06b4' }
        'ms-DS-AuthN-Policy' { 'ab6a1156-4dc7-40f5-9180-8e4ce42fe5cd' }
        'ms-DS-AuthN-Policy-Enforced' { '7a560cc2-ec45-44ba-b2d7-21236ad59fd5' }
        'ms-DS-AuthN-Policy-Silo' { 'f9f0461e-697d-4689-9299-37e61d617b0d' }
        'ms-DS-AuthN-Policy-Silo-Enforced' { 'f2f51102-6be0-493d-8726-1546cdbc8771' }
        'ms-DS-AuthN-Policy-Silo-Members' { '164d1e05-48a6-4886-a8e9-77a2006e3c77' }
        'ms-DS-AuthN-Policy-Silo-Members-BL' { '11fccbc7-fbe4-4951-b4b7-addf6f9efd44' }
        'ms-DS-AuthN-Policy-Silos' { 'd2b1470a-8f84-491e-a752-b401ee00fe5c' }
        'ms-DS-Auxiliary-Classes' { 'c4af1073-ee50-4be0-b8c0-89a41fe99abe' }
        'ms-DS-Az-Admin-Manager' { 'cfee1051-5f28-4bae-a863-5d0cc18a8ed1' }
        'ms-DS-Az-Application' { 'ddf8de9b-cba5-4e12-842e-28d8b66f75ec' }
        'ms-DS-Az-Application-Data' { '503fc3e8-1cc6-461a-99a3-9eee04f402a7' }
        'ms-DS-Az-Application-Name' { 'db5b0728-6208-4876-83b7-95d3e5695275' }
        'ms-DS-Az-Application-Version' { '7184a120-3ac4-47ae-848f-fe0ab20784d4' }
        'ms-DS-Az-Biz-Rule' { '33d41ea8-c0c9-4c92-9494-f104878413fd' }
        'ms-DS-Az-Biz-Rule-Language' { '52994b56-0e6c-4e07-aa5c-ef9d7f5a0e25' }
        'ms-DS-Az-Class-ID' { '013a7277-5c2d-49ef-a7de-b765b36a3f6f' }
        'ms-DS-Az-Domain-Timeout' { '6448f56a-ca70-4e2e-b0af-d20e4ce653d0' }
        'ms-DS-Az-Generate-Audits' { 'f90abab0-186c-4418-bb85-88447c87222a' }
        'ms-DS-Az-Generic-Data' { 'b5f7e349-7a5b-407c-a334-a31c3f538b98' }
        'ms-DS-Az-Last-Imported-Biz-Rule-Path' { '665acb5c-bb92-4dbc-8c59-b3638eab09b3' }
        'ms-DS-Az-LDAP-Query' { '5e53368b-fc94-45c8-9d7d-daf31ee7112d' }
        'ms-DS-Az-Major-Version' { 'cfb9adb7-c4b7-4059-9568-1ed9db6b7248' }
        'ms-DS-Az-Minor-Version' { 'ee85ed93-b209-4788-8165-e702f51bfbf3' }
        'ms-DS-Az-Object-Guid' { '8491e548-6c38-4365-a732-af041569b02c' }
        'ms-DS-Az-Operation' { '860abe37-9a9b-4fa4-b3d2-b8ace5df9ec5' }
        'ms-DS-Az-Operation-ID' { 'a5f3b553-5d76-4cbe-ba3f-4312152cab18' }
        'ms-DS-Az-Role' { '8213eac9-9d55-44dc-925c-e9a52b927644' }
        'ms-DS-Az-Scope' { '4feae054-ce55-47bb-860e-5b12063a51de' }
        'ms-DS-Az-Scope-Name' { '515a6b06-2617-4173-8099-d5605df043c6' }
        'ms-DS-Az-Script-Engine-Cache-Max' { '2629f66a-1f95-4bf3-a296-8e9d7b9e30c8' }
        'ms-DS-Az-Script-Timeout' { '87d0fb41-2c8b-41f6-b972-11fdfd50d6b0' }
        'ms-DS-Az-Task' { '1ed3a473-9b1b-418a-bfa0-3a37b95a5306' }
        'ms-DS-Az-Task-Is-Role-Definition' { '7b078544-6c82-4fe9-872f-ff48ad2b2e26' }
        'ms-DS-Behavior-Version' { 'd31a8757-2447-4545-8081-3bb610cacbf2' }
        'ms-DS-BridgeHead-Servers-Used' { '3ced1465-7b71-2541-8780-1e1ea6243a82' }
        'ms-DS-Byte-Array' { 'f0d8972e-dd5b-40e5-a51d-044c7c17ece7' }
        'ms-DS-Cached-Membership' { '69cab008-cdd4-4bc9-bab8-0ff37efe1b20' }
        'ms-DS-Cached-Membership-Time-Stamp' { '3566bf1f-beee-4dcb-8abe-ef89fcfec6c1' }
        'ms-DS-Claim-Attribute-Source' { 'eebc123e-bae6-4166-9e5b-29884a8b76b0' }
        'ms-DS-Claim-Is-Single-Valued' { 'cd789fb9-96b4-4648-8219-ca378161af38' }
        'ms-DS-Claim-Is-Value-Space-Restricted' { '0c2ce4c7-f1c3-4482-8578-c60d4bb74422' }
        'ms-DS-Claim-Possible-Values' { '2e28edee-ed7c-453f-afe4-93bd86f2174f' }
        'ms-DS-Claim-Shares-Possible-Values-With' { '52c8d13a-ce0b-4f57-892b-18f5a43a2400' }
        'ms-DS-Claim-Shares-Possible-Values-With-BL' { '54d522db-ec95-48f5-9bbd-1880ebbb2180' }
        'ms-DS-Claim-Source' { 'fa32f2a6-f28b-47d0-bf91-663e8f910a72' }
        'ms-DS-Claim-Source-Type' { '92f19c05-8dfa-4222-bbd1-2c4f01487754' }
        'ms-DS-Claims-Transformation-Policies' { 'c8fca9b1-7d88-bb4f-827a-448927710762' }
        'ms-DS-Claims-Transformation-Policy-Type' { '2eeb62b3-1373-fe45-8101-387f1676edc7' }
        'ms-DS-Claim-Type' { '81a3857c-5469-4d8f-aae6-c27699762604' }
        'ms-DS-Claim-Type-Applies-To-Class' { '6afb0e4c-d876-437c-aeb6-c3e41454c272' }
        'ms-DS-Claim-Type-Property-Base' { 'b8442f58-c490-4487-8a9d-d80b883271ad' }
        'ms-DS-Claim-Types' { '36093235-c715-4821-ab6a-b56fb2805a58' }
        'ms-DS-Claim-Value-Type' { 'c66217b9-e48e-47f7-b7d5-6552b8afd619' }
        'ms-DS-Cloud-Anchor' { '78565e80-03d4-4fe3-afac-8c3bca2f3653' }
        'ms-DS-cloudExtensionAttribute1' { '9709eaaf-49da-4db2-908a-0446e5eab844' }
        'ms-DS-cloudExtensionAttribute10' { '670afcb3-13bd-47fc-90b3-0a527ed81ab7' }
        'ms-DS-cloudExtensionAttribute11' { '9e9ebbc8-7da5-42a6-8925-244e12a56e24' }
        'ms-DS-cloudExtensionAttribute12' { '3c01c43d-e10b-4fca-92b2-4cf615d5b09a' }
        'ms-DS-cloudExtensionAttribute13' { '28be464b-ab90-4b79-a6b0-df437431d036' }
        'ms-DS-cloudExtensionAttribute14' { 'cebcb6ba-6e80-4927-8560-98feca086a9f' }
        'ms-DS-cloudExtensionAttribute15' { 'aae4d537-8af0-4daa-9cc6-62eadb84ff03' }
        'ms-DS-cloudExtensionAttribute16' { '9581215b-5196-4053-a11e-6ffcafc62c4d' }
        'ms-DS-cloudExtensionAttribute17' { '3d3c6dda-6be8-4229-967e-2ff5bb93b4ce' }
        'ms-DS-cloudExtensionAttribute18' { '88e73b34-0aa6-4469-9842-6eb01b32a5b5' }
        'ms-DS-cloudExtensionAttribute19' { '0975fe99-9607-468a-8e18-c800d3387395' }
        'ms-DS-cloudExtensionAttribute2' { 'f34ee0ac-c0c1-4ba9-82c9-1a90752f16a5' }
        'ms-DS-cloudExtensionAttribute20' { 'f5446328-8b6e-498d-95a8-211748d5acdc' }
        'ms-DS-cloudExtensionAttribute3' { '82f6c81a-fada-4a0d-b0f7-706d46838eb5' }
        'ms-DS-cloudExtensionAttribute4' { '9cbf3437-4e6e-485b-b291-22b02554273f' }
        'ms-DS-cloudExtensionAttribute5' { '2915e85b-e347-4852-aabb-22e5a651c864' }
        'ms-DS-cloudExtensionAttribute6' { '60452679-28e1-4bec-ace3-712833361456' }
        'ms-DS-cloudExtensionAttribute7' { '4a7c1319-e34e-40c2-9d00-60ff7890f207' }
        'ms-DS-cloudExtensionAttribute8' { '3cd1c514-8449-44ca-81c0-021781800d2a' }
        'ms-DS-cloudExtensionAttribute9' { '0a63e12c-3040-4441-ae26-cd95af0d247e' }
        'ms-DS-Cloud-Extensions' { '641e87a4-8326-4771-ba2d-c706df35e35a' }
        'ms-DS-Cloud-IsEnabled' { '89848328-7c4e-4f6f-a013-28ce3ad282dc' }
        'ms-DS-Cloud-IsManaged' { '5315ba8e-958f-4b52-bd38-1349a304dd63' }
        'ms-DS-Cloud-Issuer-Public-Certificates' { 'a1e8b54f-4bd6-4fd2-98e2-bcee92a55497' }
        'ms-DS-Computer-Allowed-To-Authenticate-To' { '105babe9-077e-4793-b974-ef0410b62573' }
        'ms-DS-Computer-AuthN-Policy' { 'afb863c9-bea3-440f-a9f3-6153cc668929' }
        'ms-DS-Computer-AuthN-Policy-BL' { '2bef6232-30a1-457e-8604-7af6dbf131b8' }
        'ms-DS-Computer-SID' { 'dffbd720-0872-402e-9940-fcd78db049ba' }
        'ms-DS-Computer-TGT-Lifetime' { '2e937524-dfb9-4cac-a436-a5b7da64fd66' }
        'MS-DS-Consistency-Child-Count' { '178b7bc2-b63a-11d2-90e1-00c04fd91ab1' }
        'MS-DS-Consistency-Guid' { '23773dc2-b63a-11d2-90e1-00c04fd91ab1' }
        'MS-DS-Creator-SID' { 'c5e60132-1480-11d3-91c1-0000f87a57d4' }
        'ms-DS-Custom-Key-Information' { 'b6e5e988-e5e4-4c86-a2ae-0dacb970a0e1' }
        'ms-DS-Date-Time' { '234fcbd8-fb52-4908-a328-fd9f6e58e403' }
        'ms-DS-Default-Quota' { '6818f726-674b-441b-8a3a-f40596374cea' }
        'ms-DS-Deleted-Object-Lifetime' { 'a9b38cb6-189a-4def-8a70-0fcfa158148e' }
        'ms-DS-Device' { '5df2b673-6d41-4774-b3e8-d52e8ee9ff99' }
        'ms-DS-Device-Container' { '7c9e8c58-901b-4ea8-b6ec-4eb9e9fc0e11' }
        'ms-DS-Device-DN' { '642c1129-3899-4721-8e21-4839e3988ce5' }
        'ms-DS-Device-ID' { 'c30181c7-6342-41fb-b279-f7c566cbe0a7' }
        'ms-DS-Device-Location' { 'e3fb56c8-5de8-45f5-b1b1-d2b6cd31e762' }
        'ms-DS-Device-MDMStatus' { 'f60a8f96-57c4-422c-a3ad-9e2fa09ce6f7' }
        'ms-DS-Device-Object-Version' { 'ef65695a-f179-4e6a-93de-b01e06681cfb' }
        'ms-DS-Device-OS-Type' { '100e454d-f3bb-4dcb-845f-8d5edc471c59' }
        'ms-DS-Device-OS-Version' { '70fb8c63-5fab-4504-ab9d-14b329a8a7f8' }
        'ms-DS-Device-Physical-IDs' { '90615414-a2a0-4447-a993-53409599b74e' }
        'ms-DS-Device-Registration-Service' { '96bc3a1a-e3d2-49d3-af11-7b0df79d67f5' }
        'ms-DS-Device-Registration-Service-Container' { '310b55ce-3dcd-4392-a96d-c9e35397c24f' }
        'ms-DS-Device-Trust-Type' { 'c4a46807-6adc-4bbb-97de-6bed181a1bfe' }
        'ms-DS-DnsRootAlias' { '2143acca-eead-4d29-b591-85fa49ce9173' }
        'ms-DS-Drs-Farm-ID' { '6055f766-202e-49cd-a8be-e52bb159edfb' }
        'ms-DS-Egress-Claims-Transformation-Policy' { 'c137427e-9a73-b040-9190-1b095bb43288' }
        'ms-DS-Enabled-Feature' { '5706aeaf-b940-4fb2-bcfc-5268683ad9fe' }
        'ms-DS-Enabled-Feature-BL' { 'ce5b01bc-17c6-44b8-9dc1-a9668b00901b' }
        'ms-DS-Entry-Time-To-Die' { 'e1e9bad7-c6dd-4101-a843-794cec85b038' }
        'ms-DS-ExecuteScriptPassword' { '9d054a5a-d187-46c1-9d85-42dfc44a56dd' }
        'ms-DS-Expire-Passwords-On-Smart-Card-Only-Accounts' { '3417ab48-df24-4fb1-80b0-0fcb367e25e3' }
        'ms-DS-External-Directory-Object-Id' { 'bd29bf90-66ad-40e1-887b-10df070419a6' }
        'ms-DS-External-Key' { 'b92fd528-38ac-40d4-818d-0433380837c1' }
        'ms-DS-External-Store' { '604877cd-9cdb-47c7-b03d-3daadb044910' }
        'ms-DS-Failed-Interactive-Logon-Count' { 'dc3ca86f-70ad-4960-8425-a4d6313d93dd' }
        'ms-DS-Failed-Interactive-Logon-Count-At-Last-Successful-Logon' { 'c5d234e5-644a-4403-a665-e26e0aef5e98' }
        'ms-DS-Filter-Containers' { 'fb00dcdf-ac37-483a-9c12-ac53a6603033' }
        'ms-DS-Generation-Id' { '1e5d393d-8cb7-4b4f-840a-973b36cc09c3' }
        'ms-DS-GeoCoordinates-Altitude' { 'a11703b7-5641-4d9c-863e-5fb3325e74e0' }
        'ms-DS-GeoCoordinates-Latitude' { 'dc66d44e-3d43-40f5-85c5-3c12e169927e' }
        'ms-DS-GeoCoordinates-Longitude' { '94c42110-bae4-4cea-8577-af813af5da25' }
        'ms-DS-Group-Managed-Service-Account' { '7b8b558a-93a5-4af7-adca-c017e67f1057' }
        'ms-DS-GroupMSAMembership' { '888eedd6-ce04-df40-b462-b8a50e41ba38' }
        'ms-DS-HAB-Seniority-Index' { 'def449f1-fd3b-4045-98cf-d9658da788b5' }
        'ms-DS-Has-Domain-NCs' { '6f17e347-a842-4498-b8b3-15e007da4fed' }
        'ms-DS-Has-Full-Replica-NCs' { '1d3c2d18-42d0-4868-99fe-0eca1e6fa9f3' }
        'ms-DS-Has-Instantiated-NCs' { '11e9a5bc-4517-4049-af9c-51554fb0fc09' }
        'ms-DS-Has-Master-NCs' { 'ae2de0e2-59d7-4d47-8d47-ed4dfe4357ad' }
        'ms-DS-Host-Service-Account' { '80641043-15a2-40e1-92a2-8ca866f70776' }
        'ms-DS-Host-Service-Account-BL' { '79abe4eb-88f3-48e7-89d6-f4bc7e98c331' }
        'ms-DS-Ingress-Claims-Transformation-Policy' { '86284c08-0c6e-1540-8b15-75147d23d20d' }
        'ms-DS-Integer' { '7bc64cea-c04e-4318-b102-3e0729371a65' }
        'ms-DS-IntId' { 'bc60096a-1b47-4b30-8877-602c93f56532' }
        'ms-DS-Is-Compliant' { '59527d0f-b7c0-4ce2-a1dd-71cef6963292' }
        'ms-DS-Is-Domain-For' { 'ff155a2a-44e5-4de0-8318-13a58988de4f' }
        'ms-DS-Is-Enabled' { '22a95c0e-1f83-4c82-94ce-bea688cfc871' }
        'ms-DS-Is-Full-Replica-For' { 'c8bc72e0-a6b4-48f0-94a5-fd76a88c9987' }
        'ms-DS-isGC' { '1df5cf33-0fe5-499e-90e1-e94b42718a46' }
        'ms-DS-IsManaged' { '60686ace-6c27-43de-a4e5-f00c2f8d3309' }
        'ms-DS-Is-Member-Of-DL-Transitive' { '862166b6-c941-4727-9565-48bfff2941de' }
        'ms-DS-Is-Partial-Replica-For' { '37c94ff6-c6d4-498f-b2f9-c6f7f8647809' }
        'ms-DS-Is-Possible-Values-Present' { '6fabdcda-8c53-204f-b1a4-9df0c67c1eb4' }
        'ms-DS-Is-Primary-Computer-For' { '998c06ac-3f87-444e-a5df-11b03dc8a50c' }
        'ms-DS-isRODC' { 'a8e8aa23-3e67-4af1-9d7a-2f1a1d633ac9' }
        'ms-DS-Issuer-Certificates' { '6b3d6fda-0893-43c4-89fb-1fb52a6616a9' }
        'ms-DS-Issuer-Public-Certificates' { 'b5f1edfe-b4d2-4076-ab0f-6148342b0bf6' }
        'ms-DS-Is-Used-As-Resource-Security-Attribute' { '51c9f89d-4730-468d-a2b5-1d493212d17e' }
        'ms-DS-Is-User-Cachable-At-Rodc' { 'fe01245a-341f-4556-951f-48c033a89050' }
        'ms-DS-Key-Approximate-Last-Logon-Time-Stamp' { '649ac98d-9b9a-4d41-af6b-f616f2a62e4a' }
        'ms-DS-Key-Credential' { 'ee1f5543-7c2e-476a-8b3f-e11f4af6c498' }
        'ms-DS-Key-Credential-Link' { '5b47d60f-6090-40b2-9f37-2a4de88f3063' }
        'ms-DS-Key-Credential-Link-BL' { '938ad788-225f-4eee-93b9-ad24a159e1db' }
        'ms-DS-Key-Id' { 'c294f84b-2fad-4b71-be4c-9fc5701f60ba' }
        'ms-DS-Key-Material' { 'a12e0e9f-dedb-4f31-8f21-1311b958182f' }
        'ms-DS-Key-Principal' { 'bd61253b-9401-4139-a693-356fc400f3ea' }
        'ms-DS-Key-Principal-BL' { 'd1328fbc-8574-4150-881d-0b1088827878' }
        'ms-DS-Key-Usage' { 'de71b44c-29ba-4597-9eca-c3348ace1917' }
        'ms-DS-KeyVersionNumber' { 'c523e9c0-33b5-4ac8-8923-b57b927f42f6' }
        'ms-DS-KrbTgt-Link' { '778ff5c9-6f4e-4b74-856a-d68383313910' }
        'ms-DS-KrbTgt-Link-BL' { '5dd68c41-bfdf-438b-9b5d-39d9618bf260' }
        'ms-DS-Last-Failed-Interactive-Logon-Time' { 'c7e7dafa-10c3-4b8b-9acd-54f11063742e' }
        'ms-DS-Last-Known-RDN' { '8ab15858-683e-466d-877f-d640e1f9a611' }
        'ms-DS-Last-Successful-Interactive-Logon-Time' { '011929e6-8b5d-4258-b64a-00b0b4949747' }
        'ms-DS-Local-Effective-Deletion-Time' { '94f2800c-531f-4aeb-975d-48ac39fd8ca4' }
        'ms-DS-Local-Effective-Recycle-Time' { '4ad6016b-b0d2-4c9b-93b6-5964b17b968c' }
        'ms-DS-Lockout-Duration' { '421f889a-472e-4fe4-8eb9-e1d0bc6071b2' }
        'ms-DS-Lockout-Observation-Window' { 'b05bda89-76af-468a-b892-1be55558ecc8' }
        'ms-DS-Lockout-Threshold' { 'b8c8c35e-4a19-4a95-99d0-69fe4446286f' }
        'ms-DS-Logon-Time-Sync-Interval' { 'ad7940f8-e43a-4a42-83bc-d688e59ea605' }
        'MS-DS-Machine-Account-Quota' { 'd064fb68-1480-11d3-91c1-0000f87a57d4' }
        'ms-DS-ManagedPassword' { 'e362ed86-b728-0842-b27d-2dea7a9df218' }
        'ms-DS-ManagedPasswordId' { '0e78295a-c6d3-0a40-b491-d62251ffa0a6' }
        'ms-DS-ManagedPasswordInterval' { 'f8758ef7-ac76-8843-a2ee-a26b4dcaf409' }
        'ms-DS-ManagedPasswordPreviousId' { 'd0d62131-2d4a-d04f-99d9-1c63646229a4' }
        'ms-DS-Managed-Service-Account' { 'ce206244-5827-4a86-ba1c-1c0c386c1b64' }
        'ms-DS-Mastered-By' { '60234769-4819-4615-a1b2-49d2f119acb5' }
        'ms-DS-Maximum-Password-Age' { 'fdd337f5-4999-4fce-b252-8ff9c9b43875' }
        'ms-DS-Maximum-Registration-Inactivity-Period' { '0a5caa39-05e6-49ca-b808-025b936610e7' }
        'ms-DS-Max-Values' { 'd1e169a4-ebe9-49bf-8fcb-8aef3874592d' }
        'ms-DS-Members-For-Az-Role' { 'cbf7e6cd-85a4-4314-8939-8bfe80597835' }
        'ms-DS-Members-For-Az-Role-BL' { 'ececcd20-a7e0-4688-9ccf-02ece5e287f5' }
        'ms-DS-Members-Of-Resource-Property-List' { '4d371c11-4cad-4c41-8ad2-b180ab2bd13c' }
        'ms-DS-Members-Of-Resource-Property-List-BL' { '7469b704-edb0-4568-a5a5-59f4862c75a7' }
        'ms-DS-Member-Transitive' { 'e215395b-9104-44d9-b894-399ec9e21dfc' }
        'ms-DS-Minimum-Password-Age' { '2a74f878-4d9c-49f9-97b3-6767d1cbd9a3' }
        'ms-DS-Minimum-Password-Length' { 'b21b3439-4c3a-441c-bb5f-08f20e9b315e' }
        'ms-DS-NC-Repl-Cursors' { '8a167ce4-f9e8-47eb-8d78-f7fe80abb2cc' }
        'ms-DS-NC-Replica-Locations' { '97de9615-b537-46bc-ac0f-10720f3909f3' }
        'ms-DS-NC-Repl-Inbound-Neighbors' { '9edba85a-3e9e-431b-9b1a-a5b6e9eda796' }
        'ms-DS-NC-Repl-Outbound-Neighbors' { '855f2ef5-a1c5-4cc4-ba6d-32522848b61f' }
        'ms-DS-NC-RO-Replica-Locations' { '3df793df-9858-4417-a701-735a1ecebf74' }
        'ms-DS-NC-RO-Replica-Locations-BL' { 'f547511c-5b2a-44cc-8358-992a88258164' }
        'ms-DS-NC-Type' { '5a2eacd7-cc2b-48cf-9d9a-b6f1a0024de9' }
        'ms-DS-Never-Reveal-Group' { '15585999-fd49-4d66-b25d-eeb96aba8174' }
        'ms-DS-Non-Members' { 'cafcb1de-f23c-46b5-adf7-1e64957bd5db' }
        'ms-DS-Non-Members-BL' { '2a8c68fc-3a7a-4e87-8720-fe77c51cbe74' }
        'ms-DS-Non-Security-Group-Extra-Classes' { '2de144fc-1f52-486f-bdf4-16fcc3084e54' }
        'ms-DS-Object-Reference' { '638ec2e8-22e7-409c-85d2-11b21bee72de' }
        'ms-DS-Object-Reference-BL' { '2b702515-c1f7-4b3b-b148-c0e4c6ceecb4' }
        'ms-DS-Object-SOA' { '34f6bdf5-2e79-4c3b-8e14-3d93b75aab89' }
        'ms-DS-OIDToGroup-Link' { 'f9c9a57c-3941-438d-bebf-0edaf2aca187' }
        'ms-DS-OIDToGroup-Link-BL' { '1a3d0d20-5844-4199-ad25-0f5039a76ada' }
        'ms-DS-Operations-For-Az-Role' { '93f701be-fa4c-43b6-bc2f-4dbea718ffab' }
        'ms-DS-Operations-For-Az-Role-BL' { 'f85b6228-3734-4525-b6b7-3f3bb220902c' }
        'ms-DS-Operations-For-Az-Task' { '1aacb436-2e9d-44a9-9298-ce4debeb6ebf' }
        'ms-DS-Operations-For-Az-Task-BL' { 'a637d211-5739-4ed1-89b2-88974548bc59' }
        'ms-DS-Optional-Feature' { '44f00041-35af-468b-b20a-6ce8737c580b' }
        'ms-DS-Optional-Feature-Flags' { '8a0560c1-97b9-4811-9db7-dc061598965b' }
        'ms-DS-Optional-Feature-GUID' { '9b88bda8-dd82-4998-a91d-5f2d2baf1927' }
        'ms-DS-Other-Settings' { '79d2f34c-9d7d-42bb-838f-866b3e4400e2' }
        'ms-DS-Parent-Dist-Name' { 'b918fe7d-971a-f404-9e21-9261abec970b' }
        'ms-DS-Password-Complexity-Enabled' { 'db68054b-c9c3-4bf0-b15b-0fb52552a610' }
        'ms-DS-Password-History-Length' { 'fed81bb7-768c-4c2f-9641-2245de34794d' }
        'ms-DS-Password-Reversible-Encryption-Enabled' { '75ccdd8f-af6c-4487-bb4b-69e4d38a959c' }
        'ms-DS-Password-Settings' { '3bcd9db8-f84b-451c-952f-6c52b81f9ec6' }
        'ms-DS-Password-Settings-Container' { '5b06b06a-4cf3-44c0-bd16-43bc10a987da' }
        'ms-DS-Password-Settings-Precedence' { '456374ac-1f0a-4617-93cf-bc55a7c9d341' }
        'MS-DS-Per-User-Trust-Quota' { 'd161adf0-ca24-4993-a3aa-8b2c981302e8' }
        'MS-DS-Per-User-Trust-Tombstones-Quota' { '8b70a6c6-50f9-4fa3-a71e-1ce03040449b' }
        'ms-DS-Phonetic-Company-Name' { '5bd5208d-e5f4-46ae-a514-543bc9c47659' }
        'ms-DS-Phonetic-Department' { '6cd53daf-003e-49e7-a702-6fa896e7a6ef' }
        'ms-DS-Phonetic-Display-Name' { 'e21a94e4-2d66-4ce5-b30d-0ef87a776ff0' }
        'ms-DS-Phonetic-First-Name' { '4b1cba4e-302f-4134-ac7c-f01f6c797843' }
        'ms-DS-Phonetic-Last-Name' { 'f217e4ec-0836-4b90-88af-2f5d4bbda2bc' }
        'ms-DS-Preferred-Data-Location' { 'fa0c8ade-4c94-4610-bace-180efdee2140' }
        'ms-DS-Preferred-GC-Site' { 'd921b50a-0ab2-42cd-87f6-09cf83a91854' }
        'ms-DS-Primary-Computer' { 'a13df4e2-dbb0-4ceb-828b-8b2e143e9e81' }
        'ms-DS-Principal-Name' { '564e9325-d057-c143-9e3b-4f9e5ef46f93' }
        'ms-DS-Promotion-Settings' { 'c881b4e2-43c0-4ebe-b9bb-5250aa9b434c' }
        'ms-DS-PSO-Applied' { '5e6cf031-bda8-43c8-aca4-8fee4127005b' }
        'ms-DS-PSO-Applies-To' { '64c80f48-cdd2-4881-a86d-4e97b6f561fc' }
        'ms-DS-Quota-Amount' { 'fbb9a00d-3a8c-4233-9cf9-7189264903a1' }
        'ms-DS-Quota-Container' { 'da83fc4f-076f-4aea-b4dc-8f4dab9b5993' }
        'ms-DS-Quota-Control' { 'de91fc26-bd02-4b52-ae26-795999e96fc7' }
        'ms-DS-Quota-Effective' { '6655b152-101c-48b4-b347-e1fcebc60157' }
        'ms-DS-Quota-Trustee' { '16378906-4ea5-49be-a8d1-bfd41dff4f65' }
        'ms-DS-Quota-Used' { 'b5a84308-615d-4bb7-b05f-2f1746aa439f' }
        'ms-DS-Registered-Owner' { '617626e9-01eb-42cf-991f-ce617982237e' }
        'ms-DS-Registered-Users' { '0449160c-5a8e-4fc8-b052-01c0f6e48f02' }
        'ms-DS-Registration-Quota' { 'ca3286c2-1f64-4079-96bc-e62b610e730f' }
        'ms-DS-Repl-Attribute-Meta-Data' { 'd7c53242-724e-4c39-9d4c-2df8c9d66c7a' }
        'MS-DS-Replicates-NC-Reason' { '0ea12b84-08b3-11d3-91bc-0000f87a57d4' }
        'ms-DS-ReplicationEpoch' { '08e3aa79-eb1c-45b5-af7b-8f94246c8e41' }
        'ms-DS-Replication-Notify-First-DSA-Delay' { '85abd4f4-0a89-4e49-bdec-6f35bb2562ba' }
        'ms-DS-Replication-Notify-Subsequent-DSA-Delay' { 'd63db385-dd92-4b52-b1d8-0d3ecc0e86b6' }
        'ms-DS-Repl-Value-Meta-Data' { '2f5c8145-e1bd-410b-8957-8bfa81d5acfd' }
        'ms-DS-Repl-Value-Meta-Data-Ext' { '1e02d2ef-44ad-46b2-a67d-9fd18d780bca' }
        'ms-DS-Required-Domain-Behavior-Version' { 'eadd3dfe-ae0e-4cc2-b9b9-5fe5b6ed2dd2' }
        'ms-DS-Required-Forest-Behavior-Version' { '4beca2e8-a653-41b2-8fee-721575474bec' }
        'ms-DS-Resource-Properties' { '7a4a4584-b350-478f-acd6-b4b852d82cc0' }
        'ms-DS-Resource-Property' { '5b283d5e-8404-4195-9339-8450188c501a' }
        'ms-DS-Resource-Property-List' { '72e3d47a-b342-4d45-8f56-baff803cabf9' }
        'ms-DS-Resultant-PSO' { 'b77ea093-88d0-4780-9a98-911f8e8b1dca' }
        'ms-DS-Retired-Repl-NC-Signatures' { 'd5b35506-19d6-4d26-9afb-11357ac99b5e' }
        'ms-DS-Revealed-DSAs' { '94f6f2ac-c76d-4b5e-b71f-f332c3e93c22' }
        'ms-DS-Revealed-List' { 'cbdad11c-7fec-387b-6219-3a0627d9af81' }
        'ms-DS-Revealed-List-BL' { 'aa1c88fd-b0f6-429f-b2ca-9d902266e808' }
        'ms-DS-Revealed-Users' { '185c7821-3749-443a-bd6a-288899071adb' }
        'ms-DS-Reveal-OnDemand-Group' { '303d9f4a-1dd6-4b38-8fc5-33afe8c988ad' }
        'ms-DS-RID-Pool-Allocation-Enabled' { '24977c8c-c1b7-3340-b4f6-2b375eb711d7' }
        'ms-ds-Schema-Extensions' { 'b39a61be-ed07-4cab-9a4a-4963ed0141e1' }
        'ms-DS-SD-Reference-Domain' { '4c51e316-f628-43a5-b06b-ffb695fcb4f3' }
        'ms-DS-Secondary-KrbTgt-Number' { 'aa156612-2396-467e-ad6a-28d23fdb1865' }
        'ms-DS-Security-Group-Extra-Classes' { '4f146ae8-a4fe-4801-a731-f51848a4f4e4' }
        'ms-DS-Service-Allowed-NTLM-Network-Authentication' { '278947b9-5222-435e-96b7-1503858c2b48' }
        'ms-DS-Service-Allowed-To-Authenticate-From' { '97da709a-3716-4966-b1d1-838ba53c3d89' }
        'ms-DS-Service-Allowed-To-Authenticate-To' { 'f2973131-9b4d-4820-b4de-0474ef3b849f' }
        'ms-DS-Service-AuthN-Policy' { '2a6a6d95-28ce-49ee-bb24-6d1fc01e3111' }
        'ms-DS-Service-AuthN-Policy-BL' { '2c1128ec-5aa2-42a3-b32d-f0979ca9fcd2' }
        'ms-DS-Service-TGT-Lifetime' { '5dfe3c20-ca29-407d-9bab-8421e55eb75c' }
        'ms-DS-Settings' { '0e1b47d7-40a3-4b48-8d1b-4cac0c1cdf21' }
        'ms-DS-Shadow-Principal' { '770f4cb3-1643-469c-b766-edd77aa75e14' }
        'ms-DS-Shadow-Principal-Container' { '11f95545-d712-4c50-b847-d2781537c633' }
        'ms-DS-Shadow-Principal-Sid' { '1dcc0722-aab0-4fef-956f-276fe19de107' }
        'ms-DS-Site-Affinity' { 'c17c5602-bcb7-46f0-9656-6370ca884b72' }
        'ms-DS-SiteName' { '98a7f36d-3595-448a-9e6f-6b8965baed9c' }
        'ms-DS-Source-Anchor' { 'b002f407-1340-41eb-bca0-bd7d938e25a9' }
        'ms-DS-Source-Object-DN' { '773e93af-d3b4-48d4-b3f9-06457602d3d0' }
        'ms-DS-SPN-Suffixes' { '789ee1eb-8c8e-4e4c-8cec-79b31b7617b5' }
        'ms-DS-Strong-NTLM-Policy' { 'aacd2170-482a-44c6-b66e-42c2f66a285c' }
        'ms-DS-Supported-Encryption-Types' { '20119867-1d04-4ab7-9371-cfc3d5df0afd' }
        'ms-DS-SyncServerUrl' { 'b7acc3d2-2a74-4fa4-ac25-e63fe8b61218' }
        'ms-DS-Tasks-For-Az-Role' { '35319082-8c4a-4646-9386-c2949d49894d' }
        'ms-DS-Tasks-For-Az-Role-BL' { 'a0dcd536-5158-42fe-8c40-c00a7ad37959' }
        'ms-DS-Tasks-For-Az-Task' { 'b11c8ee2-5fcd-46a7-95f0-f38333f096cf' }
        'ms-DS-Tasks-For-Az-Task-BL' { 'df446e52-b5fa-4ca2-a42f-13f98a526c8f' }
        'ms-DS-TDO-Egress-BL' { 'd5006229-9913-2242-8b17-83761d1e0e5b' }
        'ms-DS-TDO-Ingress-BL' { '5a5661a1-97c6-544b-8056-e430fe7bc554' }
        'ms-DS-Token-Group-Names' { '65650576-4699-4fc9-8d18-26e0cd0137a6' }
        'ms-DS-Token-Group-Names-Global-And-Universal' { 'fa06d1f4-7922-4aad-b79c-b2201f54417c' }
        'ms-DS-Token-Group-Names-No-GC-Acceptable' { '523fc6c8-9af4-4a02-9cd7-3dea129eeb27' }
        'ms-DS-Tombstone-Quota-Factor' { '461744d7-f3b6-45ba-8753-fb9552a5df32' }
        'ms-DS-Top-Quota-Usage' { '7b7cce4f-f1f5-4bb6-b7eb-23504af19e75' }
        'ms-DS-Transformation-Rules' { '55872b71-c4b2-3b48-ae51-4095f91ec600' }
        'ms-DS-Transformation-Rules-Compiled' { '0bb49a10-536b-bc4d-a273-0bab0dd4bd10' }
        'ms-DS-Trust-Forest-Trust-Info' { '29cc866e-49d3-4969-942e-1dbc0925d183' }
        'ms-DS-UpdateScript' { '146eb639-bb9f-4fc1-a825-e29e00c77920' }
        'ms-DS-User-Account-Control-Computed' { '2cc4b836-b63f-4940-8d23-ea7acf06af56' }
        'ms-DS-User-Allowed-NTLM-Network-Authentication' { '7ece040f-9327-4cdc-aad3-037adfe62639' }
        'ms-DS-User-Allowed-To-Authenticate-From' { '2c4c9600-b0e1-447d-8dda-74902257bdb5' }
        'ms-DS-User-Allowed-To-Authenticate-To' { 'de0caa7f-724e-4286-b179-192671efc664' }
        'ms-DS-User-AuthN-Policy' { 'cd26b9f3-d415-442a-8f78-7c61523ee95b' }
        'ms-DS-User-AuthN-Policy-BL' { '2f17faa9-5d47-4b1f-977e-aa52fabe65c8' }
        'ms-DS-User-Password-Expiry-Time-Computed' { 'add5cf10-7b09-4449-9ae6-2534148f8a72' }
        'ms-DS-User-TGT-Lifetime' { '8521c983-f599-420f-b9ab-b1222bdf95c1' }
        'ms-DS-USN-Last-Sync-Success' { '31f7b8b6-c9f8-4f2d-a37b-58a823030331' }
        'ms-DS-Value-Type' { 'e3c27fdf-b01d-4f4e-87e7-056eef0eb922' }
        'ms-DS-Value-Type-Reference' { '78fc5d84-c1dc-3148-8984-58f792d41d3e' }
        'ms-DS-Value-Type-Reference-BL' { 'ab5543ad-23a1-3b45-b937-9b313d5474a8' }
        'ms-Exch-Assistant-Name' { 'a8df7394-c5ea-11d1-bbcb-0080c76670c0' }
        'ms-Exch-Configuration-Container' { 'd03d6858-06f4-11d2-aa53-00c04fd7d83a' }
        'ms-Exch-House-Identifier' { 'a8df7407-c5ea-11d1-bbcb-0080c76670c0' }
        'ms-Exch-LabeledURI' { '16775820-47f3-11d1-a9c3-0000f80367c1' }
        'ms-Exch-Owner-BL' { 'bf9679f4-0de6-11d0-a285-00aa003049e2' }
        'ms-FRS-Hub-Member' { '5643ff81-35b6-4ca9-9512-baf0bd0a2772' }
        'ms-FRS-Topology-Pref' { '92aa27e0-5c50-402d-9ec1-ee847def9788' }
        'ms-FVE-KeyPackage' { '1fd55ea8-88a7-47dc-8129-0daa97186a54' }
        'ms-FVE-RecoveryGuid' { 'f76909bc-e678-47a0-b0b3-f86a0044c06d' }
        'ms-FVE-RecoveryInformation' { 'ea715d30-8f53-40d0-bd1e-6109186d782c' }
        'ms-FVE-RecoveryPassword' { '43061ac1-c8ad-4ccc-b785-2bfac20fc60a' }
        'ms-FVE-VolumeGuid' { '85e5a5cf-dcee-4075-9cfd-ac9db6a2f245' }
        'ms-ieee-80211-Data' { '0e0d0938-2658-4580-a9f6-7a0ac7b566cb' }
        'ms-ieee-80211-Data-Type' { '6558b180-35da-4efe-beed-521f8f48cafb' }
        'ms-ieee-80211-ID' { '7f73ef75-14c9-4c23-81de-dd07a06f9e8b' }
        'ms-ieee-80211-Policy' { '7b9a2d92-b7eb-4382-9772-c3e0f9baaf94' }
        'Msi-File-List' { '7bfdcb7d-4807-11d1-a9c3-0000f80367c1' }
        'ms-IIS-FTP-Dir' { '8a5c99e9-2230-46eb-b8e8-e59d712eb9ee' }
        'ms-IIS-FTP-Root' { '2a7827a4-1483-49a5-9d84-52e3812156b4' }
        'ms-Imaging-Hash-Algorithm' { '8ae70db5-6406-4196-92fe-f3bb557520a7' }
        'ms-Imaging-PostScanProcess' { '1f7c257c-b8a3-4525-82f8-11ccc7bee36e' }
        'ms-Imaging-PSP-Identifier' { '51583ce9-94fa-4b12-b990-304c35b18595' }
        'ms-Imaging-PSPs' { 'a0ed2ac1-970c-4777-848e-ec63a0ec44fc' }
        'ms-Imaging-PSP-String' { '7b6760ae-d6ed-44a6-b6be-9de62c09ec67' }
        'ms-Imaging-Thumbprint-Hash' { '9cdfdbc5-0304-4569-95f6-c4f663fe5ae6' }
        'Msi-Script' { 'd9e18313-8939-11d1-aebc-0000f80367c1' }
        'Msi-Script-Name' { '96a7dd62-9118-11d1-aebc-0000f80367c1' }
        'Msi-Script-Path' { 'bf967937-0de6-11d0-a285-00aa003049e2' }
        'Msi-Script-Size' { '96a7dd63-9118-11d1-aebc-0000f80367c1' }
        'ms-Kds-CreateTime' { 'ae18119f-6390-0045-b32d-97dbc701aef7' }
        'ms-Kds-DomainID' { '96400482-cf07-e94c-90e8-f2efc4f0495e' }
        'ms-Kds-KDF-AlgorithmID' { 'db2c48b2-d14d-ec4e-9f58-ad579d8b440e' }
        'ms-Kds-KDF-Param' { '8a800772-f4b8-154f-b41c-2e4271eff7a7' }
        'ms-Kds-PrivateKey-Length' { '615f42a1-37e7-1148-a0dd-3007e09cfc81' }
        'ms-Kds-Prov-RootKey' { 'aa02fd41-17e0-4f18-8687-b2239649736b' }
        'ms-Kds-Prov-ServerConfiguration' { '5ef243a8-2a25-45a6-8b73-08a71ae677ce' }
        'ms-Kds-PublicKey-Length' { 'e338f470-39cd-4549-ab5b-f69f9e583fe0' }
        'ms-Kds-RootKeyData' { '26627c27-08a2-0a40-a1b1-8dce85b42993' }
        'ms-Kds-SecretAgreement-AlgorithmID' { '1702975d-225e-cb4a-b15d-0daea8b5e990' }
        'ms-Kds-SecretAgreement-Param' { 'd999b030-feed-4975-b807-eba444da79e9' }
        'ms-Kds-UseStartTime' { '6cdc047f-f522-b74a-9a9c-d95ac8cdfda2' }
        'ms-Kds-Version' { 'd5f07340-e6b0-1e4a-97be-0d3318bd9db1' }
        'MSMQ-Authenticate' { '9a0dc326-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Base-Priority' { '9a0dc323-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Computer-Type' { '9a0dc32e-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Computer-Type-Ex' { '18120de8-f4c4-4341-bd95-32eb5bcf7c80' }
        'MSMQ-Configuration' { '9a0dc344-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Cost' { '9a0dc33a-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-CSP-Name' { '9a0dc334-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Custom-Recipient' { '876d6817-35cc-436c-acea-5ef7174dd9be' }
        'MSMQ-Dependent-Client-Service' { '2df90d83-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Dependent-Client-Services' { '2df90d76-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Digests' { '9a0dc33c-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Digests-Mig' { '0f71d8e0-da3b-11d1-90a5-00c04fd91ab1' }
        'MSMQ-Ds-Service' { '2df90d82-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Ds-Services' { '2df90d78-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Encrypt-Key' { '9a0dc331-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Enterprise-Settings' { '9a0dc345-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Foreign' { '9a0dc32f-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Group' { '46b27aac-aafa-4ffb-b773-e5bf621ee87b' }
        'MSMQ-In-Routing-Servers' { '9a0dc32c-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Interval1' { '8ea825aa-3b7b-11d2-90cc-00c04fd91ab1' }
        'MSMQ-Interval2' { '99b88f52-3b7b-11d2-90cc-00c04fd91ab1' }
        'MSMQ-Journal' { '9a0dc321-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Journal-Quota' { '9a0dc324-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Label' { '9a0dc325-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Label-Ex' { '4580ad25-d407-48d2-ad24-43e6e56793d7' }
        'MSMQ-Long-Lived' { '9a0dc335-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Migrated' { '9a0dc33f-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Migrated-User' { '50776997-3c3d-11d2-90cc-00c04fd91ab1' }
        'MSMQ-Multicast-Address' { '1d2f4412-f10d-4337-9b48-6e5b125cd265' }
        'MSMQ-Name-Style' { '9a0dc333-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Nt4-Flags' { 'eb38a158-d57f-11d1-90a2-00c04fd91ab1' }
        'MSMQ-Nt4-Stub' { '6f914be6-d57e-11d1-90a2-00c04fd91ab1' }
        'MSMQ-OS-Type' { '9a0dc330-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Out-Routing-Servers' { '9a0dc32b-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Owner-ID' { '9a0dc328-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Prev-Site-Gates' { '2df90d75-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Privacy-Level' { '9a0dc327-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-QM-ID' { '9a0dc33e-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Queue' { '9a0dc343-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Queue-Journal-Quota' { '8e441266-d57f-11d1-90a2-00c04fd91ab1' }
        'MSMQ-Queue-Name-Ext' { '2df90d87-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Queue-Quota' { '3f6b8e12-d57f-11d1-90a2-00c04fd91ab1' }
        'MSMQ-Queue-Type' { '9a0dc320-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Quota' { '9a0dc322-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Recipient-FormatName' { '3bfe6748-b544-485a-b067-1b310c4334bf' }
        'MSMQ-Routing-Service' { '2df90d81-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Routing-Services' { '2df90d77-009f-11d2-aa4c-00c04fd7d83a' }
        'MSMQ-Secured-Source' { '8bf0221b-7a06-4d63-91f0-1499941813d3' }
        'MSMQ-Services' { '9a0dc33d-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Service-Type' { '9a0dc32d-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Settings' { '9a0dc347-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Sign-Certificates' { '9a0dc33b-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Sign-Certificates-Mig' { '3881b8ea-da3b-11d1-90a5-00c04fd91ab1' }
        'MSMQ-Sign-Key' { '9a0dc332-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-1' { '9a0dc337-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-2' { '9a0dc338-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-Foreign' { 'fd129d8a-d57e-11d1-90a2-00c04fd91ab1' }
        'MSMQ-Site-Gates' { '9a0dc339-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-Gates-Mig' { 'e2704852-3b7b-11d2-90cc-00c04fd91ab1' }
        'MSMQ-Site-ID' { '9a0dc340-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-Link' { '9a0dc346-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Site-Name' { 'ffadb4b2-de39-11d1-90a5-00c04fd91ab1' }
        'MSMQ-Site-Name-Ex' { '422144fa-c17f-4649-94d6-9731ed2784ed' }
        'MSMQ-Sites' { '9a0dc32a-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-Transactional' { '9a0dc329-c100-11d1-bbc5-0080c76670c0' }
        'MSMQ-User-Sid' { 'c58aae32-56f9-11d2-90d0-00c04fd91ab1' }
        'MSMQ-Version' { '9a0dc336-c100-11d1-bbc5-0080c76670c0' }
        'ms-net-ieee-80211-GP-PolicyData' { '9c1495a5-4d76-468e-991e-1433b0a67855' }
        'ms-net-ieee-80211-GP-PolicyGUID' { '35697062-1eaf-448b-ac1e-388e0be4fdee' }
        'ms-net-ieee-80211-GP-PolicyReserved' { '0f69c62e-088e-4ff5-a53a-e923cec07c0a' }
        'ms-net-ieee-80211-GroupPolicy' { '1cb81863-b822-4379-9ea2-5ff7bdc6386d' }
        'ms-net-ieee-8023-GP-PolicyData' { '8398948b-7457-4d91-bd4d-8d7ed669c9f7' }
        'ms-net-ieee-8023-GP-PolicyGUID' { '94a7b05a-b8b2-4f59-9c25-39e69baa1684' }
        'ms-net-ieee-8023-GP-PolicyReserved' { 'd3c527c7-2606-4deb-8cfd-18426feec8ce' }
        'ms-net-ieee-8023-GroupPolicy' { '99a03a6a-ab19-4446-9350-0cb878ed2d9b' }
        'msNPAllowDialin' { 'db0c9085-c1f2-11d1-bbc5-0080c76670c0' }
        'msNPCalledStationID' { 'db0c9089-c1f2-11d1-bbc5-0080c76670c0' }
        'msNPCallingStationID' { 'db0c908a-c1f2-11d1-bbc5-0080c76670c0' }
        'msNPSavedCallingStationID' { 'db0c908e-c1f2-11d1-bbc5-0080c76670c0' }
        'ms-PKI-AccountCredentials' { 'b8dfa744-31dc-4ef1-ac7c-84baf7ef9da7' }
        'ms-PKI-Certificate-Application-Policy' { 'dbd90548-aa37-4202-9966-8c537ba5ce32' }
        'ms-PKI-Certificate-Name-Flag' { 'ea1dddc4-60ff-416e-8cc0-17cee534bce7' }
        'ms-PKI-Certificate-Policy' { '38942346-cc5b-424b-a7d8-6ffd12029c5f' }
        'ms-PKI-Cert-Template-OID' { '3164c36a-ba26-468c-8bda-c1e5cc256728' }
        'ms-PKI-Credential-Roaming-Tokens' { 'b7ff5a38-0818-42b0-8110-d3d154c97f24' }
        'ms-PKI-DPAPIMasterKeys' { 'b3f93023-9239-4f7c-b99c-6745d87adbc2' }
        'ms-PKI-Enrollment-Flag' { 'd15ef7d8-f226-46db-ae79-b34e560bd12c' }
        'ms-PKI-Enrollment-Servers' { 'f22bd38f-a1d0-4832-8b28-0331438886a6' }
        'ms-PKI-Enterprise-Oid' { '37cfd85c-6719-4ad8-8f9e-8678ba627563' }
        'ms-PKI-Key-Recovery-Agent' { '26ccf238-a08e-4b86-9a82-a8c9ac7ee5cb' }
        'ms-PKI-Minimal-Key-Size' { 'e96a63f5-417f-46d3-be52-db7703c503df' }
        'ms-PKI-OID-Attribute' { '8c9e1288-5028-4f4f-a704-76d026f246ef' }
        'ms-PKI-OID-CPS' { '5f49940e-a79f-4a51-bb6f-3d446a54dc6b' }
        'ms-PKI-OID-LocalizedName' { '7d59a816-bb05-4a72-971f-5c1331f67559' }
        'ms-PKI-OID-User-Notice' { '04c4da7a-e114-4e69-88de-e293f2d3b395' }
        'ms-PKI-Private-Key-Flag' { 'bab04ac2-0435-4709-9307-28380e7c7001' }
        'ms-PKI-Private-Key-Recovery-Agent' { '1562a632-44b9-4a7e-a2d3-e426c96a3acc' }
        'ms-PKI-RA-Application-Policies' { '3c91fbbf-4773-4ccd-a87b-85d53e7bcf6a' }
        'ms-PKI-RA-Policies' { 'd546ae22-0951-4d47-817e-1c9f96faad46' }
        'ms-PKI-RA-Signature' { 'fe17e04b-937d-4f7e-8e0e-9292c8d5683e' }
        'ms-PKI-RoamingTimeStamp' { '6617e4ac-a2f1-43ab-b60c-11fbd1facf05' }
        'ms-PKI-Site-Name' { '0cd8711f-0afc-4926-a4b1-09b08d3d436c' }
        'ms-PKI-Supersede-Templates' { '9de8ae7d-7a5b-421d-b5e4-061f79dfd5d7' }
        'ms-PKI-Template-Minor-Revision' { '13f5236c-1884-46b1-b5d0-484e38990d58' }
        'ms-PKI-Template-Schema-Version' { '0c15e9f5-491d-4594-918f-32813a091da9' }
        'ms-Print-ConnectionPolicy' { 'a16f33c7-7fd6-4828-9364-435138fda08d' }
        'msRADIUSCallbackNumber' { 'db0c909c-c1f2-11d1-bbc5-0080c76670c0' }
        'ms-RADIUS-FramedInterfaceId' { 'a6f24a23-d65c-4d65-a64f-35fb6873c2b9' }
        'msRADIUSFramedIPAddress' { 'db0c90a4-c1f2-11d1-bbc5-0080c76670c0' }
        'ms-RADIUS-FramedIpv6Prefix' { 'f63ed610-d67c-494d-87be-cd1e24359a38' }
        'ms-RADIUS-FramedIpv6Route' { '5a5aa804-3083-4863-94e5-018a79a22ec0' }
        'msRADIUSFramedRoute' { 'db0c90a9-c1f2-11d1-bbc5-0080c76670c0' }
        'ms-RADIUS-SavedFramedInterfaceId' { 'a4da7289-92a3-42e5-b6b6-dad16d280ac9' }
        'ms-RADIUS-SavedFramedIpv6Prefix' { '0965a062-b1e1-403b-b48d-5c0eb0e952cc' }
        'ms-RADIUS-SavedFramedIpv6Route' { '9666bb5c-df9d-4d41-b437-2eec7e27c9b3' }
        'msRADIUSServiceType' { 'db0c90b6-c1f2-11d1-bbc5-0080c76670c0' }
        'msRASSavedCallbackNumber' { 'db0c90c5-c1f2-11d1-bbc5-0080c76670c0' }
        'msRASSavedFramedIPAddress' { 'db0c90c6-c1f2-11d1-bbc5-0080c76670c0' }
        'msRASSavedFramedRoute' { 'db0c90c7-c1f2-11d1-bbc5-0080c76670c0' }
        'ms-RRAS-Attribute' { 'f39b98ad-938d-11d1-aebd-0000f80367c1' }
        'ms-RRAS-Vendor-Attribute-Entry' { 'f39b98ac-938d-11d1-aebd-0000f80367c1' }
        'msSFU-30-Aliases' { '20ebf171-c69a-4c31-b29d-dcb837d8912d' }
        'msSFU-30-Crypt-Method' { '4503d2a3-3d70-41b8-b077-dff123c15865' }
        'msSFU-30-Domain-Info' { '36297dce-656b-4423-ab65-dabb2770819e' }
        'msSFU-30-Domains' { '93095ed3-6f30-4bdd-b734-65d569f5f7c9' }
        'msSFU-30-Field-Separator' { 'a2e11a42-e781-4ca1-a7fa-ec307f62b6a1' }
        'msSFU-30-Intra-Field-Separator' { '95b2aef0-27e4-4cb9-880a-a2d9a9ea23b8' }
        'msSFU-30-Is-Valid-Container' { '0dea42f5-278d-4157-b4a7-49b59664915b' }
        'msSFU-30-Key-Attributes' { '32ecd698-ce9e-4894-a134-7ad76b082e83' }
        'msSFU-30-Key-Values' { '37830235-e5e9-46f2-922b-d8d44f03e7ae' }
        'msSFU-30-Mail-Aliases' { 'd6710785-86ff-44b7-85b5-f1f8689522ce' }
        'msSFU-30-Map-Filter' { 'b7b16e01-024f-4e23-ad0d-71f1a406b684' }
        'msSFU-30-Master-Server-Name' { '4cc908a2-9e18-410e-8459-f17cc422020a' }
        'msSFU-30-Max-Gid-Number' { '04ee6aa6-f83b-469a-bf5a-3c00d3634669' }
        'msSFU-30-Max-Uid-Number' { 'ec998437-d944-4a28-8500-217588adfc75' }
        'msSFU-30-Name' { '16c5d1d3-35c2-4061-a870-a5cefda804f0' }
        'msSFU-30-Netgroup-Host-At-Domain' { '97d2bf65-0466-4852-a25a-ec20f57ee36c' }
        'msSFU-30-Netgroup-User-At-Domain' { 'a9e84eed-e630-4b67-b4b3-cad2a82d345e' }
        'msSFU-30-Net-Id' { 'e263192c-2a02-48df-9792-94f2328781a0' }
        'msSFU-30-Network-User' { 'e15334a3-0bf0-4427-b672-11f5d84acc92' }
        'msSFU-30-Nis-Domain' { '9ee3b2e3-c7f3-45f8-8c9f-1382be4984d2' }
        'msSFU-30-NIS-Map-Config' { 'faf733d0-f8eb-4dcf-8d75-f1753af6a50b' }
        'msSFU-30-NSMAP-Field-Position' { '585c9d5e-f599-4f07-9cf9-4373af4b89d3' }
        'msSFU-30-Order-Number' { '02625f05-d1ee-4f9f-b366-55266becb95c' }
        'msSFU-30-Posix-Member' { 'c875d82d-2848-4cec-bb50-3c5486d09d57' }
        'msSFU-30-Posix-Member-Of' { '7bd76b92-3244-438a-ada6-24f5ea34381e' }
        'msSFU-30-Result-Attributes' { 'e167b0b6-4045-4433-ac35-53f972d45cba' }
        'msSFU-30-Search-Attributes' { 'ef9a2df0-2e57-48c8-8950-0cc674004733' }
        'msSFU-30-Search-Container' { '27eebfa2-fbeb-4f8e-aad6-c50247994291' }
        'msSFU-30-Yp-Servers' { '084a944b-e150-4bfe-9345-40e1aedaebba' }
        'ms-SPP-Activation-Object' { '51a0e68c-0dc5-43ca-935d-c1c911bf2ee5' }
        'ms-SPP-Activation-Objects-Container' { 'b72f862b-bb25-4d5d-aa51-62c59bdf90ae' }
        'ms-SPP-Config-License' { '0353c4b5-d199-40b0-b3c5-deb32fd9ec06' }
        'ms-SPP-Confirmation-Id' { '6e8797c4-acda-4a49-8740-b0bd05a9b831' }
        'ms-SPP-CSVLK-Partial-Product-Key' { 'a601b091-8652-453a-b386-87ad239b7c08' }
        'ms-SPP-CSVLK-Pid' { 'b47f510d-6b50-47e1-b556-772c79e4ffc4' }
        'ms-SPP-CSVLK-Sku-Id' { '9684f739-7b78-476d-8d74-31ad7692eef4' }
        'ms-SPP-Installation-Id' { '69bfb114-407b-4739-a213-c663802b3e37' }
        'ms-SPP-Issuance-License' { '1075b3a1-bbaf-49d2-ae8d-c4f25c823303' }
        'ms-SPP-KMS-Ids' { '9b663eda-3542-46d6-9df0-314025af2bac' }
        'ms-SPP-Online-License' { '098f368e-4812-48cd-afb7-a136b96807ed' }
        'ms-SPP-Phone-License' { '67e4d912-f362-4052-8c79-42f45ba7b221' }
        'MS-SQL-Alias' { 'e0c6baae-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-AllowAnonymousSubscription' { 'db77be4a-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-AllowImmediateUpdatingSubscription' { 'c4186b6e-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-AllowKnownPullSubscription' { 'c3bb7054-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-AllowQueuedUpdatingSubscription' { 'c458ca80-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-AllowSnapshotFilesFTPDownloading' { 'c49b8be8-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-AppleTalk' { '8fda89f4-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Applications' { 'fbcda2ea-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Build' { '603e94c4-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-CharacterSet' { '696177a6-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Clustered' { '7778bd90-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-ConnectionURL' { 'a92d23da-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Contact' { '4f6cbdd8-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-CreationDate' { 'ede14754-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Database' { 'd5a0dbdc-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Description' { '8386603c-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-GPSHeight' { 'bcdd4f0e-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-GPSLatitude' { 'b222ba0e-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-GPSLongitude' { 'b7577c94-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-InformationDirectory' { 'd0aedb2e-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-InformationURL' { 'a42cd510-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Keywords' { '01e9a98a-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-Language' { 'c57f72f4-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-LastBackupDate' { 'f2b6abca-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-LastDiagnosticDate' { 'f6d6dd88-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-LastUpdatedDate' { '9fcc43d4-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Location' { '561c9644-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Memory' { '5b5d448c-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-MultiProtocol' { '8157fa38-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Name' { '3532dfd8-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-NamedPipe' { '7b91c840-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-OLAPCube' { '09f0506a-cd28-11d2-9993-0000f87a57d4' }
        'MS-SQL-OLAPDatabase' { '20af031a-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-OLAPServer' { '0c7e18ea-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-PublicationURL' { 'ae0c11b8-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Publisher' { 'c1676858-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-RegisteredOwner' { '48fd44ea-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-ServiceAccount' { '64933a3e-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Size' { 'e9098084-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-SortOrder' { '6ddc42c0-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-SPX' { '86b08004-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-SQLDatabase' { '1d08694a-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-SQLPublication' { '17c2f64e-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-SQLRepository' { '11d43c5c-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-SQLServer' { '05f6c878-ccef-11d2-9993-0000f87a57d4' }
        'MS-SQL-Status' { '9a7d4770-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-TCPIP' { '8ac263a6-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-ThirdParty' { 'c4e311fc-d34b-11d2-999a-0000f87a57d4' }
        'MS-SQL-Type' { 'ca48eba8-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-UnicodeSortOrder' { '72dc918a-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Version' { 'c07cc1d0-ccee-11d2-9993-0000f87a57d4' }
        'MS-SQL-Vines' { '94c56394-ccee-11d2-9993-0000f87a57d4' }
        'ms-TAPI-Conference-Blob' { '4cc4601e-7201-4141-abc8-3e529ae88863' }
        'ms-TAPI-Ip-Address' { 'efd7d7f7-178e-4767-87fa-f8a16b840544' }
        'ms-TAPI-Protocol-Id' { '89c1ebcf-7a5f-41fd-99ca-c900b32299ab' }
        'ms-TAPI-Rt-Conference' { 'ca7b9735-4b2a-4e49-89c3-99025334dc94' }
        'ms-TAPI-Rt-Person' { '53ea1cb5-b704-4df9-818f-5cb4ec86cac1' }
        'ms-TAPI-Unique-Identifier' { '70a4e7ea-b3b9-4643-8918-e6dd2471bfd4' }
        'ms-TPM-Information-Object' { '85045b6a-47a6-4243-a7cc-6890701f662c' }
        'ms-TPM-Information-Objects-Container' { 'e027a8bd-6456-45de-90a3-38593877ee74' }
        'ms-TPM-OwnerInformation' { 'aa4e1a6d-550d-4e05-8c35-4afcb917a9fe' }
        'ms-TPM-Owner-Information-Temp' { 'c894809d-b513-4ff8-8811-f4f43f5ac7bc' }
        'ms-TPM-Srk-Pub-Thumbprint' { '19d706eb-4d76-44a2-85d6-1c342be3be37' }
        'ms-TPM-Tpm-Information-For-Computer' { 'ea1b7b93-5e48-46d5-bc6c-4df4fda78a35' }
        'ms-TPM-Tpm-Information-For-Computer-BL' { '14fa84c9-8ecd-4348-bc91-6d3ced472ab7' }
        'ms-TS-Allow-Logon' { '3a0cd464-bc54-40e7-93ae-a646a6ecc4b4' }
        'ms-TS-Broken-Connection-Action' { '1cf41bba-5604-463e-94d6-1a1287b72ca3' }
        'ms-TS-Connect-Client-Drives' { '23572aaf-29dd-44ea-b0fa-7e8438b9a4a3' }
        'ms-TS-Connect-Printer-Drives' { '8ce6a937-871b-4c92-b285-d99d4036681c' }
        'ms-TS-Default-To-Main-Printer' { 'c0ffe2bd-cacf-4dc7-88d5-61e9e95766f6' }
        'ms-TS-Endpoint-Data' { '40e1c407-4344-40f3-ab43-3625a34a63a2' }
        'ms-TS-Endpoint-Plugin' { '3c08b569-801f-4158-b17b-e363d6ae696a' }
        'ms-TS-Endpoint-Type' { '377ade80-e2d8-46c5-9bcd-6d9dec93b35e' }
        'MS-TS-ExpireDate' { '70004ef5-25c3-446a-97c8-996ae8566776' }
        'MS-TS-ExpireDate2' { '54dfcf71-bc3f-4f0b-9d5a-4b2476bb8925' }
        'MS-TS-ExpireDate3' { '41bc7f04-be72-4930-bd10-1f3439412387' }
        'MS-TS-ExpireDate4' { '5e11dc43-204a-4faf-a008-6863621c6f5f' }
        'ms-TS-Home-Directory' { '5d3510f0-c4e7-4122-b91f-a20add90e246' }
        'ms-TS-Home-Drive' { '5f0a24d9-dffa-4cd9-acbf-a0680c03731e' }
        'ms-TS-Initial-Program' { '9201ac6f-1d69-4dfb-802e-d95510109599' }
        'MS-TS-LicenseVersion' { '0ae94a89-372f-4df2-ae8a-c64a2bc47278' }
        'MS-TS-LicenseVersion2' { '4b0df103-8d97-45d9-ad69-85c3080ba4e7' }
        'MS-TS-LicenseVersion3' { 'f8ba8f81-4cab-4973-a3c8-3a6da62a5e31' }
        'MS-TS-LicenseVersion4' { '70ca5d97-2304-490a-8a27-52678c8d2095' }
        'MS-TSLS-Property01' { '87e53590-971d-4a52-955b-4794d15a84ae' }
        'MS-TSLS-Property02' { '47c77bb0-316e-4e2f-97f1-0d4c48fca9dd' }
        'MS-TS-ManagingLS' { 'f3bcc547-85b0-432c-9ac0-304506bf2c83' }
        'MS-TS-ManagingLS2' { '349f0757-51bd-4fc8-9d66-3eceea8a25be' }
        'MS-TS-ManagingLS3' { 'fad5dcc1-2130-4c87-a118-75322cd67050' }
        'MS-TS-ManagingLS4' { 'f7a3b6a0-2107-4140-b306-75cb521731e5' }
        'ms-TS-Max-Connection-Time' { '1d960ee2-6464-4e95-a781-e3b5cd5f9588' }
        'ms-TS-Max-Disconnection-Time' { '326f7089-53d8-4784-b814-46d8535110d2' }
        'ms-TS-Max-Idle-Time' { 'ff739e9c-6bb7-460e-b221-e250f3de0f95' }
        'ms-TS-Primary-Desktop' { '29259694-09e4-4237-9f72-9306ebe63ab2' }
        'ms-TS-Primary-Desktop-BL' { '9daadc18-40d1-4ed1-a2bf-6b9bf47d3daa' }
        'ms-TS-Profile-Path' { 'e65c30db-316c-4060-a3a0-387b083f09cd' }
        'MS-TS-Property01' { 'faaea977-9655-49d7-853d-f27bb7aaca0f' }
        'MS-TS-Property02' { '3586f6ac-51b7-4978-ab42-f936463198e7' }
        'ms-TS-Reconnection-Action' { '366ed7ca-3e18-4c7f-abae-351a01e4b4f7' }
        'ms-TS-Remote-Control' { '15177226-8642-468b-8c48-03ddfd004982' }
        'ms-TS-Secondary-Desktop-BL' { '34b107af-a00a-455a-b139-dd1a1b12d8af' }
        'ms-TS-Secondary-Desktops' { 'f63aa29a-bb31-48e1-bfab-0a6c5a1d39c2' }
        'ms-TS-Work-Directory' { 'a744f666-3d3c-4cc8-834b-9d4f6f687b8b' }
        'ms-WMI-Author' { '6366c0c1-6972-4e66-b3a5-1d52ad0c0547' }
        'ms-WMI-ChangeDate' { 'f9cdf7a0-ec44-4937-a79b-cd91522b3aa8' }
        'ms-WMI-Class' { '90c1925f-4a24-4b07-b202-be32eb3c8b74' }
        'ms-WMI-ClassDefinition' { '2b9c0ebc-c272-45cb-99d2-4d0e691632e0' }
        'ms-WMI-CreationDate' { '748b0a2e-3351-4b3f-b171-2f17414ea779' }
        'ms-WMI-Genus' { '50c8673a-8f56-4614-9308-9e1340fb9af3' }
        'ms-WMI-ID' { '9339a803-94b8-47f7-9123-a853b9ff7e45' }
        'ms-WMI-int8Default' { 'f4d8085a-8c5b-4785-959b-dc585566e445' }
        'ms-WMI-int8Max' { 'e3d8b547-003d-4946-a32b-dc7cedc96b74' }
        'ms-WMI-int8Min' { 'ed1489d1-54cc-4066-b368-a00daa2664f1' }
        'ms-WMI-int8ValidValues' { '103519a9-c002-441b-981a-b0b3e012c803' }
        'ms-WMI-intDefault' { '1b0c07f8-76dd-4060-a1e1-70084619dc90' }
        'ms-WMI-intFlags1' { '18e006b9-6445-48e3-9dcf-b5ecfbc4df8e' }
        'ms-WMI-intFlags2' { '075a42c9-c55a-45b1-ac93-eb086b31f610' }
        'ms-WMI-intFlags3' { 'f29fa736-de09-4be4-b23a-e734c124bacc' }
        'ms-WMI-intFlags4' { 'bd74a7ac-c493-4c9c-bdfa-5c7b119ca6b2' }
        'ms-WMI-intMax' { 'fb920c2c-f294-4426-8ac1-d24b42aa2bce' }
        'ms-WMI-intMin' { '68c2e3ba-9837-4c70-98e0-f0c33695d023' }
        'ms-WMI-IntRangeParam' { '50ca5d7d-5c8b-4ef3-b9df-5b66d491e526' }
        'ms-WMI-IntSetParam' { '292f0d9a-cf76-42b0-841f-b650f331df62' }
        'ms-WMI-intValidValues' { '6af565f6-a749-4b72-9634-3c5d47e6b4e0' }
        'ms-WMI-MergeablePolicyTemplate' { '07502414-fdca-4851-b04a-13645b11d226' }
        'ms-WMI-Mof' { '6736809f-2064-443e-a145-81262b1f1366' }
        'ms-WMI-Name' { 'c6c8ace5-7e81-42af-ad72-77412c5941c4' }
        'ms-WMI-NormalizedClass' { 'eaba628f-eb8e-4fe9-83fc-693be695559b' }
        'ms-WMI-ObjectEncoding' { '55dd81c9-c312-41f9-a84d-c6adbdf1e8e1' }
        'ms-WMI-Parm1' { '27e81485-b1b0-4a8b-bedd-ce19a837e26e' }
        'ms-WMI-Parm2' { '0003508e-9c42-4a76-a8f4-38bf64bab0de' }
        'ms-WMI-Parm3' { '45958fb6-52bd-48ce-9f9f-c2712d9f2bfc' }
        'ms-WMI-Parm4' { '3800d5a3-f1ce-4b82-a59a-1528ea795f59' }
        'ms-WMI-PolicyTemplate' { 'e2bc80f1-244a-4d59-acc6-ca5c4f82e6e1' }
        'ms-WMI-PolicyType' { '595b2613-4109-4e77-9013-a3bb4ef277c7' }
        'ms-WMI-PropertyName' { 'ab920883-e7f8-4d72-b4a0-c0449897509d' }
        'ms-WMI-Query' { '65fff93e-35e3-45a3-85ae-876c6718297f' }
        'ms-WMI-QueryLanguage' { '7d3cfa98-c17b-4254-8bd7-4de9b932a345' }
        'ms-WMI-RangeParam' { '45fb5a57-5018-4d0f-9056-997c8c9122d9' }
        'ms-WMI-RealRangeParam' { '6afe8fe2-70bc-4cce-b166-a96f7359c514' }
        'ms-WMI-Rule' { '3c7e6f83-dd0e-481b-a0c2-74cd96ef2a66' }
        'ms-WMI-ScopeGuid' { '87b78d51-405f-4b7f-80ed-2bd28786f48d' }
        'ms-WMI-ShadowObject' { 'f1e44bdf-8dd3-4235-9c86-f91f31f5b569' }
        'ms-WMI-SimplePolicyTemplate' { '6cc8b2b5-12df-44f6-8307-e74f5cdee369' }
        'ms-WMI-Som' { 'ab857078-0142-4406-945b-34c9b6b13372' }
        'ms-WMI-SourceOrganization' { '34f7ed6c-615d-418d-aa00-549a7d7be03e' }
        'ms-WMI-stringDefault' { '152e42b6-37c5-4f55-ab48-1606384a9aea' }
        'ms-WMI-StringSetParam' { '0bc579a2-1da7-4cea-b699-807f3b9d63a4' }
        'ms-WMI-stringValidValues' { '37609d31-a2bf-4b58-8f53-2b64e57a076d' }
        'ms-WMI-TargetClass' { '95b6d8d6-c9e8-4661-a2bc-6a5cabc04c62' }
        'ms-WMI-TargetNameSpace' { '1c4ab61f-3420-44e5-849d-8b5dbf60feb7' }
        'ms-WMI-TargetObject' { 'c44f67a5-7de5-4a1f-92d9-662b57364b77' }
        'ms-WMI-TargetPath' { '5006a79a-6bfe-4561-9f52-13cf4dd3e560' }
        'ms-WMI-TargetType' { 'ca2a281e-262b-4ff7-b419-bc123352a4e9' }
        'ms-WMI-UintRangeParam' { 'd9a799b2-cef3-48b3-b5ad-fb85f8dd3214' }
        'ms-WMI-UintSetParam' { '8f4beb31-4e19-46f5-932e-5fa03c339b1d' }
        'ms-WMI-UnknownRangeParam' { 'b82ac26b-c6db-4098-92c6-49c18a3336e1' }
        'ms-WMI-WMIGPO' { '05630000-3927-4ede-bf27-ca91f275c26f' }
        'Must-Contain' { 'bf9679d3-0de6-11d0-a285-00aa003049e2' }
        'Name-Service-Flags' { '80212840-4bdc-11d1-a9c4-0000f80367c1' }
        'NC-Name' { 'bf9679d6-0de6-11d0-a285-00aa003049e2' }
        'NETBIOS-Name' { 'bf9679d8-0de6-11d0-a285-00aa003049e2' }
        'netboot-Allow-New-Clients' { '07383076-91df-11d1-aebc-0000f80367c1' }
        'netboot-Answer-Only-Valid-Clients' { '0738307b-91df-11d1-aebc-0000f80367c1' }
        'netboot-Answer-Requests' { '0738307a-91df-11d1-aebc-0000f80367c1' }
        'netboot-Current-Client-Count' { '07383079-91df-11d1-aebc-0000f80367c1' }
        'Netboot-DUID' { '532570bd-3d77-424f-822f-0d636dc6daad' }
        'Netboot-GUID' { '3e978921-8c01-11d0-afda-00c04fd930c9' }
        'Netboot-Initialization' { '3e978920-8c01-11d0-afda-00c04fd930c9' }
        'netboot-IntelliMirror-OSes' { '0738307e-91df-11d1-aebc-0000f80367c1' }
        'netboot-Limit-Clients' { '07383077-91df-11d1-aebc-0000f80367c1' }
        'netboot-Locally-Installed-OSes' { '07383080-91df-11d1-aebc-0000f80367c1' }
        'Netboot-Machine-File-Path' { '3e978923-8c01-11d0-afda-00c04fd930c9' }
        'netboot-Max-Clients' { '07383078-91df-11d1-aebc-0000f80367c1' }
        'Netboot-Mirror-Data-File' { '2df90d85-009f-11d2-aa4c-00c04fd7d83a' }
        'netboot-New-Machine-Naming-Policy' { '0738307c-91df-11d1-aebc-0000f80367c1' }
        'netboot-New-Machine-OU' { '0738307d-91df-11d1-aebc-0000f80367c1' }
        'netboot-SCP-BL' { '07383082-91df-11d1-aebc-0000f80367c1' }
        'netboot-Server' { '07383081-91df-11d1-aebc-0000f80367c1' }
        'Netboot-SIF-File' { '2df90d84-009f-11d2-aa4c-00c04fd7d83a' }
        'netboot-Tools' { '0738307f-91df-11d1-aebc-0000f80367c1' }
        'Network-Address' { 'bf9679d9-0de6-11d0-a285-00aa003049e2' }
        'Next-Level-Store' { 'bf9679da-0de6-11d0-a285-00aa003049e2' }
        'Next-Rid' { 'bf9679db-0de6-11d0-a285-00aa003049e2' }
        'NisMap' { '7672666c-02c1-4f33-9ecf-f649c1dd9b7c' }
        'NisMapEntry' { '4a95216e-fcc0-402e-b57f-5971626148a9' }
        'NisMapName' { '969d3c79-0e9a-4d95-b0ac-bdde7ff8f3a1' }
        'NisNetgroup' { '72efbf84-6e7b-4a5c-a8db-8a75a7cad254' }
        'NisNetgroupTriple' { 'a8032e74-30ef-4ff5-affc-0fc217783fec' }
        'NisObject' { '904f8a93-4954-4c5f-b1e1-53c097a31e13' }
        'Non-Security-Member' { '52458018-ca6a-11d0-afff-0000f80367c1' }
        'Non-Security-Member-BL' { '52458019-ca6a-11d0-afff-0000f80367c1' }
        'Notification-List' { '19195a56-6da0-11d0-afd3-00c04fd930c9' }
        'NTDS-Connection' { '19195a60-6da0-11d0-afd3-00c04fd930c9' }
        'NTDS-DSA' { 'f0f8ffab-1191-11d0-a060-00aa006c33ed' }
        'NTDS-DSA-RO' { '85d16ec1-0791-4bc8-8ab3-70980602ff8c' }
        'NTDS-Service' { '19195a5f-6da0-11d0-afd3-00c04fd930c9' }
        'NTDS-Site-Settings' { '19195a5d-6da0-11d0-afd3-00c04fd930c9' }
        'NTFRS-Member' { '2a132586-9373-11d1-aebc-0000f80367c1' }
        'NTFRS-Replica-Set' { '5245803a-ca6a-11d0-afff-0000f80367c1' }
        'NTFRS-Settings' { 'f780acc2-56f0-11d1-a9c6-0000f80367c1' }
        'NTFRS-Subscriber' { '2a132588-9373-11d1-aebc-0000f80367c1' }
        'NTFRS-Subscriptions' { '2a132587-9373-11d1-aebc-0000f80367c1' }
        'NT-Group-Members' { 'bf9679df-0de6-11d0-a285-00aa003049e2' }
        'NT-Mixed-Domain' { '3e97891f-8c01-11d0-afda-00c04fd930c9' }
        'Nt-Pwd-History' { 'bf9679e2-0de6-11d0-a285-00aa003049e2' }
        'NT-Security-Descriptor' { 'bf9679e3-0de6-11d0-a285-00aa003049e2' }
        'Obj-Dist-Name' { 'bf9679e4-0de6-11d0-a285-00aa003049e2' }
        'Object-Category' { '26d97369-6070-11d1-a9c6-0000f80367c1' }
        'Object-Class' { 'bf9679e5-0de6-11d0-a285-00aa003049e2' }
        'Object-Class-Category' { 'bf9679e6-0de6-11d0-a285-00aa003049e2' }
        'Object-Classes' { '9a7ad94b-ca53-11d1-bbd0-0080c76670c0' }
        'Object-Count' { '34aaa216-b699-11d0-afee-0000f80367c1' }
        'Object-Guid' { 'bf9679e7-0de6-11d0-a285-00aa003049e2' }
        'Object-Sid' { 'bf9679e8-0de6-11d0-a285-00aa003049e2' }
        'Object-Version' { '16775848-47f3-11d1-a9c3-0000f80367c1' }
        'OEM-Information' { 'bf9679ea-0de6-11d0-a285-00aa003049e2' }
        'OM-Object-Class' { 'bf9679ec-0de6-11d0-a285-00aa003049e2' }
        'OM-Syntax' { 'bf9679ed-0de6-11d0-a285-00aa003049e2' }
        'OMT-Guid' { 'ddac0cf3-af8f-11d0-afeb-00c04fd930c9' }
        'OMT-Indx-Guid' { '1f0075fa-7e40-11d0-afd6-00c04fd930c9' }
        'OncRpc' { 'cadd1e5e-fefc-4f3f-b5a9-70e994204303' }
        'OncRpcNumber' { '966825f5-01d9-4a5c-a011-d15ae84efa55' }
        'Operating-System' { '3e978925-8c01-11d0-afda-00c04fd930c9' }
        'Operating-System-Hotfix' { 'bd951b3c-9c96-11d0-afdd-00c04fd930c9' }
        'Operating-System-Service-Pack' { '3e978927-8c01-11d0-afda-00c04fd930c9' }
        'Operating-System-Version' { '3e978926-8c01-11d0-afda-00c04fd930c9' }
        'Operator-Count' { 'bf9679ee-0de6-11d0-a285-00aa003049e2' }
        'Option-Description' { '963d274d-48be-11d1-a9c3-0000f80367c1' }
        'Options' { '19195a53-6da0-11d0-afd3-00c04fd930c9' }
        'Options-Location' { '963d274e-48be-11d1-a9c3-0000f80367c1' }
        'Organization' { 'bf967aa3-0de6-11d0-a285-00aa003049e2' }
        'Organizational-Person' { 'bf967aa4-0de6-11d0-a285-00aa003049e2' }
        'Organizational-Role' { 'a8df74bf-c5ea-11d1-bbcb-0080c76670c0' }
        'organizationalStatus' { '28596019-7349-4d2f-adff-5a629961f942' }
        'Organizational-Unit' { 'bf967aa5-0de6-11d0-a285-00aa003049e2' }
        'Organizational-Unit-Name' { 'bf9679f0-0de6-11d0-a285-00aa003049e2' }
        'Organization-Name' { 'bf9679ef-0de6-11d0-a285-00aa003049e2' }
        'Original-Display-Table' { '5fd424ce-1262-11d0-a060-00aa006c33ed' }
        'Original-Display-Table-MSDOS' { '5fd424cf-1262-11d0-a060-00aa006c33ed' }
        'Other-Login-Workstations' { 'bf9679f1-0de6-11d0-a285-00aa003049e2' }
        'Other-Mailbox' { '0296c123-40da-11d1-a9c0-0000f80367c1' }
        'Other-Name' { 'bf9679f2-0de6-11d0-a285-00aa003049e2' }
        'Other-Well-Known-Objects' { '1ea64e5d-ac0f-11d2-90df-00c04fd91ab1' }
        'Owner' { 'bf9679f3-0de6-11d0-a285-00aa003049e2' }
        'Package-Flags' { '7d6c0e99-7e20-11d0-afd6-00c04fd930c9' }
        'Package-Name' { '7d6c0e98-7e20-11d0-afd6-00c04fd930c9' }
        'Package-Registration' { 'bf967aa6-0de6-11d0-a285-00aa003049e2' }
        'Package-Type' { '7d6c0e96-7e20-11d0-afd6-00c04fd930c9' }
        'Parent-CA' { '5245801b-ca6a-11d0-afff-0000f80367c1' }
        'Parent-CA-Certificate-Chain' { '963d2733-48be-11d1-a9c3-0000f80367c1' }
        'Parent-GUID' { '2df90d74-009f-11d2-aa4c-00c04fd7d83a' }
        'Partial-Attribute-Deletion-List' { '28630ec0-41d5-11d1-a9c1-0000f80367c1' }
        'Partial-Attribute-Set' { '19405b9e-3cfa-11d1-a9c0-0000f80367c1' }
        'Pek-Key-Change-Interval' { '07383084-91df-11d1-aebc-0000f80367c1' }
        'Pek-List' { '07383083-91df-11d1-aebc-0000f80367c1' }
        'Pending-CA-Certificates' { '963d273c-48be-11d1-a9c3-0000f80367c1' }
        'Pending-Parent-CA' { '963d273e-48be-11d1-a9c3-0000f80367c1' }
        'Per-Msg-Dialog-Display-Table' { '5fd424d3-1262-11d0-a060-00aa006c33ed' }
        'Per-Recip-Dialog-Display-Table' { '5fd424d4-1262-11d0-a060-00aa006c33ed' }
        'Person' { 'bf967aa7-0de6-11d0-a285-00aa003049e2' }
        'Personal-Title' { '16775858-47f3-11d1-a9c3-0000f80367c1' }
        'Phone-Fax-Other' { '0296c11d-40da-11d1-a9c0-0000f80367c1' }
        'Phone-Home-Other' { 'f0f8ffa2-1191-11d0-a060-00aa006c33ed' }
        'Phone-Home-Primary' { 'f0f8ffa1-1191-11d0-a060-00aa006c33ed' }
        'Phone-Ip-Other' { '4d146e4b-48d4-11d1-a9c3-0000f80367c1' }
        'Phone-Ip-Primary' { '4d146e4a-48d4-11d1-a9c3-0000f80367c1' }
        'Phone-ISDN-Primary' { '0296c11f-40da-11d1-a9c0-0000f80367c1' }
        'Phone-Mobile-Other' { '0296c11e-40da-11d1-a9c0-0000f80367c1' }
        'Phone-Mobile-Primary' { 'f0f8ffa3-1191-11d0-a060-00aa006c33ed' }
        'Phone-Office-Other' { 'f0f8ffa5-1191-11d0-a060-00aa006c33ed' }
        'Phone-Pager-Other' { 'f0f8ffa4-1191-11d0-a060-00aa006c33ed' }
        'Phone-Pager-Primary' { 'f0f8ffa6-1191-11d0-a060-00aa006c33ed' }
        'photo' { '9c979768-ba1a-4c08-9632-c6a5c1ed649a' }
        'Physical-Delivery-Office-Name' { 'bf9679f7-0de6-11d0-a285-00aa003049e2' }
        'Physical-Location' { 'b7b13122-b82e-11d0-afee-0000f80367c1' }
        'Physical-Location-Object' { 'b7b13119-b82e-11d0-afee-0000f80367c1' }
        'Picture' { '8d3bca50-1d7e-11d0-a081-00aa006c33ed' }
        'PKI-Certificate-Template' { 'e5209ca2-3bba-11d2-90cc-00c04fd91ab1' }
        'PKI-Critical-Extensions' { 'fc5a9106-3b9d-11d2-90cc-00c04fd91ab1' }
        'PKI-Default-CSPs' { '1ef6336e-3b9e-11d2-90cc-00c04fd91ab1' }
        'PKI-Default-Key-Spec' { '426cae6e-3b9d-11d2-90cc-00c04fd91ab1' }
        'PKI-Enrollment-Access' { '926be278-56f9-11d2-90d0-00c04fd91ab1' }
        'PKI-Enrollment-Service' { 'ee4aa692-3bba-11d2-90cc-00c04fd91ab1' }
        'PKI-Expiration-Period' { '041570d2-3b9e-11d2-90cc-00c04fd91ab1' }
        'PKI-Extended-Key-Usage' { '18976af6-3b9e-11d2-90cc-00c04fd91ab1' }
        'PKI-Key-Usage' { 'e9b0a87e-3b9d-11d2-90cc-00c04fd91ab1' }
        'PKI-Max-Issuing-Depth' { 'f0bfdefa-3b9d-11d2-90cc-00c04fd91ab1' }
        'PKI-Overlap-Period' { '1219a3ec-3b9e-11d2-90cc-00c04fd91ab1' }
        'PKT' { '8447f9f1-1027-11d0-a05f-00aa006c33ed' }
        'PKT-Guid' { '8447f9f0-1027-11d0-a05f-00aa006c33ed' }
        'Policy-Replication-Flags' { '19405b96-3cfa-11d1-a9c0-0000f80367c1' }
        'Port-Name' { '281416c4-1968-11d0-a28f-00aa003049e2' }
        'PosixAccount' { 'ad44bb41-67d5-4d88-b575-7b20674e76d8' }
        'PosixGroup' { '2a9350b8-062c-4ed0-9903-dde10d06deba' }
        'Possible-Inferiors' { '9a7ad94c-ca53-11d1-bbd0-0080c76670c0' }
        'Poss-Superiors' { 'bf9679fa-0de6-11d0-a285-00aa003049e2' }
        'Postal-Address' { 'bf9679fc-0de6-11d0-a285-00aa003049e2' }
        'Postal-Code' { 'bf9679fd-0de6-11d0-a285-00aa003049e2' }
        'Post-Office-Box' { 'bf9679fb-0de6-11d0-a285-00aa003049e2' }
        'Preferred-Delivery-Method' { 'bf9679fe-0de6-11d0-a285-00aa003049e2' }
        'preferredLanguage' { '856be0d0-18e7-46e1-8f5f-7ee4d9020e0d' }
        'Preferred-OU' { 'bf9679ff-0de6-11d0-a285-00aa003049e2' }
        'Prefix-Map' { '52458022-ca6a-11d0-afff-0000f80367c1' }
        'Presentation-Address' { 'a8df744b-c5ea-11d1-bbcb-0080c76670c0' }
        'Previous-CA-Certificates' { '963d2739-48be-11d1-a9c3-0000f80367c1' }
        'Previous-Parent-CA' { '963d273d-48be-11d1-a9c3-0000f80367c1' }
        'Primary-Group-ID' { 'bf967a00-0de6-11d0-a285-00aa003049e2' }
        'Primary-Group-Token' { 'c0ed8738-7efd-4481-84d9-66d2db8be369' }
        'Print-Attributes' { '281416d7-1968-11d0-a28f-00aa003049e2' }
        'Print-Bin-Names' { '281416cd-1968-11d0-a28f-00aa003049e2' }
        'Print-Collate' { '281416d2-1968-11d0-a28f-00aa003049e2' }
        'Print-Color' { '281416d3-1968-11d0-a28f-00aa003049e2' }
        'Print-Duplex-Supported' { '281416cc-1968-11d0-a28f-00aa003049e2' }
        'Print-End-Time' { '281416ca-1968-11d0-a28f-00aa003049e2' }
        'Printer-Name' { '244b296e-5abd-11d0-afd2-00c04fd930c9' }
        'Print-Form-Name' { '281416cb-1968-11d0-a28f-00aa003049e2' }
        'Print-Keep-Printed-Jobs' { 'ba305f6d-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Language' { '281416d6-1968-11d0-a28f-00aa003049e2' }
        'Print-MAC-Address' { 'ba305f7a-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Max-Copies' { '281416d1-1968-11d0-a28f-00aa003049e2' }
        'Print-Max-Resolution-Supported' { '281416cf-1968-11d0-a28f-00aa003049e2' }
        'Print-Max-X-Extent' { 'ba305f6f-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Max-Y-Extent' { 'ba305f70-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Media-Ready' { '3bcbfcf5-4d3d-11d0-a1a6-00c04fd930c9' }
        'Print-Media-Supported' { '244b296f-5abd-11d0-afd2-00c04fd930c9' }
        'Print-Memory' { 'ba305f74-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Min-X-Extent' { 'ba305f71-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Min-Y-Extent' { 'ba305f72-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Network-Address' { 'ba305f79-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Notify' { 'ba305f6a-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Number-Up' { '3bcbfcf4-4d3d-11d0-a1a6-00c04fd930c9' }
        'Print-Orientations-Supported' { '281416d0-1968-11d0-a28f-00aa003049e2' }
        'Print-Owner' { 'ba305f69-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Pages-Per-Minute' { '19405b97-3cfa-11d1-a9c0-0000f80367c1' }
        'Print-Queue' { 'bf967aa8-0de6-11d0-a285-00aa003049e2' }
        'Print-Rate' { 'ba305f77-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Rate-Unit' { 'ba305f78-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Separator-File' { '281416c6-1968-11d0-a28f-00aa003049e2' }
        'Print-Share-Name' { 'ba305f68-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Spooling' { 'ba305f6c-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Stapling-Supported' { 'ba305f73-47e3-11d0-a1a6-00c04fd930c9' }
        'Print-Start-Time' { '281416c9-1968-11d0-a28f-00aa003049e2' }
        'Print-Status' { 'ba305f6b-47e3-11d0-a1a6-00c04fd930c9' }
        'Priority' { '281416c7-1968-11d0-a28f-00aa003049e2' }
        'Prior-Set-Time' { 'bf967a01-0de6-11d0-a285-00aa003049e2' }
        'Prior-Value' { 'bf967a02-0de6-11d0-a285-00aa003049e2' }
        'Private-Key' { 'bf967a03-0de6-11d0-a285-00aa003049e2' }
        'Privilege-Attributes' { '19405b9a-3cfa-11d1-a9c0-0000f80367c1' }
        'Privilege-Display-Name' { '19405b98-3cfa-11d1-a9c0-0000f80367c1' }
        'Privilege-Holder' { '19405b9b-3cfa-11d1-a9c0-0000f80367c1' }
        'Privilege-Value' { '19405b99-3cfa-11d1-a9c0-0000f80367c1' }
        'Product-Code' { 'd9e18317-8939-11d1-aebc-0000f80367c1' }
        'Profile-Path' { 'bf967a05-0de6-11d0-a285-00aa003049e2' }
        'Proxied-Object-Name' { 'e1aea402-cd5b-11d0-afff-0000f80367c1' }
        'Proxy-Addresses' { 'bf967a06-0de6-11d0-a285-00aa003049e2' }
        'Proxy-Generation-Enabled' { '5fd424d6-1262-11d0-a060-00aa006c33ed' }
        'Proxy-Lifetime' { 'bf967a07-0de6-11d0-a285-00aa003049e2' }
        'Public-Key-Policy' { '80a67e28-9f22-11d0-afdd-00c04fd930c9' }
        'Purported-Search' { 'b4b54e50-943a-11d1-aebd-0000f80367c1' }
        'Pwd-History-Length' { 'bf967a09-0de6-11d0-a285-00aa003049e2' }
        'Pwd-Last-Set' { 'bf967a0a-0de6-11d0-a285-00aa003049e2' }
        'Pwd-Properties' { 'bf967a0b-0de6-11d0-a285-00aa003049e2' }
        'Quality-Of-Service' { '80a67e4e-9f22-11d0-afdd-00c04fd930c9' }
        'Query-Filter' { 'cbf70a26-7e78-11d2-9921-0000f87a57d4' }
        'QueryPoint' { '7bfdcb86-4807-11d1-a9c3-0000f80367c1' }
        'Query-Policy' { '83cc7075-cca7-11d0-afff-0000f80367c1' }
        'Query-Policy-BL' { 'e1aea404-cd5b-11d0-afff-0000f80367c1' }
        'Query-Policy-Object' { 'e1aea403-cd5b-11d0-afff-0000f80367c1' }
        'Range-Lower' { 'bf967a0c-0de6-11d0-a285-00aa003049e2' }
        'Range-Upper' { 'bf967a0d-0de6-11d0-a285-00aa003049e2' }
        'RDN' { 'bf967a0e-0de6-11d0-a285-00aa003049e2' }
        'RDN-Att-ID' { 'bf967a0f-0de6-11d0-a285-00aa003049e2' }
        'Registered-Address' { 'bf967a10-0de6-11d0-a285-00aa003049e2' }
        'Remote-Mail-Recipient' { 'bf967aa9-0de6-11d0-a285-00aa003049e2' }
        'Remote-Server-Name' { 'bf967a12-0de6-11d0-a285-00aa003049e2' }
        'Remote-Source' { 'bf967a14-0de6-11d0-a285-00aa003049e2' }
        'Remote-Source-Type' { 'bf967a15-0de6-11d0-a285-00aa003049e2' }
        'Remote-Storage-GUID' { '2a39c5b0-8960-11d1-aebc-0000f80367c1' }
        'Remote-Storage-Service-Point' { '2a39c5bd-8960-11d1-aebc-0000f80367c1' }
        'Replica-Source' { 'bf967a18-0de6-11d0-a285-00aa003049e2' }
        'Repl-Interval' { '45ba9d1a-56fa-11d2-90d0-00c04fd91ab1' }
        'Repl-Property-Meta-Data' { '281416c0-1968-11d0-a28f-00aa003049e2' }
        'Repl-Topology-Stay-Of-Execution' { '7bfdcb83-4807-11d1-a9c3-0000f80367c1' }
        'Repl-UpToDate-Vector' { 'bf967a16-0de6-11d0-a285-00aa003049e2' }
        'Reports' { 'bf967a1c-0de6-11d0-a285-00aa003049e2' }
        'Reps-From' { 'bf967a1d-0de6-11d0-a285-00aa003049e2' }
        'Reps-To' { 'bf967a1e-0de6-11d0-a285-00aa003049e2' }
        'Required-Categories' { '7d6c0e93-7e20-11d0-afd6-00c04fd930c9' }
        'Residential-Person' { 'a8df74d6-c5ea-11d1-bbcb-0080c76670c0' }
        'Retired-Repl-DSA-Signatures' { '7bfdcb7f-4807-11d1-a9c3-0000f80367c1' }
        'Revision' { 'bf967a21-0de6-11d0-a285-00aa003049e2' }
        'rFC822LocalPart' { 'b93e3a78-cbae-485e-a07b-5ef4ae505686' }
        'Rid' { 'bf967a22-0de6-11d0-a285-00aa003049e2' }
        'RID-Allocation-Pool' { '66171889-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Available-Pool' { '66171888-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Manager' { '6617188d-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Manager-Reference' { '66171886-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Next-RID' { '6617188c-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Previous-Allocation-Pool' { '6617188a-8f3c-11d0-afda-00c04fd930c9' }
        'RID-Set' { '7bfdcb89-4807-11d1-a9c3-0000f80367c1' }
        'RID-Set-References' { '7bfdcb7b-4807-11d1-a9c3-0000f80367c1' }
        'RID-Used-Pool' { '6617188b-8f3c-11d0-afda-00c04fd930c9' }
        'Rights-Guid' { '8297931c-86d3-11d0-afda-00c04fd930c9' }
        'Role-Occupant' { 'a8df7465-c5ea-11d1-bbcb-0080c76670c0' }
        'room' { '7860e5d2-c8b0-4cbb-bd45-d9455beb9206' }
        'roomNumber' { '81d7f8c2-e327-4a0d-91c6-b42d4009115f' }
        'Root-Trust' { '7bfdcb80-4807-11d1-a9c3-0000f80367c1' }
        'Rpc-Container' { '80212842-4bdc-11d1-a9c4-0000f80367c1' }
        'rpc-Entry' { 'bf967aac-0de6-11d0-a285-00aa003049e2' }
        'rpc-Group' { '88611bdf-8cf4-11d0-afda-00c04fd930c9' }
        'rpc-Ns-Annotation' { '88611bde-8cf4-11d0-afda-00c04fd930c9' }
        'rpc-Ns-Bindings' { 'bf967a23-0de6-11d0-a285-00aa003049e2' }
        'rpc-Ns-Codeset' { '7a0ba0e0-8e98-11d0-afda-00c04fd930c9' }
        'rpc-Ns-Entry-Flags' { '80212841-4bdc-11d1-a9c4-0000f80367c1' }
        'rpc-Ns-Group' { 'bf967a24-0de6-11d0-a285-00aa003049e2' }
        'rpc-Ns-Interface-ID' { 'bf967a25-0de6-11d0-a285-00aa003049e2' }
        'rpc-Ns-Object-ID' { '29401c48-7a27-11d0-afd6-00c04fd930c9' }
        'rpc-Ns-Priority' { 'bf967a27-0de6-11d0-a285-00aa003049e2' }
        'rpc-Ns-Profile-Entry' { 'bf967a28-0de6-11d0-a285-00aa003049e2' }
        'rpc-Ns-Transfer-Syntax' { '29401c4a-7a27-11d0-afd6-00c04fd930c9' }
        'rpc-Profile' { '88611be1-8cf4-11d0-afda-00c04fd930c9' }
        'rpc-Profile-Element' { 'f29653cf-7ad0-11d0-afd6-00c04fd930c9' }
        'rpc-Server' { '88611be0-8cf4-11d0-afda-00c04fd930c9' }
        'rpc-Server-Element' { 'f29653d0-7ad0-11d0-afd6-00c04fd930c9' }
        'RRAS-Administration-Connection-Point' { '2a39c5be-8960-11d1-aebc-0000f80367c1' }
        'RRAS-Administration-Dictionary' { 'f39b98ae-938d-11d1-aebd-0000f80367c1' }
        'SAM-Account-Name' { '3e0abfd0-126a-11d0-a060-00aa006c33ed' }
        'SAM-Account-Type' { '6e7b626c-64f2-11d0-afd2-00c04fd930c9' }
        'Sam-Domain' { 'bf967a90-0de6-11d0-a285-00aa003049e2' }
        'Sam-Domain-Base' { 'bf967a91-0de6-11d0-a285-00aa003049e2' }
        'SAM-Domain-Updates' { '04d2d114-f799-4e9b-bcdc-90e8f5ba7ebe' }
        'Sam-Server' { 'bf967aad-0de6-11d0-a285-00aa003049e2' }
        'Schedule' { 'dd712224-10e4-11d0-a05f-00aa006c33ed' }
        'Schema-Flags-Ex' { 'bf967a2b-0de6-11d0-a285-00aa003049e2' }
        'Schema-ID-GUID' { 'bf967923-0de6-11d0-a285-00aa003049e2' }
        'Schema-Info' { 'f9fb64ae-93b4-11d2-9945-0000f87a57d4' }
        'Schema-Update' { '1e2d06b4-ac8f-11d0-afe3-00c04fd930c9' }
        'Schema-Version' { 'bf967a2c-0de6-11d0-a285-00aa003049e2' }
        'Scope-Flags' { '16f3a4c2-7e79-11d2-9921-0000f87a57d4' }
        'Script-Path' { 'bf9679a8-0de6-11d0-a285-00aa003049e2' }
        'SD-Rights-Effective' { 'c3dbafa6-33df-11d2-98b2-0000f87a57d4' }
        'Search-Flags' { 'bf967a2d-0de6-11d0-a285-00aa003049e2' }
        'Search-Guide' { 'bf967a2e-0de6-11d0-a285-00aa003049e2' }
        'Secret' { 'bf967aae-0de6-11d0-a285-00aa003049e2' }
        'secretary' { '01072d9a-98ad-4a53-9744-e83e287278fb' }
        'Security-Identifier' { 'bf967a2f-0de6-11d0-a285-00aa003049e2' }
        'Security-Object' { 'bf967aaf-0de6-11d0-a285-00aa003049e2' }
        'Security-Principal' { 'bf967ab0-0de6-11d0-a285-00aa003049e2' }
        'See-Also' { 'bf967a31-0de6-11d0-a285-00aa003049e2' }
        'Seq-Notification' { 'ddac0cf2-af8f-11d0-afeb-00c04fd930c9' }
        'Serial-Number' { 'bf967a32-0de6-11d0-a285-00aa003049e2' }
        'Server' { 'bf967a92-0de6-11d0-a285-00aa003049e2' }
        'Server-Name' { '09dcb7a0-165f-11d0-a064-00aa006c33ed' }
        'Server-Reference' { '26d9736d-6070-11d1-a9c6-0000f80367c1' }
        'Server-Reference-BL' { '26d9736e-6070-11d1-a9c6-0000f80367c1' }
        'Server-Role' { 'bf967a33-0de6-11d0-a285-00aa003049e2' }
        'Servers-Container' { 'f780acc0-56f0-11d1-a9c6-0000f80367c1' }
        'Server-State' { 'bf967a34-0de6-11d0-a285-00aa003049e2' }
        'Service-Administration-Point' { 'b7b13123-b82e-11d0-afee-0000f80367c1' }
        'Service-Binding-Information' { 'b7b1311c-b82e-11d0-afee-0000f80367c1' }
        'Service-Class' { 'bf967ab1-0de6-11d0-a285-00aa003049e2' }
        'Service-Class-ID' { 'bf967a35-0de6-11d0-a285-00aa003049e2' }
        'Service-Class-Info' { 'bf967a36-0de6-11d0-a285-00aa003049e2' }
        'Service-Class-Name' { 'b7b1311d-b82e-11d0-afee-0000f80367c1' }
        'Service-Connection-Point' { '28630ec1-41d5-11d1-a9c1-0000f80367c1' }
        'Service-DNS-Name' { '28630eb8-41d5-11d1-a9c1-0000f80367c1' }
        'Service-DNS-Name-Type' { '28630eba-41d5-11d1-a9c1-0000f80367c1' }
        'Service-Instance' { 'bf967ab2-0de6-11d0-a285-00aa003049e2' }
        'Service-Instance-Version' { 'bf967a37-0de6-11d0-a285-00aa003049e2' }
        'Service-Principal-Name' { 'f3a64788-5306-11d1-a9c5-0000f80367c1' }
        'Setup-Command' { '7d6c0e97-7e20-11d0-afd6-00c04fd930c9' }
        'ShadowAccount' { '5b6d8467-1a18-4174-b350-9cc6e7b4ac8d' }
        'ShadowExpire' { '75159a00-1fff-4cf4-8bff-4ef2695cf643' }
        'ShadowFlag' { '8dfeb70d-c5db-46b6-b15e-a4389e6cee9b' }
        'ShadowInactive' { '86871d1f-3310-4312-8efd-af49dcfb2671' }
        'ShadowLastChange' { 'f8f2689c-29e8-4843-8177-e8b98e15eeac' }
        'ShadowMax' { 'f285c952-50dd-449e-9160-3b880d99988d' }
        'ShadowMin' { 'a76b8737-e5a1-4568-b057-dc12e04be4b2' }
        'ShadowWarning' { '7ae89c9c-2976-4a46-bb8a-340f88560117' }
        'Shell-Context-Menu' { '553fd039-f32e-11d0-b0bc-00c04fd8dca6' }
        'Shell-Property-Pages' { '52458039-ca6a-11d0-afff-0000f80367c1' }
        'Short-Server-Name' { '45b01501-c419-11d1-bbc9-0080c76670c0' }
        'Show-In-Address-Book' { '3e74f60e-3e73-11d1-a9c0-0000f80367c1' }
        'Show-In-Advanced-View-Only' { 'bf967984-0de6-11d0-a285-00aa003049e2' }
        'SID-History' { '17eb4278-d167-11d0-b002-0000f80367c1' }
        'Signature-Algorithms' { '2a39c5b2-8960-11d1-aebc-0000f80367c1' }
        'simpleSecurityObject' { '5fe69b0b-e146-4f15-b0ab-c1e5d488e094' }
        'Site' { 'bf967ab3-0de6-11d0-a285-00aa003049e2' }
        'Site-GUID' { '3e978924-8c01-11d0-afda-00c04fd930c9' }
        'Site-Link' { 'd50c2cde-8951-11d1-aebc-0000f80367c1' }
        'Site-Link-Bridge' { 'd50c2cdf-8951-11d1-aebc-0000f80367c1' }
        'Site-Link-List' { 'd50c2cdd-8951-11d1-aebc-0000f80367c1' }
        'Site-List' { 'd50c2cdc-8951-11d1-aebc-0000f80367c1' }
        'Site-Object' { '3e10944c-c354-11d0-aff8-0000f80367c1' }
        'Site-Object-BL' { '3e10944d-c354-11d0-aff8-0000f80367c1' }
        'Sites-Container' { '7a4117da-cd67-11d0-afff-0000f80367c1' }
        'Site-Server' { '1be8f17c-a9ff-11d0-afe2-00c04fd930c9' }
        'SMTP-Mail-Address' { '26d9736f-6070-11d1-a9c6-0000f80367c1' }
        'SPN-Mappings' { '2ab0e76c-7041-11d2-9905-0000f87a57d4' }
        'State-Or-Province-Name' { 'bf967a39-0de6-11d0-a285-00aa003049e2' }
        'Storage' { 'bf967ab5-0de6-11d0-a285-00aa003049e2' }
        'Street-Address' { 'bf967a3a-0de6-11d0-a285-00aa003049e2' }
        'Structural-Object-Class' { '3860949f-f6a8-4b38-9950-81ecb6bc2982' }
        'Sub-Class-Of' { 'bf967a3b-0de6-11d0-a285-00aa003049e2' }
        'Subnet' { 'b7b13124-b82e-11d0-afee-0000f80367c1' }
        'Subnet-Container' { 'b7b13125-b82e-11d0-afee-0000f80367c1' }
        'Sub-Refs' { 'bf967a3c-0de6-11d0-a285-00aa003049e2' }
        'SubSchema' { '5a8b3261-c38d-11d1-bbc9-0080c76670c0' }
        'SubSchemaSubEntry' { '9a7ad94d-ca53-11d1-bbd0-0080c76670c0' }
        'Superior-DNS-Root' { '5245801d-ca6a-11d0-afff-0000f80367c1' }
        'Super-Scope-Description' { '963d274c-48be-11d1-a9c3-0000f80367c1' }
        'Super-Scopes' { '963d274b-48be-11d1-a9c3-0000f80367c1' }
        'Supplemental-Credentials' { 'bf967a3f-0de6-11d0-a285-00aa003049e2' }
        'Supported-Application-Context' { '1677588f-47f3-11d1-a9c3-0000f80367c1' }
        'Surname' { 'bf967a41-0de6-11d0-a285-00aa003049e2' }
        'Sync-Attributes' { '037651e4-441d-11d1-a9c3-0000f80367c1' }
        'Sync-Membership' { '037651e3-441d-11d1-a9c3-0000f80367c1' }
        'Sync-With-Object' { '037651e2-441d-11d1-a9c3-0000f80367c1' }
        'Sync-With-SID' { '037651e5-441d-11d1-a9c3-0000f80367c1' }
        'System-Auxiliary-Class' { 'bf967a43-0de6-11d0-a285-00aa003049e2' }
        'System-Flags' { 'e0fa1e62-9b45-11d0-afdd-00c04fd930c9' }
        'System-May-Contain' { 'bf967a44-0de6-11d0-a285-00aa003049e2' }
        'System-Must-Contain' { 'bf967a45-0de6-11d0-a285-00aa003049e2' }
        'System-Only' { 'bf967a46-0de6-11d0-a285-00aa003049e2' }
        'System-Poss-Superiors' { 'bf967a47-0de6-11d0-a285-00aa003049e2' }
        'Telephone-Number' { 'bf967a49-0de6-11d0-a285-00aa003049e2' }
        'Teletex-Terminal-Identifier' { 'bf967a4a-0de6-11d0-a285-00aa003049e2' }
        'Telex-Number' { 'bf967a4b-0de6-11d0-a285-00aa003049e2' }
        'Telex-Primary' { '0296c121-40da-11d1-a9c0-0000f80367c1' }
        'Template-Roots' { 'ed9de9a0-7041-11d2-9905-0000f87a57d4' }
        'Template-Roots2' { 'b1cba91a-0682-4362-a659-153e201ef069' }
        'Terminal-Server' { '6db69a1c-9422-11d1-aebd-0000f80367c1' }
        'Text-Country' { 'f0f8ffa7-1191-11d0-a060-00aa006c33ed' }
        'Text-Encoded-OR-Address' { 'a8df7489-c5ea-11d1-bbcb-0080c76670c0' }
        'Time-Refresh' { 'ddac0cf1-af8f-11d0-afeb-00c04fd930c9' }
        'Time-Vol-Change' { 'ddac0cf0-af8f-11d0-afeb-00c04fd930c9' }
        'Title' { 'bf967a55-0de6-11d0-a285-00aa003049e2' }
        'Token-Groups' { 'b7c69e6d-2cc7-11d2-854e-00a0c983f608' }
        'Token-Groups-Global-And-Universal' { '46a9b11d-60ae-405a-b7e8-ff8a58d456d2' }
        'Token-Groups-No-GC-Acceptable' { '040fc392-33df-11d2-98b2-0000f87a57d4' }
        'Tombstone-Lifetime' { '16c3a860-1273-11d0-a060-00aa006c33ed' }
        'Top' { 'bf967ab7-0de6-11d0-a285-00aa003049e2' }
        'Transport-Address-Attribute' { 'c1dc867c-a261-11d1-b606-0000f80367c1' }
        'Transport-DLL-Name' { '26d97372-6070-11d1-a9c6-0000f80367c1' }
        'Transport-Type' { '26d97374-6070-11d1-a9c6-0000f80367c1' }
        'Treat-As-Leaf' { '8fd044e3-771f-11d1-aeae-0000f80367c1' }
        'Tree-Name' { '28630ebd-41d5-11d1-a9c1-0000f80367c1' }
        'Trust-Attributes' { '80a67e5a-9f22-11d0-afdd-00c04fd930c9' }
        'Trust-Auth-Incoming' { 'bf967a59-0de6-11d0-a285-00aa003049e2' }
        'Trust-Auth-Outgoing' { 'bf967a5f-0de6-11d0-a285-00aa003049e2' }
        'Trust-Direction' { 'bf967a5c-0de6-11d0-a285-00aa003049e2' }
        'Trusted-Domain' { 'bf967ab8-0de6-11d0-a285-00aa003049e2' }
        'Trust-Parent' { 'b000ea7a-a086-11d0-afdd-00c04fd930c9' }
        'Trust-Partner' { 'bf967a5d-0de6-11d0-a285-00aa003049e2' }
        'Trust-Posix-Offset' { 'bf967a5e-0de6-11d0-a285-00aa003049e2' }
        'Trust-Type' { 'bf967a60-0de6-11d0-a285-00aa003049e2' }
        'Type-Library' { '281416e2-1968-11d0-a28f-00aa003049e2' }
        'UAS-Compat' { 'bf967a61-0de6-11d0-a285-00aa003049e2' }
        'uid' { '0bb0fca0-1e89-429f-901a-1413894d9f59' }
        'UidNumber' { '850fcc8f-9c6b-47e1-b671-7c654be4d5b3' }
        'UNC-Name' { 'bf967a64-0de6-11d0-a285-00aa003049e2' }
        'Unicode-Pwd' { 'bf9679e1-0de6-11d0-a285-00aa003049e2' }
        'uniqueIdentifier' { 'ba0184c7-38c5-4bed-a526-75421470580c' }
        'uniqueMember' { '8f888726-f80a-44d7-b1ee-cb9df21392c8' }
        'UnixHomeDirectory' { 'bc2dba12-000f-464d-bf1d-0808465d8843' }
        'UnixUserPassword' { '612cb747-c0e8-4f92-9221-fdd5f15b550d' }
        'unstructuredAddress' { '50950839-cc4c-4491-863a-fcf942d684b7' }
        'unstructuredName' { '9c8ef177-41cf-45c9-9673-7716c0c8901b' }
        'Upgrade-Product-Code' { 'd9e18312-8939-11d1-aebc-0000f80367c1' }
        'UPN-Suffixes' { '032160bf-9824-11d1-aec0-0000f80367c1' }
        'User' { 'bf967aba-0de6-11d0-a285-00aa003049e2' }
        'User-Account-Control' { 'bf967a68-0de6-11d0-a285-00aa003049e2' }
        'User-Cert' { 'bf967a69-0de6-11d0-a285-00aa003049e2' }
        'userClass' { '11732a8a-e14d-4cc5-b92f-d93f51c6d8e4' }
        'User-Comment' { 'bf967a6a-0de6-11d0-a285-00aa003049e2' }
        'User-Parameters' { 'bf967a6d-0de6-11d0-a285-00aa003049e2' }
        'User-Password' { 'bf967a6e-0de6-11d0-a285-00aa003049e2' }
        'userPKCS12' { '23998ab5-70f8-4007-a4c1-a84a38311f9a' }
        'User-Principal-Name' { '28630ebb-41d5-11d1-a9c1-0000f80367c1' }
        'User-Shared-Folder' { '9a9a021f-4a5b-11d1-a9c3-0000f80367c1' }
        'User-Shared-Folder-Other' { '9a9a0220-4a5b-11d1-a9c3-0000f80367c1' }
        'User-SMIME-Certificate' { 'e16a9db2-403c-11d1-a9c0-0000f80367c1' }
        'User-Workstations' { 'bf9679d7-0de6-11d0-a285-00aa003049e2' }
        'USN-Changed' { 'bf967a6f-0de6-11d0-a285-00aa003049e2' }
        'USN-Created' { 'bf967a70-0de6-11d0-a285-00aa003049e2' }
        'USN-DSA-Last-Obj-Removed' { 'bf967a71-0de6-11d0-a285-00aa003049e2' }
        'USN-Intersite' { 'a8df7498-c5ea-11d1-bbcb-0080c76670c0' }
        'USN-Last-Obj-Rem' { 'bf967a73-0de6-11d0-a285-00aa003049e2' }
        'USN-Source' { '167758ad-47f3-11d1-a9c3-0000f80367c1' }
        'Valid-Accesses' { '4d2fa380-7f54-11d2-992a-0000f87a57d4' }
        'Vendor' { '281416df-1968-11d0-a28f-00aa003049e2' }
        'Version-Number' { 'bf967a76-0de6-11d0-a285-00aa003049e2' }
        'Version-Number-Hi' { '7d6c0e9a-7e20-11d0-afd6-00c04fd930c9' }
        'Version-Number-Lo' { '7d6c0e9b-7e20-11d0-afd6-00c04fd930c9' }
        'Vol-Table-GUID' { '1f0075fd-7e40-11d0-afd6-00c04fd930c9' }
        'Vol-Table-Idx-GUID' { '1f0075fb-7e40-11d0-afd6-00c04fd930c9' }
        'Volume' { 'bf967abb-0de6-11d0-a285-00aa003049e2' }
        'Volume-Count' { '34aaa217-b699-11d0-afee-0000f80367c1' }
        'Wbem-Path' { '244b2970-5abd-11d0-afd2-00c04fd930c9' }
        'Well-Known-Objects' { '05308983-7688-11d1-aded-00c04fd8d5cd' }
        'When-Changed' { 'bf967a77-0de6-11d0-a285-00aa003049e2' }
        'When-Created' { 'bf967a78-0de6-11d0-a285-00aa003049e2' }
        'Winsock-Addresses' { 'bf967a79-0de6-11d0-a285-00aa003049e2' }
        'WWW-Home-Page' { 'bf967a7a-0de6-11d0-a285-00aa003049e2' }
        'WWW-Page-Other' { '9a9a0221-4a5b-11d1-a9c3-0000f80367c1' }
        'X121-Address' { 'bf967a7b-0de6-11d0-a285-00aa003049e2' }
        'x500uniqueIdentifier' { 'd07da11f-8a3d-42b6-b0aa-76c962be719a' }
        'X509-Cert' { 'bf967a7f-0de6-11d0-a285-00aa003049e2' }
        'Add-GUID' { '440820ad-65b4-11d1-a3da-0000f875ae0d' }
        'Allocate-Rids' { '1abd7cf8-0a99-11d1-adbb-00c04fd8d5cd' }
        'Allowed-To-Authenticate' { '68b1d179-0d15-4d4f-ab71-46152e79a7bc' }
        'Apply-Group-Policy' { 'edacfd8f-ffb3-11d1-b41d-00a0c968f939' }
        'Certificate-AutoEnrollment' { 'a05b8cc2-17bc-4802-a710-e7c15ab866a2' }
        'Certificate-Enrollment' { '0e10c968-78fb-11d2-90d4-00c04f79dc55' }
        'Change-Domain-Master' { '014bf69c-7b3b-11d1-85f6-08002be74fab' }
        'Change-Infrastructure-Master' { 'cc17b1fb-33d9-11d2-97d4-00c04fd8d5cd' }
        'Change-PDC' { 'bae50096-4752-11d1-9052-00c04fc2d4cf' }
        'Change-Rid-Master' { 'd58d5f36-0a98-11d1-adbb-00c04fd8d5cd' }
        'Change-Schema-Master' { 'e12b56b6-0a95-11d1-adbb-00c04fd8d5cd' }
        'Create-Inbound-Forest-Trust' { 'e2a36dc9-ae17-47c3-b58b-be34c55ba633' }
        'DNS-Host-Name-Attributes' { '72e39547-7b18-11d1-adef-00c04fd8d5cd' }
        'Do-Garbage-Collection' { 'fec364e0-0a98-11d1-adbb-00c04fd8d5cd' }
        'Domain-Administer-Server' { 'ab721a52-1e2f-11d0-9819-00aa0040529b' }
        'Domain-Other-Parameters' { 'b8119fd0-04f6-4762-ab7a-4986c76b3f9a' }
        'Domain-Password' { 'c7407360-20bf-11d0-a768-00aa006e0529' }
        'DS-Bypass-Quota' { '88a9933e-e5c8-4f2a-9dd7-2527416b8092' }
        'DS-Check-Stale-Phantoms' { '69ae6200-7f46-11d2-b9ad-00c04f79f805' }
        'DS-Clone-Domain-Controller' { '3e0f7e18-2c7a-4c10-ba82-4d926db99a3e' }
        'DS-Execute-Intentions-Script' { '2f16c4a5-b98e-432c-952a-cb388ba33f2e' }
        'DS-Install-Replica' { '9923a32a-3607-11d2-b9be-0000f87a36b2' }
        'DS-Query-Self-Quota' { '4ecc03fe-ffc0-4947-b630-eb672a8a9dbc' }
        'DS-Read-Partition-Secrets' { '084c93a2-620d-4879-a836-f0ae47de0e89' }
        'DS-Replication-Get-Changes' { '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2' }
        'DS-Replication-Get-Changes-All' { '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2' }
        'DS-Replication-Get-Changes-In-Filtered-Set' { '89e95b76-444d-4c62-991a-0facbeda640c' }
        'DS-Replication-Manage-Topology' { '1131f6ac-9c07-11d1-f79f-00c04fc2dcd2' }
        'DS-Replication-Monitor-Topology' { 'f98340fb-7c5b-4cdb-a00b-2ebdfa115a96' }
        'DS-Replication-Synchronize' { '1131f6ab-9c07-11d1-f79f-00c04fc2dcd2' }
        'DS-Set-Owner' { '4125c71f-7fac-4ff0-bcb7-f09a41325286' }
        'DS-Validated-Write-Computer' { '9b026da6-0d3c-465c-8bee-5199d7165cba' }
        'DS-Write-Partition-Secrets' { '94825a8d-b171-4116-8146-1e34d8f54401' }
        'Email-Information' { 'e45795b2-9455-11d1-aebd-0000f80367c1' }
        'Enable-Per-User-Reversibly-Encrypted-Password' { '05c74c5e-4deb-43b4-bd9f-86664c2a7fd5' }
        'General-Information' { '59ba2f42-79a2-11d0-9020-00c04fc2d3cf' }
        'Generate-RSoP-Logging' { 'b7b1b3de-ab09-4242-9e30-9980e5d322f7' }
        'Generate-RSoP-Planning' { 'b7b1b3dd-ab09-4242-9e30-9980e5d322f7' }
        'Manage-Optional-Features' { '7c0e2a7c-a419-48e4-a995-10180aad54dd' }
        'Membership' { 'bc0ac240-79a9-11d0-9020-00c04fc2d4cf' }
        'Migrate-SID-History' { 'ba33815a-4f93-4c76-87f3-57574bff8109' }
        'msmq-Open-Connector' { 'b4e60130-df3f-11d1-9c86-006008764d0e' }
        'msmq-Peek' { '06bd3201-df3e-11d1-9c86-006008764d0e' }
        'msmq-Peek-computer-Journal' { '4b6e08c3-df3c-11d1-9c86-006008764d0e' }
        'msmq-Peek-Dead-Letter' { '4b6e08c1-df3c-11d1-9c86-006008764d0e' }
        'msmq-Receive' { '06bd3200-df3e-11d1-9c86-006008764d0e' }
        'msmq-Receive-computer-Journal' { '4b6e08c2-df3c-11d1-9c86-006008764d0e' }
        'msmq-Receive-Dead-Letter' { '4b6e08c0-df3c-11d1-9c86-006008764d0e' }
        'msmq-Receive-journal' { '06bd3203-df3e-11d1-9c86-006008764d0e' }
        'msmq-Send' { '06bd3202-df3e-11d1-9c86-006008764d0e' }
        'MS-TS-GatewayAccess' { 'ffa6f046-ca4b-4feb-b40d-04dfee722543' }
        'Open-Address-Book' { 'a1990816-4298-11d1-ade2-00c04fd8d5cd' }
        'Personal-Information' { '77b5b886-944a-11d1-aebd-0000f80367c1' }
        'Private-Information' { '91e647de-d96f-4b70-9557-d63ff4f3ccd8' }
        'Public-Information' { 'e48d0154-bcf8-11d1-8702-00c04fb96050' }
        'RAS-Information' { '037088f8-0ae1-11d2-b422-00a0c968f939' }
        'Read-Only-Replication-Secret-Synchronization' { '1131f6ae-9c07-11d1-f79f-00c04fc2dcd2' }
        'Reanimate-Tombstones' { '45ec5156-db7e-47bb-b53f-dbeb2d03c40f' }
        'Recalculate-Hierarchy' { '0bc1554e-0a99-11d1-adbb-00c04fd8d5cd' }
        'Recalculate-Security-Inheritance' { '62dd28a8-7f46-11d2-b9ad-00c04f79f805' }
        'Receive-As' { 'ab721a56-1e2f-11d0-9819-00aa0040529b' }
        'Refresh-Group-Cache' { '9432c620-033c-4db7-8b58-14ef6d0bf477' }
        'Reload-SSL-Certificate' { '1a60ea8d-58a6-4b20-bcdc-fb71eb8a9ff8' }
        'Run-Protect-Admin-Groups-Task' { '7726b9d5-a4b4-4288-a6b2-dce952e80a7f' }
        'SAM-Enumerate-Entire-Domain' { '91d67418-0135-4acc-8d79-c08e857cfbec' }
        'Self-Membership' { 'bf9679c0-0de6-11d0-a285-00aa003049e2' }
        'Send-As' { 'ab721a54-1e2f-11d0-9819-00aa0040529b' }
        'Send-To' { 'ab721a55-1e2f-11d0-9819-00aa0040529b' }
        'Terminal-Server-License-Server' { '5805bc62-bdc9-4428-a5e2-856a0f4c185e' }
        'Unexpire-Password' { 'ccc2dc7d-a6ad-4a7a-8846-c04e3cc53501' }
        'Update-Password-Not-Required-Bit' { '280f369c-67c7-438e-ae98-1d46f3c6f541' }
        'Update-Schema-Cache' { 'be2bb760-7f46-11d2-b9ad-00c04f79f805' }
        'User-Account-Restrictions' { '4c164200-20c0-11d0-a768-00aa006e0529' }
        'User-Change-Password' { 'ab721a53-1e2f-11d0-9819-00aa0040529b' }
        'User-Force-Change-Password' { '00299570-246d-11d0-a768-00aa006e0529' }
        'User-Logon' { '5f202010-79a5-11d0-9020-00c04fc2d4cf' }
        'Validated-DNS-Host-Name' { '72e39547-7b18-11d1-adef-00c04fd8d5cd' }
        'Validated-MS-DS-Additional-DNS-Host-Name' { '80863791-dbe9-4eb8-837e-7f0ab55d9ac7' }
        'Validated-MS-DS-Behavior-Version' { 'd31a8757-2447-4545-8081-3bb610cacbf2' }
        'Validated-SPN' { 'f3a64788-5306-11d1-a9c5-0000f80367c1' }
        'Web-Information' { 'e45795b3-9455-11d1-aebd-0000f80367c1' }
        'All' { '00000000-0000-0000-0000-000000000000' }
        Default { '00000000-0000-0000-0000-000000000000' }
    } #end switch

    return $schemaIdGuid
}

configuration ADObjectAcls
{
    param
    (
        [Parameter(Mandatory)]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $DomainDN,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Objects
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    <#
        Convert DN to Fqdn
    #>
    $pattern = '(?i)DC=(?<name>\w+){1,}?\b'
    $myDomainName = ([RegEx]::Matches($DomainDN, $pattern) | ForEach-Object { $_.groups['name'] }) -join '.'

    <#
        Wait for Active Directory domain controller to become available in the domain
    #>
    WindowsFeature AddAdDomainServices
    {
        Name   = 'AD-Domain-Services'
        Ensure = 'Present'
    }

    WindowsFeature AddRSATADPowerShell
    {
        Name      = 'RSAT-AD-PowerShell'
        Ensure    = 'Present'
        DependsOn = '[WindowsFeature]AddAdDomainServices'
    }

    # set execution name for the resource
    $executionName = "$($myDomainName -replace '[-().:\s]', '_')"

    WaitForADDomain "$executionName"
    {
        DomainName  = $myDomainName
        WaitTimeout = 300
        DependsOn   = '[WindowsFeature]AddRSATADPowershell'
    }
    # set resource name as dependency
    $dependsOnWaitForADDomain = "[WaitForADDomain]$executionName"


    <#
        Enumerate all Paths and recursively create resource
    #>
    foreach ($o in $Objects)
    {
        # store resource parameters in hashtable
        $params = @{}

        # remove case sensitivity of ordered Dictionary or Hashtable
        $o = @{} + $o

        # if not specifed, set OU path at root of domain
        if ( [string]::IsNullOrWhitespace($o.Path) )
        {
            $params.Path = $DomainDN
        }

        if ($o.Path -notmatch '(?<DomainPart>dc=\w+,dc=\w+)')
        {
            $params.Path = "$($o.Path),$DomainDN"
        }

        # the property 'AccessControlList' must be defined
        if (-not $o.ContainsKey('AccessControlList'))
        {
            throw 'ERROR: The property AccessControlList is not defined.'
        }

        <#
            Enumerate the Access Control List
        #>
        foreach ($a in $o.AccessControlList)
        {
            # remove case sensitivity of ordered Dictionary or Hashtable
            $a = @{} + $a

            ## the property 'IdentityReference' must be defined
            if (-not $a.ContainsKey('IdentityReference'))
            {
                throw 'ERROR: The property IdentityReference is not defined.'
            }

            # set the principal for the ACL
            $params.IdentityReference = $a.IdentityReference

            # the property 'PermissionEntries' must be defined
            if (-not $a.ContainsKey('PermissionEntries'))
            {
                throw 'ERROR: The propertty PermissionEntries is not defined.'
            }

            foreach ($e in $a.PermissionEntries)
            {
                # remove case sensitivity for ordered Dictionary and Hashtabels
                $e = @{ } + $e

                # if AccessControlType not defined, set default to Allow
                if (-not $e.ContainsKey('AccessControlType'))
                {
                    $params.AccessControlType = 'Allow'
                }
                else
                {
                    $params.AccessControlType = $e.AccessControlType
                }

                # if not specified, set 'ActiveDirectoryRights' to 'GenericAll'
                if (-not $e.ContainsKey('ActiveDirectoryRights'))
                {
                    $params.ActiveDirectoryRights = 'GenericAll'
                }
                else
                {
                    $params.ActiveDirectoryRights = $e.ActiveDirectoryRights
                }

                # if not specified, set 'ObjectType' to All
                if (-not $e.ContainsKey('ObjectType'))
                {
                    $e.ObjectType = 'All'
                }

                # if not specified, set 'ActiveDirectorySecurityInheritance' to All
                if (-not $e.ContainsKey('ActiveDirectorySecurityInheritance'))
                {
                    $params.ActiveDirectorySecurityInheritance = 'All'
                }

                # if not specified, set 'ObjectType' to zero GUID
                if (-not $e.ContainsKey('InheritedObjectType'))
                {
                    $e.InheritedObjectType = 'All'
                }

                # if not specified, ensure 'Present'
                if (-not $e.ContainsKey('Ensure'))
                {
                    $params.Ensure = 'Present'
                }

                # Retrieve Schema ID for ObjectType
                try
                {
                    $params.ObjectType = (Get-SchemaObjectGuid -ObjectName $e.ObjectType)
                }
                catch
                {
                    throw "$($_.Exception.Message)"
                }

                # Retrieve Schema ID for ObjectType
                try
                {
                    $params.InheritedObjectType = (Get-SchemaObjectGuid -ObjectName $e.InheritedObjectType)
                }
                catch
                {
                    throw "$($_.Exception.Message)"
                }


                # this resource depends on availibility of the domain
                $params.DependsOn = $dependsOnWaitForADDomain

                # create execution name for the resource
                $executionName = "$($params.Path -replace '[,|=\s]', '')_$("$($params.IdentityReference)_$($params.AccessControlType)_$($params.ActiveDirectoryRights)_$($e.ObjectType)_$($params.ActiveDirectorySecurityInheritance)_$($e.InheritedObjectType)" -replace '[-().:\s]', '_')"

                $hashtable = @"

                Creating DSC Resource ADObjectPermissionEntry with values:

                ADObjectPermissionEntry "$executionName"
                {
                    Ensure                             = $($params.Ensure)
                    Path                               = $($params.Path)
                    IdentityReference                  = $($params.IdentityReference)
                    ActiveDirectoryRights              = $($params.ActiveDirectoryRights)
                    AccessControlType                  = $($params.AccessControlType)
                    ObjectType                         = $($params.ObjectType)
                    ActiveDirectorySecurityInheritance = $($params.ActiveDirectorySecurityInheritance)
                    InheritedObjectType                = $($params.InheritedObjectType)
                    DependsOn                          = $($params.DependsOn)
                }

"@

                Write-Host $hashtable -ForegroundColor Yellow

                # create the resource
                $Splatting = @{
                    ResourceName  = 'ADObjectPermissionEntry'
                    ExecutionName = $executionName
                    Properties    = $params
                    NoInvoke      = $true
                }
                (Get-DscSplattedResource @Splatting).Invoke($params)
            } #end foreach ($e in $a.PermissionEntries)
        } #end foreach ($a in $Object.AccessControlList)
    } #end foreach
} #end configuration