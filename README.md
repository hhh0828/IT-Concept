Printer Deployment for 200+ Device with Intune.



Powershell, Azure, Intune


Packaging each site's printer drivers, and deploy them for the users who works on each branches.

26개의 지사를 가진 고객사이며 프린터 종류가 모두 같지 않아, 일괄 배포가 아닌 원격으로 설치를 지원 하였습니다.
프린터 드라이버를 설치하는 컴퓨터는 모두 재 사용이 되지 않고, 재 설정하여 다른 사이트로 이동하여 재 사용 되기 때문에, 같은 일을 반복하는 상황이 발생하였습니다. 
고객사가 가진 특성 상, 입 퇴사가 잦아 많은 요청이 발생했으며, 
이를 극복하기 위해 프린터 드라이버 자동화 프로젝트가 진행되었고. 비용적인 한계를 두어 Serverless로 스크립트화하여 배포 결정

고객사의 인프라는 Azure를 통하여 구성 되어있으며, 사용자 및 컴퓨터의 대한 IAM은 모두 Azure에서 진행
AzureAD 한계로 사용자의 컴퓨터에서 그룹 정보 식별이 불가 함. 이를 극복하기 위한 방법으로 Azure APP reigister 및 Graph API를 사용하여 스크립트를 배포하고 그룹정보를 사용자 컴퓨터에서 식별하고, 
사용자 그룹 정보에 맞는 프린터 드라이버와 프로그램을 배포 설치 하였고, Intune의 APP detect를 통하여 지속적 관리 및 자동 설치를 구성하였음.
