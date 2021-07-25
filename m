Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0183D4D23
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGYKE0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhGYKE0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 06:04:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1CC061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 03:44:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id he41so10890010ejc.6
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9tDKxxu1nBGHpGHrqePXfcY3AA21uJAxfWtTn10vj8=;
        b=ksTXzhRkolw8RucLcC5bz4krKNH1JlMe4GEJJlM6aI6a4d/QWhhuFuDsbJNyNynRBn
         CKeCJHENNQVScIe5hdm7bnCf9Qv+HVnOTWVzkOMXIgXhiKw8TORfFhwogon/mv5Q0aeE
         S50EUPWSUC0rBjRdm4UghdynO4BVEJlm758TZxpr7ZnKG/gG2khXVvg2Ts2KHXv2cgYq
         qYaPeLvpYttFEisMKvvndfdtG3M1ZxRQldK81yNz+3YZswTWpBHEnB8l0fznLD+hWfOc
         SLR7GcYGFf5/cll5CRIESiwSacALH3Fm2NWixEv5E4HFZnfKxnWsWCZ5a2ttDx8LkpHj
         Y4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9tDKxxu1nBGHpGHrqePXfcY3AA21uJAxfWtTn10vj8=;
        b=GtcwzhhVOs2Yd/0WLXBvhi2RHmpcqugz1GatW7rbaUgVWHVG5z0Fosl3pZJqnZADra
         xCzbkXnnQfzX6Sp0MUvsMx5YufH3siKdM+Xsk291EPKirK58sIC6cu/oTx9zcRHcf4qt
         jhv2RTGXtu6Z3GoOG5rX3XDddXXsefxtjizNoL5zwDifdKhz2eus63ZLjFHooK6I8azo
         u2dmxX5cISx4eOyew3A+n7NJOb1Sbv17AQek0GgSUO/qgmIJPRScOSGRYGHLuIq4noGt
         0hZGZD/t1jhS8jmTrhKYmI17bPA3DEPavMf62DkVaKEFFSkoxj8NbsE+udwKjZzSJGrK
         UVQQ==
X-Gm-Message-State: AOAM531N4oEqhoYFI00qex5zKWoHfAw1J8GUTFD4S1H738Th4sTQfDWZ
        cSd4Z63AX6rAVYMQR0dcn6G/fEMWyC/iiJvYWuI=
X-Google-Smtp-Source: ABdhPJxHqo49kRcAS9X3k7dxD2twK3suPLbQ/VU+8+LnKIwyRPCA1ccoFQMk15hXku/recnsm3KS55mw1RDJ9gW2nro=
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr15650464edu.328.1627209894992;
 Sun, 25 Jul 2021 03:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com>
In-Reply-To: <20210725111242.2d9a819f@gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Sun, 25 Jul 2021 19:44:43 +0900
Message-ID: <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-can@vger.kernel.org, mkl@pengutronix.de,
        Yasushi SHOJI <yashi@spacecubics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Pavel,

On Sun, Jul 25, 2021 at 5:12 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> Can You try the following patch?
>
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> index a45865bd7254..a1a154c08b7f 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -653,6 +653,8 @@ static int mcba_usb_start(struct mcba_priv *priv)
>                         break;
>                 }
>
> +               urb->transfer_dma = buf_dma;
> +
>                 usb_fill_bulk_urb(urb, priv->udev,
>                                   usb_rcvbulkpipe(priv->udev, MCBA_USB_EP_IN),
>                                   buf, MCBA_USB_RX_BUFF_SIZE,

Yup, this patch fixed it.  I've tested on top of v5.10.52.

Tested-by: Yasushi SHOJI <yashi@spacecubics.com>

> I am sorry for breaking your device :(

No problem.  It'd be nice if we'd test with real hardware before
merging into the stable tree, though.
Anyway, thank you for your quick fix!

Best regards,
--
               yashi
