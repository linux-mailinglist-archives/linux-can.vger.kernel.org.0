Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE032F80D1
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbhAOQbb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 11:31:31 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:45155 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbhAOQbb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 11:31:31 -0500
Received: by mail-yb1-f174.google.com with SMTP id u18so3294013ybu.12
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 08:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahOi4+HkWlXMAYoBaZ6C5aX11lseloem6QNVHA9Dyb0=;
        b=L6kIjYvb4gmm8VndXP3+w4aheRuIohkpGeGY6yQdlUoHVGlbDiPI8CyZur0ZlR8Rmq
         kkHHI76nQ69/T7QdA0ymY9huMTV7RhiEXCBZJrlg63/4xSNQ1j3vNO3eyS2RYRFzFNTH
         8OGi4K0Jp7OiqlB8rYu2m3wzSexmQ5u8Vb+LOydVewdT01JTJE9qWDn/DnXJ9uKwzRmT
         b+PaV7LZgb2Ru5rANwdrTYPkplRtptC8l+62xgKz0ZMHqjzf232RwrzksqEkqfwwERbk
         d450pW9JT3uOikkcYjeLUoc653Gf9EkW/wdcUPYIG2yD0JxO9ACy+5TDLMO/gyR9EPS4
         W44A==
X-Gm-Message-State: AOAM5305ZtWEnVh3Kha9Gd762cbufXvdk0uceJy8pHVaK2n+/D43oTkb
        jDIsmNHzaepnE3yQrcjKo3MggLWLYHOSZiPx58U=
X-Google-Smtp-Source: ABdhPJxI+kOnXby6LFfDZje73N+IWvD7PggUDmUUXG7Om1ZiZzlQw2VUlqAuJlDsytxkObSjiRyhI4PD1Se7SeXxltI=
X-Received: by 2002:a25:ba05:: with SMTP id t5mr18159360ybg.360.1610728249755;
 Fri, 15 Jan 2021 08:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr> <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de> <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de> <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
In-Reply-To: <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 16 Jan 2021 01:30:38 +0900
Message-ID: <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 15 Jan 2021 at 23:47, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 1/15/21 2:59 PM, Vincent MAILHOL wrote:
> >>>>> I would just like your opinion on one topic: the tdco is specific
> >>>>> to CAN FD. If we add it, we have two choices:
> >>>>>    1. put it in struct can_bittiming: that will mean that we will
> >>>>>       have an unused field for classical CAN (field bittiming of
> >>>>>       struct can_priv).
> >>>>>    2. put it in struct can_priv (but outside of struct
> >>>>>       can_bittiming): no unused field but less pretty.
> >>>>
> >>>> 3. Deprecate struct can_bittiming as the user space interface
> >>>>     and transfer each member individually via netlink. Extend
> >>>>     the kernel-only can_bittiming by the tdc related
> >>>>     parameters, and add these to the new netlink interface.
> >
> > Wow, didn't see that third option coming!
> >
> > By "extend the kernel-only can_bittiming by the tdc related
> > parameters" do you mean to still use a single struct
> > can_bittiming for classical CAN and CAN FD with the tdc
> > parameters in both (a bit like what I suggested in 1.)?
>
> Let's put it this way, we need 3. in order to implement 1. As we need a stable
> userspace ABI.

I was not familiar enough with the netlink interface to foresee
all those dependencies but thanks to your explanations, now
everything starts to make sense.

> Option 4:
> We can introduce a struct can_bitiming_fd with the first member being the struct
> can_bitiming and add tdc related variables after that. This way we can use the
> same function to calculate the bit timing on both CAN and CAN-FD.

While option 3 is slightly easier, my preference will go to option 4.

> What about future developments?
>
> Does anyone have a clue about CAN-XL? Will we ever see real HW?

Recent news would suggest that CiA will release the CAN XL
specification this year:
https://www.can-cia.org/news/cia-in-action/view/a-bright-future-for-can/2021/1/2/

> Or will
> 10Base-T1 and 100Base-T1 take the market?

My guts tell me that 100Base-T1 will take the market for
autonomous driving (camera, Lidar...) and that CAN(-FD) has still
a bright future for safety critical domains, at least in the next
decade. Will CAN XL find its place or will it meet the same
destiny as flexray? I do not know. But once the specification and
the first hardware are out, we would probably start to implement
it in Socket CAN before knowing if it will win the market :)

Nonetheless, if we follow your idea of transferring each member
individually via netlink, then we will have enough flexibility to
adjust the new kernel only can_bitiming structures to our liking.

> There are also these new transceivers in development that should be better
> suited for "special" bus setups.

Do these require additional bittiming parameters?


Yours sincerely,
Vincent

> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
