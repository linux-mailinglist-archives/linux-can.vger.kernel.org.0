Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64362585C34
	for <lists+linux-can@lfdr.de>; Sat, 30 Jul 2022 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiG3VFW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 30 Jul 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiG3VFU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 30 Jul 2022 17:05:20 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B2AE77
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659215114;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=r0GBsIwTaKHpakulemEKFm/i8wEx1cJ8+hLXBxMgPIo=;
    b=oh16cuBGzUd3yLKB00uouvf24irckTF6lHTomu9iHXR4erX1u6YADxmnMKLyx5YSMm
    CQ5VsdsU+6/ym53ktBBciG4POau5LhOlQB77wNKKIPtWW8/hgBVwkek8bHvKLbc6u1S6
    XYdWw4Mk7zkPZsVfo1E6K/wpJHGskPYtAR2DNnu1lSMWGSnZ+jnIQGiX2HFk9hRu+g4r
    kuxBlMa/XK5Ugxyos7/z4d0WsY6s+ar/cJt8EAiR2P0RxBtWC+TGGOnCrcQTFbe3H/nF
    dhHVfCps0G6g3ETKLNtZFm5KJi6zddtdC0bE3IddeRGwf9+8scEjYLGY165BJAWmodT6
    OYBQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y6UL5EDw9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Jul 2022 23:05:14 +0200 (CEST)
Message-ID: <e05843e0-8e68-e91b-78ad-60d44f421ae2@hartkopp.net>
Date:   Sat, 30 Jul 2022 23:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 4/7] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220729154107.1875-1-socketcan@hartkopp.net>
 <20220729154107.1875-5-socketcan@hartkopp.net>
 <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com>
 <c2bf9e37-3c52-559a-a76c-b1cf99b0d698@hartkopp.net>
 <CAMZ6RqL5_WxgT4iJy5tKW1PUBGSCr9R+YbMqVxrTiGSRV+7bCg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqL5_WxgT4iJy5tKW1PUBGSCr9R+YbMqVxrTiGSRV+7bCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 30.07.22 15:16, Vincent Mailhol wrote:
> On Sat. 30 juil. 2022 at 21:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>>> Existing applications are exempted from this risk: the
>>> CAN_RAW_XL_FRAMES socket option will prevent the collision from
>>> happening. To summarise, the collision will only occur if below
>>> criteria are met:
>>>
>>>     * The user allocates a can_frame without zeroing it (typical use
>>> cases are stack declaration or malloc()).
>>>     * The user activates the CAN_RAW_XL_FRAMES socket option.
>>>     * Garbage value results in can_frame::__pad & CANXL_XLF being set.
>>>
>>> So if going in that direction, we would have to update the
>>> documentation (header files and kernel doc) to point at this pitfall
>>> and specify that can_frame::__pad shall always be zeroed for mix
>>> usages.
>>
>> But you would add this recommendation to a *very late point* - namely
>> after 14 years of SocketCAN in the mainline kernel.
>>
>> If you think about the rule "never break user space" I wonder if the
>> risk turns out to be higher when people enable CAN_RAW_XL_FRAMES ("as
>> seen on Stackoverflow") and not read the kernel doc recommendations to
>> review/update their existing code.
> 
> In which aspect does this break the user space? It doesn't.

It does in the way that you need to zero-initialize structures now.

> Enabling CAN_RAW_XL_FRAMES marks a clear transition between the 14
> years old Classical CAN API and the new use case of mixed CAN(-FD) and
> CAN XL frames.

You are seriously telling me that CAN_RAW_XL_FRAMES is a clear 
transition and people will automatically review and rework their former 
CAN/CANFD code to zero-initialize padding bytes?

There is a much higher risk that this does not happen than telling 
people to check for CANXL_XLF first after reading from the socket!

> For the issue to occur, developers have to incorrectly modify their
> application, I do not call this a break in user space if only the
> yet-to-be-created programs are impacted.

I don't know about your thresholds but I call this a break in user 
space. Yet-to-be-created programs will likely copy old code.

> The argument that people do not read the kernel doc apply to both
> cases: some people will not initialise variables, some people will not
> do the "if" checks in the right order.

To make it simple: The difference between CAN XL and (old) CAN/CANFD 
handling is CANXL_XLF.

I'm really tired about your constructed case that people would be too 
dumb to check for CANXL_XLF first.

This CANFD_FDF check is a new optional(!) possibility, which we do not 
need to promote. This could become a power user trick for people that 
are obviously "smart enough" to put if-statements in the right order.

The correct and safe check that should be documented and suggested looks 
like this:

if (can.xl.flags & CANXL_XLF)
      /* Handle CAN XL frame */
else if (nbytes == CANFD_MTU)
      /* Handle CAN FD frame */
else if (nbytes == CAN_MTU) /* paranoid */
      /* Handle Classic CAN frame */
else
      /* error */

Regards,
Oliver
