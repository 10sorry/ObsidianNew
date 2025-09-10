<%*
let title = tp.file.title
let tags = "#linux"
let now = tp.date.now("YYYY-MM-DD")
%>
# <% title %>

Дата: [[<% now %>]]
Теги: <% tags %>
Связи: [[linux]] [[bash]]

---

**Описание**:  
<!-- Краткое описание темы или проблемы -->

**Пример команды**:

```bash
# пример bash-команды
sudo systemctl restart network.service
