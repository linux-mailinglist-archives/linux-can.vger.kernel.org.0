Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F508495D8A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jan 2022 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379961AbiAUKQY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Jan 2022 05:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379955AbiAUKQX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Jan 2022 05:16:23 -0500
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA265C061401;
        Fri, 21 Jan 2022 02:16:22 -0800 (PST)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 9d8f87a6;
        Fri, 21 Jan 2022 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; s=default; bh=AhpObT7A0b/qpwu9eTMTst
        FSMo0=; b=hJllvZNUKw+FmV+d8hqNnYjd9f7Gt2lhjsnpjCocJ3LDh4gE+nnerR
        cVIgId0i3GBb00hqJU3+Kbt93GwvWO9LgF8cuXkKQbkz3WukRyF2926iJgWg9m6V
        zNNKXejrkmE+4MMLkrn05VjBiZxCI8haYq8NFFK5b6QzmQ/23laig=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; q=dns; s=default; b=pboqxCei+Hc2jRm7
        58yDcaUZYG2qoKEwKkWIwMZmOWhgSVIiL9VGv5sWgc+2RWdy+HuFo5LaSREAUR2V
        u3N/dIW3DUYw6Ztmjjsw4huj3kEOyY2b+jWcDZyRuKjyki2TwVUOTQZlULn/F9tc
        WkYPZoFLm5Jsdcf+phJcJ8n05P0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1642760180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=977NVgy6ZgfTNsnlkwz7B+7C1uPBelrZdQpdDU/M87o=;
        b=XhJgH/zKOWCNSxW8/EQkMLJ4WPsBHybWvH/q2l2eyt36X8/SvMr2gm8l0es/oQZICrZqsC
        EMWRZzzI87umA2ChUcVINgC3X2rjF4vr8NdHUyCobpsWclbxAMhnV+jh7Uv0D2xXZC5oIb
        rpQzyvJgV5Ss4Nh3D0OK8IrQ2M02A9w=
Received: from dfj (host-79-40-232-124.business.telecomitalia.it [79.40.232.124])
        by ziongate (OpenSMTPD) with ESMTPSA id f1307ad8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 21 Jan 2022 10:16:20 +0000 (UTC)
Date:   Fri, 21 Jan 2022 11:16:16 +0100 (CET)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
In-Reply-To: <20220121084931.llxryhizdaeb4ph4@pengutronix.de>
Message-ID: <d67c4bbf-1c39-323-2a4-3167d6febe64@kernel-space.org>
References: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de> <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org> <20220119063837.idsiq72xrv4fvtih@pengutronix.de> <9ea16c48-b4bc-0c1-13c8-85e985ab86b1@kernel-space.org>
 <20220121084931.llxryhizdaeb4ph4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Fri, 21 Jan 2022, Marc Kleine-Budde wrote:

> On 21.01.2022 00:35:43, Angelo Dureghello wrote:
>>> Please apply appropriate change and check if the driver still works if
>>> you RX with full CAN bus load. Please also test if you can still receive
>>> RTR frames.
>>>
>>
>> I tested this patch:
>>
>> -------------------- drivers/net/can/flexcan/flexcan-core.c index
>> 0bff1884d5cc..daeeb6250347 100644
>> @@ -296,7 +296,10 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18
>> + 0xfb8);
>>  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>>  	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>>  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
>> -		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
>> +		FLEXCAN_QUIRK_USE_RX_MAILBOX |
>> +		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO |
>> +		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
>> +		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
>>  };
>>
>>  static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
>>
>> Bus load PC -> mcf5441x tested by
>>
>> ip link set can0 type can bitrate 1000000
>> ip link set can0 up
>> cangen can0 -g 0
>>
>> On target (mcf54415)
>> candump can0
>>
>> It works, even better then FIFO mode.
>
> What's the difference, does it produce less overruns?
>

In FIFO mode, i had a conditions where the mcf system
was stuck. Had to reboot. Not clear what's happen btw, should try to 
reproduce this.

>> While unfortunately, RTR rx does not work. Tested it by putting
>> a trace in flexcan_mailbox_read()
>>
>> 	if (reg_ctrl & FLEXCAN_MB_CNT_RTR) {
>> 		printk("%s() RX RTR frame\n", __func__);
>> 		cfd->can_id |= CAN_RTR_FLAG;
>> 	}
>>
>> on host pc i used:
>>
>> cangen can0 -R
>>
>> No sign of RTR in rx. While in FIFO mode i can see it.
>
> Ok, then I enable the mailbox support for the mcf5441x and fix the note
> that the IP core doesn't support RTR reception via mailboxes. See the
> following patch:
>
> | https://lore.kernel.org/all/20220121084425.3141218-1-mkl@pengutronix.de
>
> If you have time, please test and add your Tested-by.
>
> You can switch to mailbox mode during runtime, if the interface is down:
>
> | ethtool --set-priv-flags can0 rx-rtr off
>
> With ethtool you can query the number of used RX and TX buffers:
>
> | ethtool --show-ring can0
>
> The FIFO mode uses 6 RX buffers, while mailbox mode will probably use
> 14.
>

My mcf5441x small system does not have ethtool available
right now. Will test this as soon as i can.

> regards,
> Marc

regards,
angelo
>
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
