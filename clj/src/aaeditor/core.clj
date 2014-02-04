(ns aaeditor.core
  (:use [clj-webdriver.taxi]
        [clojure.java.io :only (reader)]
        [markdown.core])
  (:import (java.util Properties))
  (:require [org.httpkit.client :as h]))


(defn go-to-article-page! [article-id]
  (let [conf (doto (Properties.) (.load  (reader "aaeditor.properties")))]
    (set-driver! {:browser :firefox} "https://gmtool.allabout.co.jp/g_login/index")
    ;; login
    (quick-fill-submit {"*[name=guideid]" (get conf "guideid")}
                       {"*[name=passwd]" (get conf "passwd")}
                       {"*[name=login]" submit})
    ;; select guidesite
    (do (select-by-text "#guidesiteid" (get conf "guidesite"))
        (click ".btn_cgs"))
    ;; visit contents management page
    (click (find-element-under "ul.menu_index" {:tag :a})) ;; "コンテンツ管理" link
    ;; visit article page
    (click (find-element {:tag :a, :text article-id}))
    ;; focus iframe embedded editor
    (switch-to-frame (element "iframe#Article___Frame"))
    ;; get raw html source
    (Thread/sleep 3000)
    (click (find-element {:tag "td", :class "TB_Button_Text", :text "ソース"}))
    ))

(defn get-html [article-id]
  (go-to-article-page! article-id)
  (Thread/sleep 3000)
  (spit (str article-id ".html")
        ;; (.getAttribute (:webelement (find-element {:tag "textarea", :class "SourceField"})) "value"))
        (value (find-element {:tag "textarea", :class "SourceField"})))
  (Thread/sleep 3000)
  (quit))

(defn set-html [article-id html-file]
  (go-to-article-page! article-id)
  )

(go-to-article-page! 431811)
(get-html 431930)
;; (set-html 431930 "hoge.html")

(defn md->html [title]
  (md-to-html (str "../" title ".md") (str "../" title ".html")))


;; XXXX: convert html to markdown.
;;         => fetch raw html, edit them as jade
;;            https://github.com/ryangreenhall/clj-jade
;; TODO: store other info as yml, then embed into markdown file.
;; TODO: edit and submit jade => update raw html, then show preview.
