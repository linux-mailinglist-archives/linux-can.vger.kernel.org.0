Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA352CBD9
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 08:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiESGSm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 02:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiESGSm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 02:18:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F6BD8
        for <linux-can@vger.kernel.org>; Wed, 18 May 2022 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652941116;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=p/qZmB+QfDjd4wT2Da2noadIX1zNsVJwZnekUvErlRI=;
    b=I2rKOfd6YO+SHfXoEHCTMdCoqKbmC6P3XP7GHdbk2I3r0lOfbDWgEQEeELxzuYPePb
    PSh5sbMnT3dFwsKq9scz2LYCDa2YLqlb7p0KaowkFOyT0DQZw9VEiyRPYEdcE8jmSk0A
    wEL7Am8JFxugnjl+MWVxDY31/v6Q04RW31BAw6Tdtpy3iQ8UrAI/AvkmxGejfUQMxaXo
    Dv+VYl6Ld6qMMb+p+8xq7Se8Vlv1B3jBYxgXEdj7oxMqTHSN8qif5Goz9Nw57DAllAhl
    MckxgIn9Qo2U2a3RvLNP4lGD+VWX71fS2WfySjBTZ3EeRFEtaHz2SIFxOmQwwRZRIjx0
    KqQQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOuh2krLEWFUg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b00::b82]
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4J6IaJ8v
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 May 2022 08:18:36 +0200 (CEST)
Message-ID: <4113f480-ab6a-3c1e-ff20-8778468e15c5@hartkopp.net>
Date:   Thu, 19 May 2022 08:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20220518154527.29046-1-socketcan@hartkopp.net>
 <20220518202134.77ir3bohv2tl6vi6@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220518202134.77ir3bohv2tl6vi6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

found a typo while reading your answer ...

On 18.05.22 22:21, Marc Kleine-Budde wrote:
> On 18.05.2022 17:45:27, Oliver Hartkopp wrote:
>> Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
>> CAN specific LED support was disabled and marked as BROKEN. As the common
>> LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now the
                                                       ^^

to -> do

m(


Btw. did you see this patch for can-next?

https://lore.kernel.org/linux-can/20220517145653.2556-1-socketcan@hartkopp.net/T/#u

That was very short after the patch from Jakub so you probably missed it.

Thanks & BR,
Oliver

>> code can be removed as preparation for a CAN netdevice Kconfig rework.
>>
>> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/Kconfig                  |  17 ---
>>   drivers/net/can/at91_can.c               |  10 --
>>   drivers/net/can/c_can/c_can_main.c       |  12 +-
>>   drivers/net/can/ctucanfd/ctucanfd_base.c |  10 --
>>   drivers/net/can/dev/Makefile             |   2 -
>>   drivers/net/can/dev/dev.c                |   5 -
>>   drivers/net/can/dev/rx-offload.c         |   2 -
>>   drivers/net/can/flexcan/flexcan-core.c   |   7 --
>>   drivers/net/can/ifi_canfd/ifi_canfd.c    |   9 --
>>   drivers/net/can/led.c                    | 140 -----------------------
>>   drivers/net/can/m_can/m_can.c            |  11 --
>>   drivers/net/can/m_can/m_can.h            |   1 -
>>   drivers/net/can/rcar/rcar_can.c          |   8 --
>>   drivers/net/can/rcar/rcar_canfd.c        |   7 --
>>   drivers/net/can/sja1000/sja1000.c        |  11 --
>>   drivers/net/can/spi/hi311x.c             |   8 --
>>   drivers/net/can/spi/mcp251x.c            |  10 --
>>   drivers/net/can/sun4i_can.c              |   7 --
>>   drivers/net/can/ti_hecc.c                |   8 --
>>   drivers/net/can/usb/mcba_usb.c           |   8 --
>>   drivers/net/can/usb/usb_8dev.c           |  11 --
>>   drivers/net/can/xilinx_can.c             |  10 +-
>>   include/linux/can/dev.h                  |  10 --
>>   include/linux/can/led.h                  |  51 ---------
>>   24 files changed, 2 insertions(+), 373 deletions(-)
>>   delete mode 100644 drivers/net/can/led.c
>>   delete mode 100644 include/linux/can/led.h
> 
> Applied to linux-can-next/testing.
> 
> regards,
> Marc
> 
