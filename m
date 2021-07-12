Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C636F3C6683
	for <lists+linux-can@lfdr.de>; Tue, 13 Jul 2021 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGLWuy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Jul 2021 18:50:54 -0400
Received: from mx.ucr.edu ([138.23.62.3]:39782 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhGLWuy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 12 Jul 2021 18:50:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jul 2021 18:50:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626130086; x=1657666086;
  h=mime-version:from:date:message-id:subject:to;
  bh=ifSIfnXd8bcmUUo9s673T74JcRVcrbFp1qn+wwKzU2I=;
  b=V1xbYhU/VKBqKX2pMNed14wZ0iw792JT/o4KIGg/wtdM/XEzvBLwC7qP
   b8/3wsVpaiveO3j8yd42tgdhCE/BDGb3lqlkSO4ehWR/h9LX/XGe26a2D
   /JFKSvXY4VaKlCaftRzyh6uCKnxv+bo0wil53ezfMbgH9Toa2bBv7Lr8+
   xBPxe1AYIOJTmBQ4LU3PBUqX2v4qtT5haJFeF04Fnv+nq9IU6JFIVCZTH
   7jv2/mKAHVOvsWQYWZXij57tVIjNtFWUXX39V3xno9tLMAp6zHkxc313/
   aReImo4JeHqWo3JVyfNJAl64IBRNAFyYJ/lfWF8d29IJddsA8zSWxmQCz
   g==;
IronPort-SDR: rG8UVcZ+5CMO7UToXb5Klg9L9GsiarchW5ICBIvLCsTbomXxPlVNnzBbah5xpNjVigWt2TIP+l
 QzcUOpo1K4gQXYroQ3J12HoPVWv98WGCEg92D3BsSdNKkoFR5ZHt+NN92lHUjqJL8g/VOCEE4N
 tPD0TnhxaCfGX3K5xPPoZ3AQX4Z3tQ3+LmKmHyoyBjj3gSqmNJKB6YepLTodQxgbFsmCFe2nmn
 EfojV3+fb9GuOLpV5Bg3hxPchijQ6mewo3S77fWoP6YZ+9flIBZnP9tMLtocIJ6tsVQFjQ6ktB
 t3A=
X-IPAS-Result: =?us-ascii?q?A2FnCACRxOxgdEfSVdFagQmBWYN4hTSRWoMnAZJ0hT+Bf?=
 =?us-ascii?q?AIJAQEBD0EEAQGHTwIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBAQEBAQEFBAEBA?=
 =?us-ascii?q?hABb4UvRoI4IoQNEQR4DwImAiQSAQUBIzSCT4MInD2BBD2LMn8zgQGILQEJD?=
 =?us-ascii?q?YFjEn4qhwmCaIQhgimBS4sIgmQEg2ZVgROBP0BTAQEBnwedBQEGAoMKHJ40K?=
 =?us-ascii?q?4NjkhiQVy2URIERn1CFSRAjgTiCFTMaJX8GZ4FMTxkOh3+VDiRnAgYKAQEDC?=
 =?us-ascii?q?Yw1AQE?=
IronPort-PHdr: A9a23:bkIs2R81uSTkjv9uWde8ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 AqGv7491xeJBdydt6sVzbKO8ujJYi8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWmDaxe65+I
 Au5oQjSuMQdnI9uJrosxhfTrXZEZuBbyXl0KV6Pmhr3+9u98oNk/ylMofwq6tROUb/9f6Q2T
 LxYCCopPmUo78D1thfNUBWC6GIEXmoZjhRHDQ7F7ArnXpjqqSv1qvB92CiBMsLoS70/RCmv4
 L1qSB/sjycHKiI5/WTKgcF+kK5XvBSsrAF5zoXJYo+aKeB+c7vSct0aS2RPXdtfWTJdDY6nc
 4sDE/AMMfpEo4XhpVYDqwa1Cwm2BOPozz9Fnn753awg3OQmDQ7G3BIvH9QTu3vXq9X1KboZX
 Oe6zajJyjXDcu9a1Sr/5YXTbxAuveuMUahufsXM1EkiDgXIhUifpoL5JT2azPgNs3SF4Op6U
 +Kik3AqpgFxrDWryckihIrEi4MVx13A6Sh3z5s5KN2mREN4YtOpH5lduiCGOoZ1TM4uXm9mt
 Tg4x7MGpJO3YjUHxYohyhXCaPKHa5CF7gz/WOuVOzt1h3JodKihixqv7USs0O/xWtSy3V1Xt
 CRKiMPMuWoI1xHL78iHTeZy8Vm51DaU0gDT9vlEIUcplarHM5IhwqA/lp4UsUnbGy/5gkT2j
 KuPekUj5uik9v3rYrvkq5OBLYN0hQb+MqMhmsy7H+s0KBQBX2+e+eik1b3j+1P2QKlSg/Eoj
 qXUtIrWKMcbq6KjHQNZz5ov5wy9Aju7yNgYmGMILFNBeBKJlYjpPFTOLej3DPa+hFSsjStny
 +3EM7D6H5XCMmLDnK3/crlg9k5Q0BAzwsxH55JIFrEBJ+r+WkvwtNzeEx84PBW4zPr9B9V7z
 Y4eR22PDbGDMK/Isl+H+PgvI++Sa48Rojr9LOIl5/G9xUM+zFwQZ6+k2bMPZXa3A+h8JEOYc
 Tzgj5NJFWYMoxp7R+XsoEONXCQVZHuoWa84oDYhB8buC4rfSo2zqKKO0T39HZBMYG1CTFeWH
 jOgbJmNUfMBQDydL9UnkTEeU7WlDYg72kKArgj/nopmJ+3f+iAe/aDkyZAh9//UiElrqhRpB
 N7b3m2QGTIn1lgUTiM7ifgs6Xd2zU2OhPAQvg==
IronPort-HdrOrdr: A9a23:vEUbOatRoC8DhWWrsBNcifLA7skDf9V00zEX/kB9WHVpm62j5q
 eTdZsgpHzJYVoqOE3I+urgBEDjewK/yXcd2+B4VotKNzOW3VdAQrsSibcKAAeMJ8Q9zIRgPG
 tbHJSWweedY2RHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="164094779"
Received: from mail-ot1-f71.google.com ([209.85.210.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2021 15:40:40 -0700
Received: by mail-ot1-f71.google.com with SMTP id a60-20020a9d26420000b0290448d2be15e6so14137048otb.23
        for <linux-can@vger.kernel.org>; Mon, 12 Jul 2021 15:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ifSIfnXd8bcmUUo9s673T74JcRVcrbFp1qn+wwKzU2I=;
        b=bAq7SRW4cNntITomnr19C7uU7j4YutiuYLxf8hJ4RAeNHnVRvFMoY7LjyRCg+oPj6R
         z2fjvZGIdCvdzzvuNfIWYivNRW2slZl4FdJ6O75gCIlE9H9rm/IBQAnHBNodKHNV9E9n
         QA3C15MTXQ0LVYq8A/lb/Y9wQ0368QMKmFUME4imgufzouhyPYvloc/xWirHE0WcNZG6
         splak9QwXampTbO0ALNZjMC9B4JfAvZyU2Ph5pB1jg9yAtVhcI5D9K3s7lAI8uusMLt0
         RxAToi59Bg9GKE+iM8bVf85i9jB5oNVVbOEaNIW205WvTYVpiI1uO0G1MnqmePqxoSvq
         N1BQ==
X-Gm-Message-State: AOAM532e3XOyylhSap0/UZ0c0xG2+8ZURdFayBShyu/1O5vetaCAVMMK
        jJDi8KXwwVpVBjTEz5NPxWb+36b66EBoLrjUfaGc+ejRhDVqlu/f1PTdNzmjsOBSZoaHsPd/rnP
        6s2gnKouJaDUmaIyOAl0tSOMo7vHDGxBKhUYLzA==
X-Received: by 2002:a05:6808:485:: with SMTP id z5mr779653oid.173.1626129639549;
        Mon, 12 Jul 2021 15:40:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZfGqHGQmRnC5RP4bUAOLDwdo88/vNQTwKvTmt2dHYkvb/X7zkHNffTLqVK0CNQp9UGHGV5fGxZhg3/cLae1Y=
X-Received: by 2002:a05:6808:485:: with SMTP id z5mr779640oid.173.1626129639340;
 Mon, 12 Jul 2021 15:40:39 -0700 (PDT)
MIME-Version: 1.0
From:   Xiaochen Zou <xzou017@ucr.edu>
Date:   Mon, 12 Jul 2021 15:40:46 -0700
Message-ID: <CAE1SXrtrg4CrWg_rZLUHqWWFHkGnK5Ez0PExJq8-A9d5NjE_-w@mail.gmail.com>
Subject: Use-after-free access in j1939_session_deactivate
To:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,
It looks like there are multiple use-after-free accesses in
j1939_session_deactivate()

static bool j1939_session_deactivate(struct j1939_session *session)
{
bool active;

j1939_session_list_lock(session->priv);
active = j1939_session_deactivate_locked(session); //session can be freed inside
j1939_session_list_unlock(session->priv); // It causes UAF read and write

return active;
}

session can be freed by
j1939_session_deactivate_locked->j1939_session_put->__j1939_session_release->j1939_session_destroy->kfree.
Therefore it makes the unlock function perform UAF access.


Best,
Xiaochen Zou
Department of Computer Science & Engineering
University of California, Riverside
