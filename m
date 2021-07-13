Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA693C6BA9
	for <lists+linux-can@lfdr.de>; Tue, 13 Jul 2021 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGMHtB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Jul 2021 03:49:01 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:34785 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHtA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Jul 2021 03:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626162372; x=1657698372;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=/PDBt9wlRWM1iCLp+k/CLplY3xQTV5OM8VyXbBUUaog=;
  b=AgJvR9YPOYo55oU70TRbahZTMKg6od1iLRg1jd/q48MB0yRH647MZzGo
   J0kj0Itca9NCmteud7SkvM1D4IT24kdwANMioLhFdIcLFwMZp0Qk81k3U
   dApJ92iDZQyQ0dHxDteJs4GxJGap15IX4vMRMHGIa9O7+I6syVgXkFhHe
   D9UZ20fk33PGPNj8w3Hs1L3juNk5b7GpsuMdORnCky/hL8wqCWxii+Zna
   7W7VUk/wPIA3rbF5sTyzNMEdF9Zo02seGtb/0gWCaZkbHG+1ct1fhDu/C
   3Fna1tWb3W4YyVTzLvSq9/6kwyHZk/ptnN8+lA1KF14Gqcwn3Yf33u9TP
   A==;
IronPort-SDR: EzKnXJOUFj61YobJ/eRgXRHouyjBqBiCjFXOt1lVVreyoZhij86313JEMWSFZQonsBd8A0MLPk
 WCBH60W5YQHxQZ0QmSGgUamlPM2UwtXUaVDV8lVLJn//QxoEtAPgzeZXAGz4wjp5hCldc6jncS
 mRJajGvueXM/W2ANJvAwwZtKOXu3ZOlRkKrLgVCHXRwAsCjHS8YHmk1oEJoBau5oNFgRzt9orU
 MiC3YxDB2xR0yxXPFNmXPaOeawShJqvU4p/tJvZ9VDuMRjdds+78Gd5uWjtMDLRhAIyBKfBVmg
 HdA=
X-IPAS-Result: =?us-ascii?q?A2HjAgDOQ+1gdEahVdFaHgEBCxIMQIFOC4MiVmwCGIQuk?=
 =?us-ascii?q?VsDlhuCa4JUgXwCCQEBAQ83CgQBAQMBA4ESgndEAm2CDAIlNAkOAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQUBAQYBAQEBAQEFBAEBAhABb4UvOQ2COCkBUhIDDVYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBIAIBAQEmAggFTQVnAQEBAxIRBFIOAgsLDQICJgICGwcSAQUBH?=
 =?us-ascii?q?AYTCBqCUIMHD5s6gQQ9izJ/M4EBiCEBCQ2BXQYFDX4qhwmGYieCKYFLgQWBa?=
 =?us-ascii?q?j6CYgSEdYJkBIMZTFUYe1JtQFMBAQGfCpp2gg8BBgKDChyKMpQCK4Nji1yFe?=
 =?us-ascii?q?0KQWC2UR41AkxcLhUkQI4E4ghUzGiV/BmeBS1AZDod/hiwWg04zikskLwIBD?=
 =?us-ascii?q?CkCBgoBAQMJh2cBAQ?=
IronPort-PHdr: A9a23:77zHBBRTVs6KWpAD1UIp2jTGntpsohCfAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBcOCt7ka1aKW6/mmBTVRp87Z8TgrS99lb1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 RmosQndrNQajIRtJqswyxbCv39Ed/hLyW9yKl+fghLx6t2s8JJ/9ihbpu4s+dNHXajmZaozU
 KZWDC4hM2A75c3rsQfMQA6S7XYCUWsYjwRFDRHd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy8a
 ZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KI13eQuEwHI0gIjEdwTrnrbsM74NLsOX
 e2v0KXE0SnPYvFQ1Dzg6IbIaBchofSUUL1xcMre004vGB/FjlqOr4zuIjCa1uMQs2OG6OdhW
 uOui2k6qw1tvzSixNwhipTViYIP0FzL6zh2wJssKNC+VUV0bsKqHoFKuCGGK4t5XNkiQ2dwt
 Ss0xLMLpIC3cDUJxZg72RPSaf2KfYeI7B/+VOucISl1iXBrdr+7iRu/7Eeux+/8WMS13lhEr
 ilInsXOu30T2RHe7NWMRPV6/kekwzmP1gbT5/lfLkAzkqrbN5ohwr82lpYJrUvDGSr2lF3uj
 KCIcEUk9fWo6/j9YrXhoJ+cNoB1hhvjPaswnMG0HOc2MhAWUmSF5eix0Kfv8E75TblQk/E7k
 7TVvIrYKMgHoKOyHhVb3Zw56xmlCjeryNEYnX4aI11bYB+HlI3pO03WIPD/EPe/n0ygkDd1y
 PDCOb3sGpDNIWLCkLflZLp97ElcxBcqwdBR5Z9YFqsNIP30Wk/2u9zYCgE2PxaozObgDdVxz
 oIeWWSRDa+FKK7er0OE6+Y1L+SPZIIZoivxJvk46/L0j3I1hUcRfayz0psWbHC4EO5mI0KcY
 Xf0jdYAEGAKvhciQOD3ilCPSiNTaGqoX64m+D40FZ+mAZ/ZRo+xmLyBwDu7HppOa2BCC1CMF
 2rodoqdV/gQci2SJNRskiILVbe/UY8tzxKuuxHgy7phMOXU/jcUtZX51Nh6tKXvkkQX/CZ/R
 +eZ3mCLQiReg28ESndi2aN7iVRwzFiezbJ/hf1IU9BesaBnSAA/YK7dxutxC930EjDGY5/dW
 EShX43/XhksRch3ztMTNRUuU+6+hwzOinL5S4QekKaGUdltqvq04g==
IronPort-HdrOrdr: A9a23:3MwS+6kg84iilj2YOjjkOPZVLs3pDfIX3DAbv31ZSRFFG/FwWf
 re5cjztCWE8Ar5N0tQ/OxoVJPwI080sKQFgrX5Xo3CYOCFghrNEGgK1+KLqAEIWRefygc379
 YGT0ERMqyXMbG4t6vHCcuDeerIDOPpzElgv4ux80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="53814362"
Received: from mail-oo1-f70.google.com ([209.85.161.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jul 2021 00:46:11 -0700
Received: by mail-oo1-f70.google.com with SMTP id g4-20020a4adc840000b029025e89d69142so2734415oou.8
        for <linux-can@vger.kernel.org>; Tue, 13 Jul 2021 00:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0c/itnJRqvseiRzZWaYFdOYbaZVWfzwqyJIgaHRkI4=;
        b=lTN2TFCen3LPEmwHOrz99Hj6Kl7KKZjU10OHAXSR1mNRWPSgupFXgcm/4ZwyJ11qxk
         0Q3dN5UM2YAnErmH+m4gVrjZ+15SIthga5AzO3ReiRboF1GDZIyVr1QThkroscVkWg2A
         rBF4rtf+tA8aVL4e4LsHul95hIpvGqs0hlWFOw6ITJ74/j7rXCdvqzHS7ZrcJhunLKx+
         50sL+sWcjt3GUSDGqFsjTF6MVL2AfwN6la9olZKVr72kgrH3Jx/COtWQFyfP98EI+0LL
         xcywQRV2RYQFzxYvx8y+JySANzhXeX/INOTUb18Ekz9vfuXRrE6KKnpNx8s/GTbs+owf
         Tl1g==
X-Gm-Message-State: AOAM5327ivqUBEDq5LZth7rwe6KNoqVN6OGbVX+Os49Vm6tnnUcjolUV
        Gjbx7G4slucBKbxpjN8KtBggBc9oc7z/EFqrv3h/NaHScOjqRN2/wFLsdhjRNHOch4LP/w87JZu
        yeXtp2PYGAmOlWc5B9k87X/DEniLKEX90ti+TTw==
X-Received: by 2002:a05:6830:1e42:: with SMTP id e2mr2537578otj.135.1626162369807;
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
Subject: Re: Use-after-free access in j1939_session_deactivate
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Greg KH <greg@kroah.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
