Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB4687CAC
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjBBLvS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBBLvR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:51:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F816A33B
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:51:16 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 203so993567pfx.6
        for <linux-can@vger.kernel.org>; Thu, 02 Feb 2023 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ao4DHa7dWexR005zTKPEVfkHggp+0CqHAD3ghfxR3KQ=;
        b=dW++iO84uhn9ZeOGiqMyB2hF/82CIerlv6VYyaZWDHIIjCm0IDDBPPgw+7sHRR1a/Y
         usuf2qIneQOSz5qWuSP+la6bjsDDpC/IpFym/FiRVSYxEcegzGeyx31X5hu6KMidLT3g
         XvvIBKR+1qE4XCRAOp0hlQmBluhfuRa5IlAiw8kyk1Hmbrfwd9Yexvjqqcu01EmNhfQw
         vSbzls5ealiw6wSOUwjzK2PF+gyQ34+P4/skq/mm5LABwUYvHGHXs+L23d5WVBu3xDzh
         xM+wSsU/8eU4ArwOVPMwlKEjChzIYEFE5bFpLBr8syBM+5xR890rPwIwL3IJvlYwSFQs
         xagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ao4DHa7dWexR005zTKPEVfkHggp+0CqHAD3ghfxR3KQ=;
        b=ccaw+D+0Cs2NnpVlbcF+HAzeYglR6veILII2fxT74ueWeU2ycb0jO1lOHb6rOywxnZ
         esgqYGtQ1SS7tY9q89JmaXMOMfQezxzzI1sYFdisCoCrsNBY0bMGyV5u3kOhdb8/sCot
         6LIBfJsFagjCkLOq2UWP46r2hMjsL653gsTwC41pD6WgROSzH7Q+T+Z2BznP9r1RklXD
         1SWHsmzbIlH7MY/Qyh9xdEKuad13u0fNBGk/eVRFvTP/q+LVy1WAS3E23nwMcfdknAyc
         oWcaJI+bcr88XqWRpecmJAFl/+pCB0qwWq2NwJnnUg8Q4YwBQq1EohctBT1Wr60gjj2V
         ScYw==
X-Gm-Message-State: AO0yUKUUJgrhxpdtWnkKi32J/ktbHdBJK5Tlq+ZuY2Lb12RtM4/C0Sba
        wt1XRXJ6q1tHqt7RrOEbZoaPdLMRIE0gBbK0b7E=
X-Google-Smtp-Source: AK7set+y8vmrp6OAcplRtqRKoJ5YI5Sw9lCXEIV3/6JJqJ1pjUFXQ87N/yJkv1jFDWjT7XwrGMekQjmBQre6pwG7UAQ=
X-Received: by 2002:aa7:938e:0:b0:593:d7d7:17cb with SMTP id
 t14-20020aa7938e000000b00593d7d717cbmr1225853pfe.5.1675338675590; Thu, 02 Feb
 2023 03:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20230202110854.2318594-1-mkl@pengutronix.de> <20230202110854.2318594-11-mkl@pengutronix.de>
In-Reply-To: <20230202110854.2318594-11-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 2 Feb 2023 20:51:04 +0900
Message-ID: <CAMZ6RqJuUvTo=LAYdHQryjcr+FD+o=-_TJmrwjpgiixN6dTyFw@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] can: bittiming: factor out can_sjw_set_default()
 and can_sjw_check()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 2 Feb. 2023 at 20:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Factor out the functionality of assigning a SJW default value into
> can_sjw_set_default() and the checking the SJW limits into
> can_sjw_check().
>
> This functions will be improved and called from a different function
> in the following patches.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/bittiming.c | 30 ++++++++++++++++++++++++++----
>  include/linux/can/bittiming.h   |  5 +++++
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
> index 0b0b8c767c5b..101de1b3bf30 100644
> --- a/drivers/net/can/dev/bittiming.c
> +++ b/drivers/net/can/dev/bittiming.c
> @@ -6,6 +6,24 @@
>
>  #include <linux/can/dev.h>
>
> +void can_sjw_set_default(struct can_bittiming *bt)
> +{
> +       if (bt->sjw)
> +               return;
> +
> +       /* If user space provides no sjw, use 1 as default */
> +       bt->sjw = 1;
> +}
> +
> +int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
> +                 const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
> +{
> +       if (bt->sjw > btc->sjw_max)
> +               return -ERANGE;

You return -ERANGE here but then replace it by -EINVAL in patch #12.
Better to directly return -EINVAL here.

> +       return 0;
> +}
> +
>  /* Checks the validity of the specified bit-timing parameters prop_seg,
>   * phase_seg1, phase_seg2 and sjw and tries to determine the bitrate
>   * prescaler value brp. You can find more information in the header
> @@ -18,12 +36,16 @@ static int can_fixup_bittiming(const struct net_device *dev, struct can_bittimin
>         const struct can_priv *priv = netdev_priv(dev);
>         unsigned int tseg1;
>         u64 brp64;
> +       int err;
> +
> +       can_sjw_set_default(bt);
> +
> +       err = can_sjw_check(dev, bt, btc, extack);
> +       if (err)
> +               return err;
>
>         tseg1 = bt->prop_seg + bt->phase_seg1;
> -       if (!bt->sjw)
> -               bt->sjw = 1;
> -       if (bt->sjw > btc->sjw_max ||
> -           tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
> +       if (tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
>             bt->phase_seg2 < btc->tseg2_min || bt->phase_seg2 > btc->tseg2_max)
>                 return -ERANGE;
>
> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
> index 53d693ae5397..6cb2ae308e3f 100644
> --- a/include/linux/can/bittiming.h
> +++ b/include/linux/can/bittiming.h
> @@ -138,6 +138,11 @@ can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
>  }
>  #endif /* CONFIG_CAN_CALC_BITTIMING */
>
> +void can_sjw_set_default(struct can_bittiming *bt);
> +
> +int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
> +                 const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
> +
>  int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>                       const struct can_bittiming_const *btc,
>                       const u32 *bitrate_const,
