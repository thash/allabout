fs   = require 'fs'
sys  = require 'system'
page = require('webpage').create()
# Any console message from a web page, including from the code inside evaluate(),
# will not be displayed by default. To override this behavior, use the onConsoleMessage callback.
page.onConsoleMessage = (msg) -> console.log msg
page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:26.0) Gecko/20100101 Firefox/26.0'

extractBody = (html) -> html.match(/<body[^>]*>([\w|\W]*)<\/body>/im)[1]

f = fs.open('./conf.json', 'r')
conf = JSON.parse(f.read())
conf.debug     = false
conf.articleid = sys.args[1]
conf.content   = if sys.args < 3 then '' else extractBody(fs.open(sys.args[2], 'r').read())

# TODO: make click function DRY
page.open 'https://gmtool.allabout.co.jp/g_login/index', (status) ->
  page.render('aa1.png') if conf.debug
  page.evaluate((conf) ->
    unless document.querySelector('input[name=guideid]')
      console.log "maintenance"
    else
      document.querySelector('input[name=guideid]').value = conf.guideid
      document.querySelector('input[name=passwd]').value = conf.passwd
      document.querySelector('form').submit()
  , conf)

  window.setTimeout( -> # ガイドテーマを選択, 移動
    phantom.exit() if page.url.match(/maintenance/)
    page.render('aa2.png') if conf.debug
    page.evaluate((conf) ->
      document.querySelector('#guidesiteid').value = conf.guidesiteid
      document.getElementsByClassName('btn_cgs')[0].click()
    , conf)

    window.setTimeout( -> # メニューから「コンテンツ管理」を選択
      page.render('aa3.png') if conf.debug
      page.evaluate ->
        elem = document.getElementsByClassName('menu_index')[0].children[0].childNodes[0]
        ((el, etype) ->
          if el.fireEvent
            el.fireEvent 'on' + etype
          else
            evObj = document.createEvent('Events')
            evObj.initEvent etype, true, false
            el.dispatchEvent evObj
        )(elem, 'click')

      window.setTimeout( -> # 記事一覧画面
        page.render('aa4.png') if conf.debug
        page.evaluate((conf) ->
          elems = document.getElementsByTagName('a')
          for elem in elems
            if elem.innerHTML == conf.articleid
              targ = elem
              break
          ((el, etype) ->
            if el.fireEvent
              el.fireEvent 'on' + etype
            else
              evObj = document.createEvent('Events')
              evObj.initEvent etype, true, false
              el.dispatchEvent evObj
          )(targ, 'click')
        , conf)

        window.setTimeout( -> # 記事編集画面
          page.render('aa5.png') if conf.debug
          page.evaluate((conf) ->
            if conf.content.length > 0
              document.getElementsByTagName('textarea')[2].value = conf.content
            document.form.submit()
          , conf)

          window.setTimeout( -> # 記事を保存しました
            page.render('aa6.png') if conf.debug
            page.evaluate((conf) ->
              buttonHTML = document.querySelector('input[name=preview]').outerHTML
              jumpPath   = buttonHTML.replace(/.*onclick="javascript:movePage\('\/\/(.*)',.*/, "$1")
              jumpURL    = "https://#{jumpPath}"
              console.log("https://#{jumpPath}")
            , conf)
            phantom.exit()

          , 7000)
        , 3000)
      , 3000)
    , 3000)
  , 3000)

