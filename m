Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB4342BD5
	for <lists+linux-can@lfdr.de>; Sat, 20 Mar 2021 12:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhCTLND (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 20 Mar 2021 07:13:03 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:37580 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCTLMy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Mar 2021 07:12:54 -0400
Received: by mail-yb1-f171.google.com with SMTP id i9so1059971ybp.4
        for <linux-can@vger.kernel.org>; Sat, 20 Mar 2021 04:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySW40ow135HzzFmg2xHWT+Yy4IT2Z5S8VIKvmAzImSs=;
        b=qv+UE5ZWGclF7iTVEIFcJsClirwJWi/2Y8chs/IAciIL1+ksrZGoXr9t5HIWt/H5fn
         qzIUBdlYNqC9y/uq4NEpG8PwejJOPTa1OAt14iowacmgd2sD4VdWM3A/5ZekoDy9cd2j
         6vwkFAiN9XCsc10abaW0Jz12zOic/94z0GU65oIOgcx45BS4UmYXZoulzzyzREpdEkQa
         DrImX6UihwIIDRxrHYGtV855cmMcfGfiD4DrHfPFHuPN4pAT2oFG1QNiwlkLI2Sn66+s
         VBbEr2/mNrHNJBfxu+NWHw2fanf7tPW0nIPEY8k20wwzJGqkL4kdR3jvlX6p6O4M17P4
         852w==
X-Gm-Message-State: AOAM531KATzgSjp09meZhJMpASqhr94XADMO4jXnWw9/A7c+Oq+JJe0j
        7IIIJ3+4kI/+rSLAykE/HJos8mZLvwPMs3XBioRU2p8FC+baUQ==
X-Google-Smtp-Source: ABdhPJy7GtQZDCOlGpJClGRGOQJIiATGx64dsr59XKxXaoemLLfrLzPQGcN9JWITi9bBafYqxpMHg6OiUxGwwirx7mg=
X-Received: by 2002:a25:bc41:: with SMTP id d1mr11736129ybk.125.1616227393357;
 Sat, 20 Mar 2021 01:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319142700.305648-1-mkl@pengutronix.de> <20210319142700.305648-3-mkl@pengutronix.de>
In-Reply-To: <20210319142700.305648-3-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 20 Mar 2021 17:03:02 +0900
Message-ID: <CAMZ6RqJWBB_YRuTxeM8m_=iOz5ABs1Fq1++tdeEZ7vb=jOG9iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] can: dev: can_free_echo_skb(): extend to return can
 frame length
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 mars 2021 at 23:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> In order to implement byte queue limits (bql) in CAN drivers, the
> length of the CAN frame needs to be passed into the networking stack
> even if the transmission failed for some reason.
>
> To avoid to calculate this length twice, extend can_free_echo_skb() to
> return that value. Convert all users of this function, too.
>
> This patch is the natural extension of commit:
>
> | 9420e1d495e2 ("can: dev: can_get_echo_skb(): extend to return can
> |                frame length")
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[...]
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 95d0a02e408b..724ba72237dc 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -314,7 +314,7 @@ static void es58x_can_free_echo_skb_tail(struct net_device *netdev)
>         struct sk_buff *skb = priv->can.echo_skb[priv->tx_tail & fifo_mask];
>
>         netdev_completed_queue(netdev, 1, can_skb_prv(skb)->frame_len);
> -       can_free_echo_skb(netdev, priv->tx_tail & fifo_mask);
> +       can_free_echo_skb(netdev, priv->tx_tail & fifo_mask, NULL);

Do you already have the etas_es58x driver in can-next/testing?
Or were you working on the wrong branch?
Could you push the last version of can-next/testing? It would be easier for me.


Yours sincerely,
Vincent
