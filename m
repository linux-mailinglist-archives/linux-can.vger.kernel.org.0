Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B567877F45D
	for <lists+linux-can@lfdr.de>; Thu, 17 Aug 2023 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349939AbjHQKiN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Aug 2023 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349230AbjHQKho (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2023 06:37:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04082D54
        for <linux-can@vger.kernel.org>; Thu, 17 Aug 2023 03:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692268660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=op+n2TWT+J4VshZyHkfYBCluImdckD/HJrbih5cU5owUQWUC/+rE2/eLyWmq/BnwPG
    5Ho6fpQ6T46baF8oJid90bvCG3IF3ux8d9stpvv7t2ST47oAPfGgQleB51tqvCYt37B7
    jHn31sd5un5a8u+wG6fldxHHBU6u+Cv8QeRsS/zaLBEF0p55ZyvlSm6+P2ApQS+m+JsU
    OHbpbZFZ7zArBvehS5eF0HwxifkAg11Ya8dhxCe0WX0R59/LiUepqBAlm5nlCXjxtnPT
    Vrz6TF5RgFq/jJnkIOASaS8Bkf1166UojQsuCVxJvUQJz+ZkDF/SuBipzxPW/jQLU2W0
    th5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692268660;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T6wmv62SAjspoMHf0pymLYfxr9Dp7kUk6XfMWmT+SLY=;
    b=TnXU+U/sWkwuzRrPrIQvRDv98PHXTC45JLUb1MaabfH5LzvQSUFgsjtyI9gGVzIFAz
    dMAfmO6NwfPEM/IuIreGPaKrIkH9ZwHo0UyBqqYADQPjx93JEspTcyePZtPSwsxvQKA3
    wQI0ufnP37XMbPMu4QgZT8qh0EJ6kvZxukQbkrTzNFrmf5LuoEjQxk5zm3FJSLEUXa5n
    xH3Hp40uQCakb0dmdrc9H7+jFyZMOsbIIafNTYKxSD3lx8fYC6qh+p/JCjQ6sfaTzvNv
    2MqjcIMniPhjhrXaJCR7S6FBXmGV/GBb6Q2fBdtPNXQIeQFkCdVxl9t0ughVQiBs6xWi
    1L4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692268660;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T6wmv62SAjspoMHf0pymLYfxr9Dp7kUk6XfMWmT+SLY=;
    b=XyApfnqMdUSF/9as1/Y6O7VWeApjMaoykqJ4CjSCea03YAFRXaMIPjGfBXj2pUNah+
    kWagGaetg51z/FPUcA4staxg9UpBblNMridJIZvVOzzp01W5u5hKcS3goKxdbs+kbNC7
    p28a1v4nA3qdplsAh2Io6QsUeC1/T5cPM+VcxiaDROGEsvQtzCEHYCgiLjhPA6xrAaWk
    qO/lOsDSN5dmHXAafAu1QKXYI9EljZTtuQu/4njWfyEWjiFRG5+v0nqM/8Htax5TCExJ
    Iq2EY00sEioTvrtWopH219ZPYHNyhwAOOEDAzs50ArKrmvzSMIUtM+fin1lCoysPXtqc
    POHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692268660;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T6wmv62SAjspoMHf0pymLYfxr9Dp7kUk6XfMWmT+SLY=;
    b=cw46CsO7iAlYwxn+IVwwMDrrYxudR0DDzW764tAitMR9uXkm7C6Fx3kbgoHMWzf7ve
    4X2IuqBXBt1w5j510QDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USMYaUuUukOkrxOplwYxvBXmGP/"
Received: from [IPV6:2a00:6020:4a8e:5000:249a:c3ef:f70:1edd]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id Ka8a06z7HAbd2AR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 17 Aug 2023 12:37:39 +0200 (CEST)
Message-ID: <038d5958-1c6a-7103-c846-68961cad9491@hartkopp.net>
Date:   Thu, 17 Aug 2023 12:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] can: per-device hardware filter support
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>
References: <20230817101014.3484715-1-martin@geanix.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230817101014.3484715-1-martin@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Martin,

I reduced the recipient list as this is a CAN-only feature discussion 
which is not relevant for putting all the netdev maintainers into the 
loop now.

Nice that you picked up the idea for hardware filtering.

On 2023-08-17 12:10, Martin Hundebøll wrote:

> Based on the prior discussions on hardware filtering in CAN devices[0],
> I've implemented such support in the m_can driver.
> 
> The first patch is almost entirely identical to Oliver Hartkopp's patch
> from 2018[1] - I've just rebased it to v6.6 and fixed a checkpatch
> warning. Not sure what to do about the "Not-Signed-off-by" tag though?

The patch was just for the discussion we had in 2018 and I wanted to 
make sure this RFC stuff does not go upstream at that point. So 
preserving myself as author would still be ok ;-)

> The second patch is new. I've tested it with a tcan4550 device together
> with Oliver's proof-of-concept change in iproute2[2].
> 
> Has anyone tried this approach with other devices, e.g. sja1000 ?

Yes, I remember implementing some code for the SJA1000 - but never 
posted it on the CAN-ML. Maybe I still have that code somewhere o_O

But it is nice to see, that you got it working with the M_CAN IP core!

Best regards,
Oliver

> 
> Thanks,
> Martin
> 
> [0] https://lore.kernel.org/linux-can/6B05F8DE-7FF3-4065-9828-530BB9C91D1B@vanille.de/T/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=can-hw-filter&id=87128f7a953ef2eef5f2d2a02ce354350e2c4f7f
> [2] https://marc.info/?l=linux-can&m=151949929522529
> 
> Martin Hundebøll (2):
>    can: netlink: support setting hardware filters
>    can: m_can: support setting hw filters
> 
>   drivers/net/can/dev/dev.c        |   3 +
>   drivers/net/can/dev/netlink.c    |  33 ++++++++
>   drivers/net/can/m_can/m_can.c    | 137 ++++++++++++++++++++++++++++++-
>   include/linux/can/dev.h          |   5 ++
>   include/uapi/linux/can/netlink.h |   1 +
>   5 files changed, 175 insertions(+), 4 deletions(-)
> 
