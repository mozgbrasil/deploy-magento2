[checkmark]: https://raw.githubusercontent.com/mozgbrasil/mozgbrasil.github.io/master/assets/images/logos/logo_32_32.png "MOZG"
![valid XHTML][checkmark]

[getcomposer]: https://getcomposer.org/
[uninstall-mods]: https://getcomposer.org/doc/03-cli.md#remove

# Deploy\Magento2

## Sinopse

Automação para implantação de projeto [Magento2](https://magento.com/)

## Motivação

Evangelizar a plataforma [Magento2](https://magento.com/)

## Característica técnica

Para o aplicativo o Heroku usa o arquvo [app.json](app.json)

Para a implantação o Heroku usa o arquvo [composer.json](composer.json)

Como a Heroku trabalha com o [Composer](https://getcomposer.org/), todas as dependências a ser usada no projeto está registrada no arquivo [composer.json](composer.json)

## Implantando na Heroku

Clique no botão abaixo para implantar o aplicativo na sua conta na [Heroku](https://www.heroku.com/pricing) usando o plano gratuito

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mozgbrasil/deploy-magento2)

Efetue o preenchimento dos campos relativo ao banco de dados, para o campo "MAGE_URL" altere em "APP_NAME" pelo nome do aplicativo

Em seguida clique no botão "Deploy"

Ao finalizar a implantação do aplicativo será exibido a mensagem "Your app was successfully deployed."

Clique no botão "View"

Será carregado o aplicativo exibindo o diretório raiz, acesse a pasta magento para utilizar a plataforma

    Importe o banco de dados de um projeto funcional antes de utilizar o aplicativo

    Não utilize HTTPS

## Útil

https://devdocs.magento.com/guides/v2.3/config-guide/config/config-php.html

https://medium.com/elefante-yogue/usando-php-com-heroku-e7d4f2fee56a

## Executando em ambiente local

    git clone https://github.com/mozgbrasil/deploy-magento2
    cp env-example .env
    nano .env
    composer install

## Magento

Atualmente um projeto Magento ideal é gerenciado completamente pelo Composer, a fim de obter as seguintes melhorias

- [✓] Magento sempre atualizado;
- [✓] Módulos sempre atualizados;
- [✓] Template sempre atualizado;

Veja esse vídeo onde eu demonstro a atualização do Magento via Composer

https://www.youtube.com/watch?v=QT1bIyqZaos

Utilize o Composer e tenha sempre um projeto atualizado

Sobre templates, considero a melhor prática o uso do template da empresa Porto, descentralizando esse processo e obtendo atualizações recorrentes dessa equipe

http://www.portotheme.com/magento/porto_landing/

Veja as diversas possibilidades de temas, todos altamente customizável

Precisa de um projeto para ação de Comércio eletrônico, utilize a melhor plataforma, utilize o Magento, entre em contato conosco

Conheça a nossa trajetória de sucesso construída com muito empenho, compromisso, ética e profissionalismo.

[CEREBRUM](https://www.cerebrum.com.br/ "Magento")

Quer aprender sobre Magento, acesse a Comunidade Magento

[Comunidade Magento](https://www.comunidademagento.com.br/ "Magento")

Precisa de módulos para Magento, instale os módulos da MOZG em seu projeto Magento

[MOZG](http://mozg.com.br/catalogo/ "Magento")

## Demonstração

<a href="http://magento2mozg.herokuapp.com/magento/index.php/admin/" target="_blank">Clique aqui para acesso ao backend</a>

Utilize os seguintes dados para acesso

    admin / 123456a

<a href="http://magento2mozg.herokuapp.com/magento/index.php/" target="_blank">Clique aqui para acesso ao frontend</a>

## Recursos do projeto

No uso do Composer todo os recursos é relacionado no manifesto do projeto

<a href="http://magento2mozg.herokuapp.com/composer.json" target="_blank">Clique aqui para acesso manifesto do projeto</a>

## Sobre o aplicativo para o Heroku

Esse aplicativo foi desenvolvido pela [MOZG](http://mozg.com.br/) e se encontra disponível no seguinte repositório no github [https://github.com/mozgbrasil/deploy-magento2](https://github.com/mozgbrasil/deploy-magento2), qualquer contribuição é bem vinda.

# Considerações

Se você gostou deste projeto, considere dar um 🌟 ou doar.

- [![pagseguro](https://stc.pagseguro.uol.com.br/public/img/botoes/doacoes/164x37-doar-assina.gif)](https://pagseguro.uol.com.br/checkout/v2/donation.html?currency=BRL&receiverEmail=mozgbrasil@gmail.com)
- [![Star on GitHub](https://img.shields.io/github/stars/mozgbrasil/deploy-magento2.svg?style=social)](https://github.com/mozgbrasil/deploy-magento2/stargazers)
- [![Watch on GitHub](https://img.shields.io/github/watchers/mozgbrasil/deploy-magento2.svg?style=social)](https://github.com/mozgbrasil/deploy-magento2/watchers)

Verifique também minha [Conta GitHub](https://github.com/mozgbrasil), onde eu tenho outros artigos e aplicativos que você pode achar interessantes.

## Para contratar 👨💻

Se você quiser que eu o ajude, estou disponível para contratar.

Entre em contato com suporte@mozg.com.br

## Onde seguir

Você pode me seguir nas mídias sociais 🐙😇, nos seguintes locais:

- [GitHub](https://github.com/mozgbrasil)
- [Twitter](https://twitter.com/mozgbrasil)

## Mais sobre mim

Eu não só vivo no GitHub, eu tento fazer muitas coisas para não me aborrecer 🙃. Para saber mais sobre mim, você pode visitar os seguintes links:

- [Artigos](http://mozg.com.br/artigos/)

:cat2:
