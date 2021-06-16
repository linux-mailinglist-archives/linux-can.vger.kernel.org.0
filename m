Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37723AA11B
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFPQUV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 12:20:21 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38611 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFPQUU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 12:20:20 -0400
Received: by mail-lf1-f51.google.com with SMTP id r5so5272706lfr.5
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 09:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50El5zFtiyo7178A5KVVuFBhNjIoY1fnUAwbESb+iBM=;
        b=FT1p7lg3GQYmf+D87O5wXF2mQHZ3JzDY1A+jYPKKLppJ+rZT32F3LPXfriAMHPNlfm
         a9V38WOUh/RrleHZWrH9qshGlt5NRNC1pmUnqg6YcaXkgrhblaZ3IbY38Yz4kNOU+QUV
         vp6E87FhrxH16+INr8AZ1hXdglcHmDotFyH4olxg+ocpzmwgC5KH/kD7oR3BTZOjK/Pp
         kk7Pnw7/GJw/shgScuHYWW55iE5gLPtZJuozrVrIr690hdbpOvyEV/gIfeb6LfNKFaIu
         gS42jw/EGQb0uTc2C9p3SM6mhY2ARZ/70M8LG7DFgdhpaNkbHSCry2j/ne6dxPZDMW/7
         icaA==
X-Gm-Message-State: AOAM531aRq6UJjpIX0MDNNTA3y5zyxi1zvmvYDrx169fLT71RECFbmWJ
        d7H+fXjJYc1FJRKQLfyV8ca/2qAkVZrGLxvgfck=
X-Google-Smtp-Source: ABdhPJyoPVzUkqtrJI/qgNnUL2zUWtNPP1w0hsb1XAj14BeTZwQxyq2s9kAMIfhAdmuXXiWUQ9DAB6e71YSalLB/nHQ=
X-Received: by 2002:ac2:5cb9:: with SMTP id e25mr348805lfq.488.1623860292478;
 Wed, 16 Jun 2021 09:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210616124057.60723-1-mailhol.vincent@wanadoo.fr> <20210616133304.txu6tt7v3ezfgvvi@pengutronix.de>
In-Reply-To: <20210616133304.txu6tt7v3ezfgvvi@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 17 Jun 2021 01:18:00 +0900
Message-ID: <CAMZ6RqKF=TkE9099ip2Ac_t+kcC1Ztba6+hzAuTi3-_qLk+Aaw@mail.gmail.com>
Subject: Re: [PATCH] can: bittiming: fix two grammar mistakes in documentation
 for struct can_tdc
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 16 Jun 2021 at 22:33, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 16.06.2021 21:40:57, Vincent Mailhol wrote:
> > This patch fixes two grammar errors in the documentation for struct
> > can_tdc.
> >
> > First grammar error: add a missing third person 's'.
> >
> > Second grammar error: replace "such as" by "such that". The intent is
> > to give a condition, not an example.
> >
> > Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Hi Marc,
> >
> > If that makes sense to you, feel free to squash this in your other
> > patch.
>
> Makes sense. I've added you as Co-developed-by:

Great, thank you!

> |     can: bittiming: fix documentation for struct can_tdc::tdcv

One nitpick: the title should become
|     can: bittiming: fix documentation for struct can_tdc
(without the ::tdcv) because the last fix is on tdco.

> |     This patch fixes a typo in the documentation for struct can_tdc::tdcv.
> |     The number "0" refers to automatic mode not the letter "O".
> |
> |     Further two grammar errors in the documentation for struct can_tdc are
> |     fixed.
> |
> |     First grammar error: add a missing third person 's'.
> |
> |     Second grammar error: replace "such as" by "such that". The intent is
> |     to give a condition, not an example.
> |
> |     Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
> |     Link: https://lore.kernel.org/r/20210616095922.2430415-1-mkl@pengutronix.de
> |     Link: https://lore.kernel.org/r/20210616124057.60723-1-mailhol.vincent@wanadoo.fr
> |     Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> |     Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> |     Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> |     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
