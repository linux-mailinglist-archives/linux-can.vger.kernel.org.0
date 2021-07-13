Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124C93C6B53
	for <lists+linux-can@lfdr.de>; Tue, 13 Jul 2021 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhGMHke (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Jul 2021 03:40:34 -0400
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:8335 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhGMHkd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Jul 2021 03:40:33 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 03:40:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626161865; x=1657697865;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=Uy3h8jSbfs/h+jDYaxXZtCw4dzE0irLxzHb3QVi8SvA=;
  b=krsMsSfEzYBtBMFtu5iQxjO+w70+8LU4/oW9GGfXRxCvAEHYRURrh1T3
   Fm1VFcWT6P5pESRNuTC6ByTpBAEEnizVqhIL69t566PvRpmr9w2cfmie1
   D72PCqiNf/7v3IFheOtsekr+ykFIO85clZPlSNGMSvzaudWmEI5gXObI5
   OagIt2oWBsI7Y/k9KKkRg4whzHyEuS61yrhL0+ZP0LZd9NeHQRDlQ9p9+
   wqV6kSKd2PJmp/FMJHkd+18qLWGOgUtAKtK861V9sCPOsVgcJUFnnmbwZ
   FYg+ANWrp3T0mO9v/YU2fCEqgfBev5epMrDjKLXMOExsGh8SQr8/gxULZ
   Q==;
IronPort-SDR: S1n5HWilqYv5rcQIvZjxKN8uP/gA/xloXrYfxqEKgpiiAQmGAPBxpEivfJMPGkU1exb6WBhWzM
 0M8uKmqpfWjCkB+IAskxOMjZiEgvQl+VGiNrNlPS4ryJ3pcc8LqoFGjWF7SEk/bhAx/AZG+TiC
 WA4fgDWKXnLCB846GjdhIUPDT8ZM9ucv8KjIeKpXUmTJYstCdud4r/TJaw067O3Ab0uNymDLnn
 4QVTvuqqU5jHoc7PTLpFHawWzUWkGDa8oqElutRwIJuo/lt9k3xpcANdM/4XzyQeCQ7n/my8ME
 XZU=
X-IPAS-Result: =?us-ascii?q?A2GjAgAsQO1gdMWnVdFaHgEBCxIMQIFOC4N4bIRIkVwDl?=
 =?us-ascii?q?huFP4F8AgkBAQEPQQQBAYRUAoJ5AiU0CQ4CBAEBAQEDAgMBAQEBBQEBBgEBA?=
 =?us-ascii?q?QEBAQUEAQECEAFvhS9GgjgpAYNtAQEBAxIRBFIQCwsNAgImAgIiEgEFARwGE?=
 =?us-ascii?q?yKFV5tTgQQ9izJ/M4EBiCEBCQ2BYxJ+KocJhmIngimBS4EFgWo+h1uCZASDG?=
 =?us-ascii?q?UxVOFuBP0BTAQEBnwqadoIPAQYCgwocnjQrg2ORV0KQWC2UR6BihUkQI4E4g?=
 =?us-ascii?q?hUzGiV/BmeBS1AZDod/hiwWjkwkLzgCBgoBAQMJh2cBAQ?=
IronPort-PHdr: A9a23:QJFyrRXk8sQk7FpnriXuigs2u/DV8KzjVTF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB92dsq4P1bSe8/i5HzBZsNDZ6DFKWacPfidNsd8RkQ0kDZzNImzAB9muURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi6sxndutMLjYZtJao8yxrEqWZMd+hK2G9kP12ekwv468uq4JJv7yFcsO89+sBdVqn3Y742R
 qFCAjQ8NGA16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWTSj9
 KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USnRdUcZQTyxBA52zb
 40TD+oaIO1Uq5Dxq0YSoReiAAWhAv7kxD1ViX/sxaA13OohHgPG0gIuHNwArWrao8nuOacOT
 ey41rXEwSnfY/5U3zr29YjGcgomofGJRb9/cMvRxlMoFwzZjlWft4rlNC6W2eQKrmiQ8u1tV
 O2uim4gtgF9viWjy8U3h4nUmo0V0ErI+jtkz4YoPNC1TlNwbtG4HpVKrS6aK5d2Td04Q2Fuo
 Cs3xaMLtYK1cSUIy5kqxhDSZfOHfYWK4B/vSOacLCl7iX9kZb+yiRa8/Euvx+PyWMS50khGo
 jZZn9TNuH4D1wDf586aQfV+5keswSiD2xzX5+1eIk05lbDXJ4Mgz7MyjJYfrEDOEy3wlU7rl
 qGZbF8k9fKt6+n/Z7XmoYKTOJFshwHlN6QuhtS/AeMlMggSR2Sb+fqz1Lnk/UDhRbVFlPw2k
 q3AvJDdJMQXu7e1AwFI3osn6RuzFTim0NMfnXkIKFJKZgiLgJTuO1HLOPz4DPG/jEqwkDpz2
 fzKIrnsDo/OI3XDirvtYLdw5kxGxAYuyd1S5YpYCrQbL/LyXk/xusbYDhg8MwGszOfmCdJ91
 p4CVW6SAKKUK77SvkOS5u41PeaDeZIVtC7nK/c5//7ukWM5mVgFcKmt3JsXbm24H/t/L0qFe
 3XshMwMEXkFvgUgVuzmkl6CXiBJZ3a0Qa084is3CIW8DYfMFciRh+muxiq0Vr52LjRJEF2DO
 XTycIyEHfwLbXTBDNVml2k0VLGmQI8s01mcsxKyn6p1KfeMo3IwqJn5ktV5+ruAxlkJ6TVoA
 pHFgCm2RGZukzZNHmdutJ0=
IronPort-HdrOrdr: A9a23:qtPzyq9uL3Wl7XAc6WBuk+DjI+orL9Y04lQ7vn2ZhyYlC/Bw9v
 re5MjzuiWE7Qr5NEtQ++xofZPwIk80lqQV3WByB8bHYOCOggLBR72Kr7GD/9SKIVyYygcy79
 YHT0G8MrDN5JpB5/oSLDPWLz/o+rXozJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="53784585"
Received: from mail-oi1-f197.google.com ([209.85.167.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jul 2021 00:30:37 -0700
Received: by mail-oi1-f197.google.com with SMTP id i3-20020a5440830000b0290240d559971cso14781582oii.12
        for <linux-can@vger.kernel.org>; Tue, 13 Jul 2021 00:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDD2Q+fBWLzKLVqo6MihicdQ+2ekQXHH6v82dt1m7ug=;
        b=FLIHo+YrVcAf3cKqbeAnB150kPCMz6O+jiNX/J5Za/85XNpFnxiHW7PiL4sMKzLLsW
         cNDq69psr10FOxnsFn29L1cZ7sarwOZL7u2G2KrluJbWWuM0peKZstFeBxx+VXNQeNkD
         HlnpAdUAnqpCyWpBuaMD5YQlGsDiWlP8xUtjsH5EdWf1IAPV5hjTD6NtuvUGhh4TwWFL
         T1WkenRuX7Jy+19HqC2QWqxxzC5ICJ6hmkdrAuHx5TW6XiFCgn6ODXS6Y7+yVEFssZhI
         +Qq3RZ5q7CGcbSwnivtZtmutfSTXDcs8CrF60lbfQOYY8j6YTPbU7g9jife8mFBQWalb
         NCbw==
X-Gm-Message-State: AOAM533F9bK21n3J6h3R21iEwii+WI2zE4LVv33DnOFLU8nydGSLcL1e
        496KnWCEBDAZ/Y925x9Y02NUPYiWed5B/T4WP5zZbToxiTktBDAF3BrACwcN472BONQehsU+sQu
        NO67WStBzgA8kIDs2kzIKy5CR70vys2lCflRaEw==
X-Received: by 2002:a05:6830:1604:: with SMTP id g4mr2357900otr.57.1626161436685;
        Tue, 13 Jul 2021 00:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV3NlabbiVN4+hSJ2ftBWmY3gwiUebuedfsGMLB8buEyZLOA0TyY1lXUMhXESUXtUWj6GuSM/9a0TgGVowM5Y=
X-Received: by 2002:a05:6830:1604:: with SMTP id g4mr2357887otr.57.1626161436495;
 Tue, 13 Jul 2021 00:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAE1SXrtrg4CrWg_rZLUHqWWFHkGnK5Ez0PExJq8-A9d5NjE_-w@mail.gmail.com>
 <YO0Z7s8p7CoetxdW@kroah.com>
In-Reply-To: <YO0Z7s8p7CoetxdW@kroah.com>
From:   Xiaochen Zou <xzou017@ucr.edu>
Date:   Tue, 13 Jul 2021 00:30:34 -0700
Message-ID: <CAE1SXrv2Et9icDf2NesjWmrwbjXL8067Y=D3RnwqpEeZT4OgTg@mail.gmail.com>
Subject: Re: Use-after-free access in j1939_session_deactivate
To:     Greg KH <greg@kroah.com>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

j1939_session_destroy() will free both session and session->priv. It
leads to multiple use-after-free read and write in
j1939_session_deactivate() when session was freed in
j1939_session_deactivate_locked(). The free chain is
j1939_session_deactivate_locked()->
j1939_session_put()->__j1939_session_release()->j1939_session_destroy().
To fix this bug, I moved j1939_session_put() behind
j1939_session_deactivate_locked() and guarded it with a check of
active since the session would be freed only if active is true.

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

On Mon, Jul 12, 2021 at 9:44 PM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jul 12, 2021 at 03:40:46PM -0700, Xiaochen Zou wrote:
> > Hi,
> > It looks like there are multiple use-after-free accesses in
> > j1939_session_deactivate()
> >
> > static bool j1939_session_deactivate(struct j1939_session *session)
> > {
> > bool active;
> >
> > j1939_session_list_lock(session->priv);
> > active = j1939_session_deactivate_locked(session); //session can be freed inside
> > j1939_session_list_unlock(session->priv); // It causes UAF read and write
> >
> > return active;
> > }
> >
> > session can be freed by
> > j1939_session_deactivate_locked->j1939_session_put->__j1939_session_release->j1939_session_destroy->kfree.
> > Therefore it makes the unlock function perform UAF access.
>
> Great, can you make up a patch to fix this issue so you can get credit
> for finding and solving it?
>
> thanks,
>
> greg k-h



-- 
Xiaochen Zou
PhD Student
Department of Computer Science & Engineering
University of California, Riverside
