Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD83C6BB4
	for <lists+linux-can@lfdr.de>; Tue, 13 Jul 2021 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMHuq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Jul 2021 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHup (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Jul 2021 03:50:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB6C0613DD
        for <linux-can@vger.kernel.org>; Tue, 13 Jul 2021 00:47:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3D90-0005LF-1n; Tue, 13 Jul 2021 09:47:54 +0200
Received: from [IPv6:2a03:f580:87bc:d400:94d2:2c3c:56f3:5c10] (unknown [IPv6:2a03:f580:87bc:d400:94d2:2c3c:56f3:5c10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3D53E64E3E3;
        Tue, 13 Jul 2021 07:47:53 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id Il60CMhE7WCjZQAAs6a69A
        (envelope-from <xzou017@ucr.edu>)
        for <mkl-all@blackshift.org>; Tue, 13 Jul 2021 07:46:16 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E83DD64E3D2
        for <mkl-all@blackshift.org>; Tue, 13 Jul 2021 07:46:15 +0000 (UTC)
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C288464E3D1
        for <ptx@kleine-budde.de>; Tue, 13 Jul 2021 07:46:15 +0000 (UTC)
Received: from mx-lax3-3.ucr.edu ([169.235.156.38])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <xzou017@ucr.edu>)
        id 1m3D7N-00058A-AW
        for mkl@pengutronix.de; Tue, 13 Jul 2021 09:46:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626162373; x=1657698373;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=/PDBt9wlRWM1iCLp+k/CLplY3xQTV5OM8VyXbBUUaog=;
  b=HMfZFzfk8pt9uSePcQBWoY5llAJGZH3+3Oz0xmNrsRUyBETTWyqdvmTw
   6YMgYKv/mSLs5sDqD/trBp+Y97hnAe/uZueXDSGL2SKRJTXooCHBHBnlp
   ziVvQd1oVx2jAx5K33w/eD9HPSh2N/kCzrEYr+j7jJWTkQgp3ehXqkbeP
   JSiJHH+UKPlQWtcuwmWTjsZcyM3zwEEutiYIl9nKdKTMchRYpNhYa2m0X
   rnzkryPytcEX9saX9irA0Kc5TRjEMYmwNKMMGl99Xzzmv8427LlMhITHO
   68yfgJPmU0VnnvD8yvjjLtLrAM6p71FQS+jebsYTaEm+npzgFnXucKqa1
   Q==;
IronPort-SDR: 5wDT96p8dkYwHKTKV2NktS3hLC8ov7xWvdOLjY9wmb5Iq2eAk4DBNg9GivwUYOoEID00S4bjiP
 qCCSYt4sAuKqJthkWudjpO5371Ykk5MTpB21bzvTd9z3BTpPTHIrBxeCSZvP1Cndsj5dSBWVqT
 YKvE1si8eK6JgXJTpYTGKoCgQr9OoZASLV4iFVnltGaUZdMKteNDGTNhTZfzoLvhQHXP6uzzXl
 FZyS5CRiY3vZ/ZA+Vn5KGjRccPEIyiGtxPyPZ6VxJtguZ1N/steOq2N076OEJTUQG5eCfE2Um9
 +z0=
X-IPAS-Result: =?us-ascii?q?A2HnAgAiRO1gdEahVdFaHgEBCxIMQIFOC4MiVmwChEaRW?=
 =?us-ascii?q?wOWG4JrglSBWyECCQEBAQ83CgQBAQMBA4QJRAKCeQIlNAkOAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQUBAQYBAQEBAQEFBAEBAhABb4UvOQ2COCkBUhIQVgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEgAgEBAQEBAQEBAQEBAQEBAQEBAQEWAggFTQVnAQEBAxIRBFIOAgsLD?=
 =?us-ascii?q?QICJgICGwcSAQUBHAYTCBqCUIMHD5s7gQQ9izJ/M4EBiCEBCQ2BXQYFDX4qh?=
 =?us-ascii?q?wmGYieCKYFLgQWBaj6CYgSEdYJkBIMZTFUYe1JtQFMBAQGfCpp2gg8BBgKDC?=
 =?us-ascii?q?hyKMpQCK4Nji1yFew40kFgtlEeNQJMXC4VJECOBOIIVMxolfwZngUtQGQ6Hf?=
 =?us-ascii?q?4YsFoNOM4pLJC8CAQwpAgYKAQEDCYdnAQE?=
IronPort-PHdr: A9a23:VPsDJxPJuSrxZo5LTXAl6nbaDRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv60r1QOCA9uTq6odzbaP4ua4AS1IyK3CmUhKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizexf69+I
 A+roQjeucUbgIpvIbs1xhfVv3dEYetbyX5sKF6Jgxrw+sK894N//ipNvP4s69ROWrjgcaQiS
 rxYAjUmM2Qr68DuqBLOUwiB6GYCX2sPihZHDBTL4x/8Xpfqryv1rfF91zWAPc33Vr87RzKv5
 Lp2RRDyiScHMzk58HzLisF1kalWrg6tqwB5zoXJe4yeKuZwcb3BctMbXWpBX9heVypdAoOnc
 oADC/MNMftEo4XholcDqwa1CwuxC+P10jJHiXH20q863eovEg/IwRIuEM4VvXTIsNn4LrseX
 fypwKTKyzjIcvNY2S366IjNah0uoPCMUqh3ccXNyUkgCQXFhUiTpoziIjOey+MAsmea7upnS
 OKjl3MrpgNqrziy2sgskJPFiZwIxVDZ7Ch0xps+KtKkRkBhe9GkDIdQuD+AN4twWs4vTW9mt
 TskxrEbupO3YDYHxZYmyhDQa/KKboiF7xL9WeuTLzl1gHxoda+wiRuw8Uaty+PyWMm33VpWr
 CdIjNfBu3YQ3BLd7ciHT+Fy/kan2TuXzA/T7eZEIVwwlaraLZ4t2KI/lp0WsUjbBi/5hkP2j
 KCLdkU44Oio7OLnYrTpp5OGKoB7lAfzObktlMynGek0LBQCUmyB9em/1LDv51D1TbRXgvEsk
 KTVrJbXLtkBqKGjGQ9ayIMj5g66DzehzdsXg2EKLElAeBKbl4jpPEzOIOzgAfe/nVuslDBry
 ujDPrL7A5XNKmHPkLDmfbpg8kJcxgg+wcxF65JbDbEBJ/3zWkvvu9DCEhA5NAm0z/7mCNV7y
 IweRXqCDrGFPK7Wq1OF5eIiL/ORaIIUpTrxMfoo6+L2gX88g1AdfK2p3ZUNaHC/G/RrO0qYY
 HvrgtccDWsGowgzQff3iFKeSz5ffWi9UL8h5j0jEoKpEZ/DRpyxgLyGxCq7G55WZmRdB1CUD
 3jocYqEW+oQaCKIJc9hlD0EVLe7R4A8yx79/DP9np9uNOGc2SkVtJTukfJo6+He3UU39jhcF
 8mb3HyRVWZyn3NOSzJgj45lpkko+laK1qN4jvoQJ9tOr6dZQAAnbceD5/FxEZb/Vh+XLYTBc
 0qvXtjzWWJ5ddk22dJbJh8lQ72f
IronPort-HdrOrdr: A9a23:5Kcg+az3bN31NgNj99ziKrPwF71zdoMgy1knxilNoNJuA7Wlfq
 GV7YwmPHDP+VMssR0b6LK90ey7MBDhHP1OgLX5X43SODUO0VHAROpfBMnZowEIcBeOkdK1u5
 0QFZSWy+ecMbG5t6zHCcWDfOrICePqnpyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="56872339"
Received: from mail-oo1-f70.google.com ([209.85.161.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jul 2021 00:46:10 -0700
Received: by mail-oo1-f70.google.com with SMTP id k19-20020a4ae2930000b029025d87cea48fso3841109oot.19
        for <mkl@pengutronix.de>; Tue, 13 Jul 2021 00:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0c/itnJRqvseiRzZWaYFdOYbaZVWfzwqyJIgaHRkI4=;
        b=BkCj49wPRI+lQmxIYakJCXw8VcOj8auQ26l5qpkA/ieSIC+ziZhSPW0pFJ4FmlW5yV
         sfHxfXi9gltIe/HRo+3XdLPY4FVvoGBU0dDfC7XYUhqNLkdiawVGO9dkViGCUhg3PgeT
         xl3OrpWSl2wxIrZirynVbI13I3r7yVlBJd6vG7fo9JoopLHL9ruOe48tpmfASSNzi5mo
         AVNUsOO48uzPP2U7+lpCHafpkho4B67hhtCvK34tjwnO9nQTGb3nGltCBrKN3tPJmZmd
         tcqthDjt4z2Ii1Y7ax6K2Vv4QZde19F7lHQP87YIRi/QCK9k+oYneeW5tXR+YGCy/9PK
         YlXA==
X-Gm-Message-State: AOAM530MgwVvA9gkgc4wMDON2d57XwsCsLgwgXmOrsXQvOCR0viiRHc7
        c5EQEm5jGy17kK4XxMZCoFbg31ZHUsRnF5HEOUqLGjFfItyUq5vhsUxXWBrOk0JhMKGyAiQdkiF
        08LDvhRNEVK8fCiTWgXwiaIREmjC4
X-Received: by 2002:a05:6830:1e42:: with SMTP id e2mr2537577otj.135.1626162369805;
        Tue, 13 Jul 2021 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBf6asctnycGHrf0aHsUd7mMNxKyN11KyP8TucFVKHbFU6gvW9YJZO6cqXJ6+ucEspUXAJ06v7fWy8ISSDRwE=
X-Received: by 2002:a05:6830:1e42:: with SMTP id e2mr2537573otj.135.1626162369633;
 Tue, 13 Jul 2021 00:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAE1SXrtrg4CrWg_rZLUHqWWFHkGnK5Ez0PExJq8-A9d5NjE_-w@mail.gmail.com>
 <YO0Z7s8p7CoetxdW@kroah.com> <CAE1SXrv2Et9icDf2NesjWmrwbjXL8067Y=D3RnwqpEeZT4OgTg@mail.gmail.com>
 <e1f71c33-a5dd-82b1-2dce-be4f052d6aa6@pengutronix.de>
In-Reply-To: <e1f71c33-a5dd-82b1-2dce-be4f052d6aa6@pengutronix.de>
From:   Xiaochen Zou <xzou017@ucr.edu>
Date:   Tue, 13 Jul 2021 00:46:07 -0700
Message-ID: <CAE1SXrv3Ouwt4Y9NEWGi0WO701w1YP1ruMSxraZr4PZTGsUZgg@mail.gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Greg KH <greg@kroah.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=4.0 tests=AWL,BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Use-after-free access in j1939_session_deactivate
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

j1939_session_destroy() will free both session and session->priv. It
leads to multiple use-after-free read and write in
j1939_session_deactivate() when session was freed in
j1939_session_deactivate_locked(). The free chain is
j1939_session_deactivate_locked()->j1939_session_put()->__j1939_session_release()->j1939_session_destroy().
To fix this bug, I moved j1939_session_put() behind
j1939_session_deactivate_locked() and guarded it with a check of
active since the session would be freed only if active is true.

Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e5f1a56994c6..b6448f29a4bd 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1018,7 +1018,6 @@ static bool
j1939_session_deactivate_locked(struct j1939_session *session)

        list_del_init(&session->active_session_list_entry);
        session->state = J1939_SESSION_DONE;
-       j1939_session_put(session);
    }

    return active;
@@ -1031,6 +1030,9 @@ static bool j1939_session_deactivate(struct
j1939_session *session)
    j1939_session_list_lock(session->priv);
    active = j1939_session_deactivate_locked(session);
    j1939_session_list_unlock(session->priv);
+   if (active) {
+       j1939_session_put(session);
+   }

    return active;
 }
@@ -2021,6 +2023,7 @@ void j1939_simple_recv(struct j1939_priv *priv,
struct sk_buff *skb)
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 {
    struct j1939_session *session, *saved;
+   bool active;

    netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
    j1939_session_list_lock(priv);
@@ -2030,7 +2033,10 @@ int j1939_cancel_active_session(struct
j1939_priv *priv, struct sock *sk)
        if (!sk || sk == session->sk) {
            j1939_session_timers_cancel(session);
            session->err = ESHUTDOWN;
-           j1939_session_deactivate_locked(session);
+           active = j1939_session_deactivate_locked(session);
+           if (active) {
+               j1939_session_put(session);
+           }
        }
    }
    j1939_session_list_unlock(priv);

On Tue, Jul 13, 2021 at 12:35 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/13/21 9:30 AM, Xiaochen Zou wrote:
> > j1939_session_destroy() will free both session and session->priv. It
> > leads to multiple use-after-free read and write in
> > j1939_session_deactivate() when session was freed in
> > j1939_session_deactivate_locked(). The free chain is
> > j1939_session_deactivate_locked()->
> > j1939_session_put()->__j1939_session_release()->j1939_session_destroy().
> > To fix this bug, I moved j1939_session_put() behind
> > j1939_session_deactivate_locked() and guarded it with a check of
> > active since the session would be freed only if active is true.
>
> Please include your Signed-off-by.
> See
> https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitting-patches.rst#L356
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>


-- 
Xiaochen Zou
PhD Student
Department of Computer Science & Engineering
University of California, Riverside

