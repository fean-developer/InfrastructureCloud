# Criando uma variavel para rodar executar o shel da maquina virtual
# Esse Script instala o mysql e starta o serviço

$mysql_server = <<-SCRIPT
  sudo apt-get update && \
  apt-get install -y mysql-server-5.7 && \
  sudo service mysql start
SCRIPT


Vagrant.configure("2") do |config|
  # Define o box a ser usado..
  config.vm.box = "ubuntu/bionic64"

  
  # Cria a maquina virtual para usar subir o mysql
  config.vm.define 'database' do |database|

    # define um ip privado para o acesso do banco de dados
    # tentei adicionar o ip passado pelo o professor , mas deu erro pois a faixa de ip da minha rede é diferente. entao adicionei o sugerido pela minha maquina.
    # caso rodem e de algum erro usem o que apresentar no erro

    database.vm.network "private_network", ip: "192.168.56.10"
    # exporta a porta para fora do host 
    database.vm.network "forwarded_port", guest: 3306, host: 3306
    # Define as configuraçoes da maquina virtual
    database.vm.provider "virtualbox" do |vb|
      vb.name = "mysqlserver"
      vb.memory = 2048
      vb.cpus = 2
    end
    # Roda o script criado acima
    database.vm.provision 'shell', inline: $mysql_server
    # Esse script serve para alterar a senha do root do mysql
    # pois quando tentei instalar somente o banco e acessar via ssh
    # deu erro informando  acesso negado para root@localhost
    # entao gerei um sh que faz toda essa rotina para trocar a senha.
    # tambem faz um bind_address para 0.0.0.0 no arquivo de configuraçoes do mysql.
    # Nesse ponto fiquei com duvidas se foi a melhor forma, mas funcionou.
    database.vm.provision 'shell', path: "reset_pass_mysql.sh"
  end
end