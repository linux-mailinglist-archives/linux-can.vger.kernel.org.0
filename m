Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4240C495707
	for <lists+linux-can@lfdr.de>; Fri, 21 Jan 2022 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbiATXfz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jan 2022 18:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348117AbiATXfy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jan 2022 18:35:54 -0500
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCCC061574;
        Thu, 20 Jan 2022 15:35:53 -0800 (PST)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 993447b7;
        Thu, 20 Jan 2022 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; s=default; bh=jrHEeKBu4luCXoGQ2nSVXI
        84rwI=; b=FJptuwXtRten4amypX1XFYwxdgfqthzdOY2v10t6QThkcouHUv6/UW
        C0E4WgvPbMk2FSjycbwMUp4um3g7wucatjN7K5Ju9+A47hPOiafDzLtgdAdKK1tn
        +9IwWzyxx3OazSsRmS3L1H/8+U20WIxrelR+hMPViUqoCCYDKtpW4=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; q=dns; s=default; b=sGs9c8FJXdKjXh85
        NOvuJfGa5nUvkLD89Q/uwVLcsFFSt5GUc9hPmTjZloNfusPa+YZPJ3vaVJrFsCDl
        v8OgKWlxoBwiKsBjpbd25qI3axT5YkfT0FvvcJBgzxwxvAx3kAAyfHpZI3X+JBYw
        KNoCFavnlQPTlCbq8jTaAEvHbz0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1642721750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIcAySSBxcKIsYGdWnpwGBQ8cXvcrTisXWajSTPD6sg=;
        b=I4+PS8QkND7brfk5Co7uH5XIBBKP6RvVrRTN+XgdZpSMS1/vlFqiuw1EyrkTxIu4dYLgt5
        V0AkMqmlmYXZdtfFPEALd/X9bA1bPiXl+lECJvWeDZO71bzQQCPDdZuYnfqvW+wN+roaK+
        Oc/gYJxouVkXTN3NiS16WJA4VTm9l7w=
Received: from dfj (host-79-40-232-124.business.telecomitalia.it [79.40.232.124])
        by ziongate (OpenSMTPD) with ESMTPSA id d245c478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Jan 2022 23:35:50 +0000 (UTC)
Date:   Fri, 21 Jan 2022 00:35:43 +0100 (CET)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
In-Reply-To: <20220119063837.idsiq72xrv4fvtih@pengutronix.de>
Message-ID: <9ea16c48-b4bc-0c1-13c8-85e985ab86b1@kernel-space.org>
References: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de> <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org> <20220119063837.idsiq72xrv4fvtih@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed, 19 Jan 2022, Marc Kleine-Budde wrote:

> On 19.01.2022 07:25:21, Angelo Dureghello wrote:
>>> we're currently discussing the option that the user of a flexcan can
>>> switch between RX-FIFO and RX via mailboxes.
>>>
>>> I noticed that the mcf5441x currently is configured for FIFO mode. Have
>>> you tested the driver in mailbox mode?
>>>
>>> The reason that some cores use the FIFO mode is, that they cannot
>>> receive RTR CAN frames in mailbox mode. According to the IP core
>>> overview table, the mcf5441x can receive RTR frames.
>>>
>>> If the IP core supports reception of RTR frames, mailbox mode should be
>>> used, as it makes use of more buffers (16-2) instead of 6 in FIFO mode.
>>> Should we activate mailbox mode for the mcf5441x?
>>
>> Ok, not sure why i selected FIFO mode initially, my application
>> actually is quite simple. Will try the switch to mailbox, sure,
>> looking into this.
>
> Thanks for coming back to me. The mailbox mode performs better under
> heavy load, as you have more buffers available.
>
> If you're using a recent kernel, the flexcan driver has been moved to:
> | drivers/net/can/flexcan/flexcan-core.c
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 0bff1884d5cc..aa0b7efb5ca6 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -296,7 +296,8 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
> static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>        .quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>                FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
> -               FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
> +               FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
> +               FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
> };
>
> On older kernel with drivers/net/can/flexcan.c you need:
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 7734229aa078..538b26619460 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -382,7 +382,8 @@ struct flexcan_priv {
>
> static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>        .quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> -               FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
> +               FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
> +               FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
> };
>
> static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
>
> Please apply appropriate change and check if the driver still works if
> you RX with full CAN bus load. Please also test if you can still receive
> RTR frames.
>

I tested this patch:

-------------------- drivers/net/can/flexcan/flexcan-core.c 
index 0bff1884d5cc..daeeb6250347 100644
@@ -296,7 +296,10 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 
18 + 0xfb8);
  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
  	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+		FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
  };

  static const struct flexcan_devtype_data fsl_p1010_devtype_data = {

Bus load PC -> mcf5441x tested by

ip link set can0 type can bitrate 1000000
ip link set can0 up
cangen can0 -g 0

On target (mcf54415)
candump can0

It works, even better then FIFO mode.

While unfortunately, RTR rx does not work. Tested it by putting
a trace in flexcan_mailbox_read()

 	if (reg_ctrl & FLEXCAN_MB_CNT_RTR) {
 		printk("%s() RX RTR frame\n", __func__);
 		cfd->can_id |= CAN_RTR_FLAG;
 	}

on host pc i used:

cangen can0 -R

No sign of RTR in rx. While in FIFO mode i can see it.


> regards,
> Marc
>

Regards,
angelo

> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
