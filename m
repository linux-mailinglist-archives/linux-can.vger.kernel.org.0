Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270072F199F
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbhAKP2E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 10:28:04 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:44380 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbhAKP2B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 10:28:01 -0500
Received: by mail-yb1-f182.google.com with SMTP id f13so149747ybk.11
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 07:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nujb4BJJwAeqDo3UZR+d+saqlQdM8ej2eK7oc3dR2EQ=;
        b=cqa8oK5V0yV0Jbgg2N3WGMeDWBCjxohQ/PCOlfL/YDSpxv9yzncNgdbF0UahRycUXO
         x0lVJ4yo+UaEtP5UGQJst6BD09QJi5yopcKeiQMscHecDH8txA7mbtM+678bkTQyzLdp
         qd3ymu19kA7hlHhpr6srTqIkmqqqAHnK7K5KSxl5VnAzBCgaOS8M74+5YCwJbHCuao9A
         8JhpUqeXTjGUShalOZZ9EoAoLkGfT1rQ4uRh+aCBZPfBuQxqx8otYt7jcMIQRTEcMdcD
         HJGOOWBSBsbQxstjH+JCBkL0HCFDOngO/5dHxigB8sh4fUmwxtxhb9r0kAxbTfjhIe2k
         08Kw==
X-Gm-Message-State: AOAM533l0X++gTGpn61rz0oNAN1/lCkPmBvpUZf4GsXHtQO2/FJ9xKDQ
        tVtxK4G5ANHUqL/ZmjsmMZZTePpAd/FkVkPSEpGwFEEo+P8=
X-Google-Smtp-Source: ABdhPJyV6E7yphe5bA+z/JZi4nE8mpW4mD47G7g30OGC4/0f7xNDdsiHOFZYe1udDVGmqPMxdmWp9LJnYysveWwsNr8=
X-Received: by 2002:a25:4744:: with SMTP id u65mr358275yba.239.1610378840804;
 Mon, 11 Jan 2021 07:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20210111104529.657057-1-mkl@pengutronix.de> <20210111104529.657057-6-mkl@pengutronix.de>
 <CAMZ6RqK=KKskgZ3cXEEzYFGmN8U0vGMt0rGM-5KMS2RH4cgEPQ@mail.gmail.com> <00904775-66c4-58d6-b560-76da0b5a22cc@pengutronix.de>
In-Reply-To: <00904775-66c4-58d6-b560-76da0b5a22cc@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 12 Jan 2021 00:27:09 +0900
Message-ID: <CAMZ6RqJFxhe49pTQt6ivK1jp651ZDn-GpMzx6NnfsYZR1Pxa6A@mail.gmail.com>
Subject: Re: [net-next v2 05/15] can: dev: move skb related into seperate file
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 23:20, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/11/21 1:51 PM, Vincent MAILHOL wrote:
> > On Mon. 11 Jan 2021 at 19:45, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >>
> >> This patch moves the skb related code of the CAN device infrastructure into a
> >> separate file.
> >>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>  drivers/net/can/dev/dev.c | 213 ------------------------------------
> >>  drivers/net/can/dev/skb.c | 220 ++++++++++++++++++++++++++++++++++++++
> >>  include/linux/can/dev.h   |  76 -------------
> >>  include/linux/can/skb.h   |  77 +++++++++++++
> >>  4 files changed, 297 insertions(+), 289 deletions(-)
> >>  create mode 100644 drivers/net/can/dev/skb.c
> >>
> >> [...]
> >
> > Sorry but the changes on drivers/net/can/dev/Makefile are still
> > missing for the skb patch (however, it is now OK for the
> > netlink).
>
> Hopefully fixed this time. Seems I have to compile the whole kernel to notice
> the missing symbols :/

Yep, no more compilation issues!

I will do a few more tests but your v3 seems to be the good
one.

Will also adapt the changes to the ES58x driver and send my v10,
probably tomorrow (it's time to go to bed here).


Yours sincerely,
Vincent
