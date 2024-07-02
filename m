Return-Path: <linux-can+bounces-940-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF091EDF2
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 06:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ACE1C21E26
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 04:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F618E0E;
	Tue,  2 Jul 2024 04:48:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E13211
	for <linux-can@vger.kernel.org>; Tue,  2 Jul 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895691; cv=none; b=F4sUlpxUNi+qcakoMNIlrCBJqWWFTTSOPluLMXmR/UOrcLTon5xLAPIbNg2k7wYvgJIy3sh2WKAlSqP0h/Hb5KF/Fl1TOes1PzFQxT0FXRsIi1/cGEmvCKt6uonwLjaMYJQr1ZxWlqZZSZKoY71JDXBZx/r93t7LLiVzaOaMiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895691; c=relaxed/simple;
	bh=mFqjqun7Vo/xTI8k+m1nyv85ofRGYrvGbXZoBLNCwfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn0ahEditKyhqZY4OZjgs1cCgpWbazuSPfPB1eHgtZtAzraRVwYW1AQcto/qqXnwC7AHMk25slOK4bZI2oaR7V6aJA/yLmmV3P3e9ppYk5arSJ40IWgL4lDxgKe74lzi2FSIAs7cTGHcADe5L4JWEX4XL2GJbZU0GpOPqZNsByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so2130223a91.3
        for <linux-can@vger.kernel.org>; Mon, 01 Jul 2024 21:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719895688; x=1720500488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1E48QhkycDdi4aw1isIaxZQUmVXDAngOaeA2YDZ+pQ=;
        b=X8an+UX7l+dWKBx1nX+3xBgolboV5wxH0Xpt+Y5ZY+3gD1Q27wsVzZOsf+W+lw7neD
         B9gtwMzmwY0UnWwVllLFUafitE2HtD/u/98qG0PA+PcCutQe7pHaqWBnj3D0qcfMlSmU
         Bno0tnIK9RRlD7aEXB4LxWqBhgqbg8Ie92RDzSbgZzqW4umaDIuLyUo2Ga9D9L068txp
         yzNqTPDtbwiXgIEy1mRVdDCmJylipYwPGNGYkx91ualWkRFgjBu6DuGjZwd5gDdTg2dR
         ZATMD1V36JP60s1L+SVDTbeQ1sOU0K8x/dANWbqSHz5P0A27QQVI4TPshohkgQT3Oe/d
         nP1Q==
X-Gm-Message-State: AOJu0YwFFHgQrYv79QCEHdDgRv2rV6irBgu+oR2TYnlV2g04xChhA101
	MEaMIEpXgScyRHhK7uwrTGzaJFV3P41S/1LtOAA8cyVqhvO6ex62/sEt29EXJO/oRxDifRlmGHU
	CrPhj9k60CZnpC6a5u06BcJaL0mg=
X-Google-Smtp-Source: AGHT+IExmmniXYfpQsHsA8o5oPfHsgmchfLO7aBkPWXhKovpaudOUo/R9/tYf/KCUDbd9JlCRg9q5aExqnYXF/iHGVs=
X-Received: by 2002:a17:90a:ac8:b0:2c5:12b5:b816 with SMTP id
 98e67ed59e1d1-2c93d77cf94mr4141956a91.48.1719895688317; Mon, 01 Jul 2024
 21:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701154936.92633-1-extja@kvaser.com> <20240701154936.92633-2-extja@kvaser.com>
In-Reply-To: <20240701154936.92633-2-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 2 Jul 2024 13:47:56 +0900
Message-ID: <CAMZ6RqJFBooOgvrq4XmQDf_dFKMTe1hDnWLRObKEWA2t-U5+uQ@mail.gmail.com>
Subject: Re: [PATCH can-next v2 01/15] can: kvaser_usb: Add helper functions
 to convert device timestamp into ktime
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue. 2 juil. 2024 at 00:50, Jimmy Assarsson <extja@kvaser.com> wrote:
> Add helper function kvaser_usb_ticks_to_ktime() that converts from
> device ticks to ktime.
> And kvaser_usb_timestamp{48,64}_to_ktime() that converts from device
> 48-bit or 64-bit timestamp, to ktime.
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
> Changes in v2:
>   - New in v2. Replaces
>     can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
>   - Add two more helper functions, kvaser_usb_timestamp{48,64}_to_ktime()
>     for converting timestamps, suggested by Vincent MAILHOL [2][3]
> [2] https://lore.kernel.org/linux-can/CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com/
> [3] https://lore.kernel.org/linux-can/CAMZ6Rq+Xd7+th=dKV+vrqzRtS+GY-xq2UziH1CURcQ3HxEXMqQ@mail.gmail.com/
>
>  drivers/net/can/usb/kvaser_usb/kvaser_usb.h   | 24 +++++++++++++++++++
>  .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 10 ++++----
>  2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> index ff10b3790d84..4256a0caae20 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> @@ -22,6 +22,8 @@
>   */
>
>  #include <linux/completion.h>
> +#include <linux/ktime.h>
> +#include <linux/math64.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/usb.h>
> @@ -216,4 +218,26 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
>
>  extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
>
> +static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
> +                                               u64 ticks)
> +{
> +       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
> +}
> +
> +static inline ktime_t kvaser_usb_timestamp48_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
> +                                                     const __le16 *timestamp)
> +{
> +       u64 ticks = le16_to_cpu(timestamp[0]) |
> +                   (u64)(le16_to_cpu(timestamp[1])) << 16 |
> +                   (u64)(le16_to_cpu(timestamp[2])) << 32;
> +
> +       return kvaser_usb_ticks_to_ktime(cfg, ticks);
> +}
> +
> +static inline ktime_t kvaser_usb_timestamp64_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
> +                                                     __le64 timestamp)
> +{
> +       return kvaser_usb_ticks_to_ktime(cfg, le64_to_cpu(timestamp));
> +}
> +
>  #endif /* KVASER_USB_H */
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index c7ba768dfe17..ad1c6101a0cd 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -526,19 +526,17 @@ static ktime_t
>  kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
>                                    const struct kvaser_cmd *cmd)
>  {
> -       u64 ticks;
> +       ktime_t hwtstamp = 0;
>
>         if (cmd->header.cmd_no == CMD_EXTENDED) {
>                 struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
>
> -               ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
> +               hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
>         } else {
> -               ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
> -               ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
> -               ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
> +               hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
>         }
>
> -       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
> +       return hwtstamp;
>  }

Nitpick: this can slightly be simplified by dropping the hwtstamp
local variable:

  kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
                                     const struct kvaser_cmd *cmd)
  {
         if (cmd->header.cmd_no == CMD_EXTENDED) {
                 struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;

                 return kvaser_usb_timestamp64_to_ktime(cfg,
cmd_ext->rx_can.timestamp);
         } else {
                 return kvaser_usb_timestamp48_to_ktime(cfg,
cmd->rx_can.timestamp);
         }
  }


>  static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
> --
> 2.45.2
>
>

