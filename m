Return-Path: <linux-can+bounces-2-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E77E32E7
	for <lists+linux-can@lfdr.de>; Tue,  7 Nov 2023 03:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F8B20AC9
	for <lists+linux-can@lfdr.de>; Tue,  7 Nov 2023 02:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860011C15;
	Tue,  7 Nov 2023 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36720EB;
	Tue,  7 Nov 2023 02:26:55 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5610F;
	Mon,  6 Nov 2023 18:26:54 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-577fff1cae6so3811038a12.1;
        Mon, 06 Nov 2023 18:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699324013; x=1699928813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdOKnPqOiNGc/GoNlDxuW2SGXoTVefUhBh4JImabdU4=;
        b=g1F615k6Lo4tx1iCio8iXMsY3wN3o0sjPEFQkJMzCgCwv4l5Q5tuVykzsPktPTz5Iu
         WoHP7g9qMjgqTB7puffw8V8LArlwXDdgaHnl3HkGwTpB2NfsPFo2Gh7JYITE6LMbpMO/
         n8zmD0buvdfPuXvujSypr/4LtJxTi+pr3zSyhiSblu5snwa1GDuC9W3B588NzOxx9vTc
         g7dfBOv1E3YPpZqhBiGpLKQ6XobEk3AViFSCyuGPasORYDdfEm5CW1iFa6YcEXqN49FF
         YHWgw1rVzV1nTkffWMwC+PxIHHjfuW+XWvj0BVuTGpfHBYym1T2+LPoqkoi7/mj8ZFoo
         0VCg==
X-Gm-Message-State: AOJu0YxuR6cV8A+wlERlp9jFSSpqWIZ2pmp2LVUS0IxaUtpqRmN2zqAM
	vkGEhnXLsvVAyV0IRqyi4TBeCjTYdICda4os5nGzZlFPx9Y=
X-Google-Smtp-Source: AGHT+IF5bnnFsdOCMB+6HZVG0lDLcf+5vAOnE7orT/gq97jehdbGwVu59ZUNe4p9idUDn6OY+A2e6DXHWwdUMPfg6eY=
X-Received: by 2002:a17:90b:390b:b0:27d:d9a:be8b with SMTP id
 ob11-20020a17090b390b00b0027d0d9abe8bmr1854993pjb.6.1699324013367; Mon, 06
 Nov 2023 18:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
In-Reply-To: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 7 Nov 2023 11:26:42 +0900
Message-ID: <CAMZ6Rq+10m=yQ9Cc9gZQegwD=6iCU=s1r78+ogJ4PV0f5_s+tQ@mail.gmail.com>
Subject: Re: [PATCH] can: netlink: Fix TDCO calculation using the old data bittiming
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 7 Nov. 2023 at 03:02, Maxime Jayat
<maxime.jayat@mobile-devices.fr> wrote:
> The TDCO calculation was done using the currently applied data bittiming,
> instead of the newly computed data bittiming, which means that the TDCO
> had an invalid value unless setting the same data bittiming twice.

Nice catch!

Moving the can_calc_tdco() before the memcpy(&priv->data_bittiming,
&dbt, sizeof(dbt)) was one of the last changes I made. And the last
batch of tests did not catch that. Thanks for the patch!

> Fixes: d99755f71a80 ("can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)")
> Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
>  drivers/net/can/dev/netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 036d85ef07f5..dfdc039d92a6 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -346,7 +346,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                         /* Neither of TDC parameters nor TDC flags are
>                          * provided: do calculation
>                          */
> -                       can_calc_tdco(&priv->tdc, priv->tdc_const, &priv->data_bittiming,
> +                       can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
>                                       &priv->ctrlmode, priv->ctrlmode_supported);
>                 } /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
>                    * turned off. TDC is disabled: do nothing
> --
> 2.34.1
>

