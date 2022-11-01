Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3714C61527A
	for <lists+linux-can@lfdr.de>; Tue,  1 Nov 2022 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKATnE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Nov 2022 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKATnE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Nov 2022 15:43:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261E186D6
        for <linux-can@vger.kernel.org>; Tue,  1 Nov 2022 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667331780;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/dktYNbGqtriANHdnsoZjMD1RBzpVAqP3UvJjnzeupQ=;
    b=YY4ZOGv3Ws4IOOuw9lj6eAnbiFbscVCdOe9HAtSoEoYPAWN1OaOTdhVke1ak7eRfpj
    lvm8jFkDjEpKnxClDHlz9JCEbyRUklWbNyuIghGpF+G5RiNW9l4Qr7L0lHZdZb8TAUZq
    kIiQKgIwIv2Wxfd7fB8FVjVI9BrHisXa7WpCWBjCQeUd8bbIwlDXU5DSluJUtqS0GoMx
    Rwag5kGTW94ZPQx9ScK4b0gHb0Lfoc7qZNHTPMxtcMUpD+6B+3ABiWYLuxx5X27TE60C
    R+kwpYYwde/RyumqNI/9kFItWyKwLk14f8D6v7FE2ZR6kIBO6er1jcV/Ac3t+YOnI/V9
    H7jA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yA1Jh0HKl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Nov 2022 20:43:00 +0100 (CET)
Message-ID: <7fa7a113-2047-0ef5-a2d7-262e2518556a@hartkopp.net>
Date:   Tue, 1 Nov 2022 20:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Undefined behavior in Linux Virtual CAN Tunnel
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <VE1PR04MB72623D6E81DB815700E0C475E8369@VE1PR04MB7262.eurprd04.prod.outlook.com>
Content-Language: en-US
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Max Staudt <max@enpas.org>,
        linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <VE1PR04MB72623D6E81DB815700E0C475E8369@VE1PR04MB7262.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

Dariusz thankfully reported an issue with this patch
"can: skb: drop tx skb if in listen only mode"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6d190f8c7670

as it accesses priv->ctrlmode even on virtual CAN interfaces like vcan 
and vxcan which are not created with alloc_candev() and 
register_candev() and therefore do not have the can_priv data structures.
It is just an OOB read and does not crash anything but it may 
potentially lead to frame losses (especially on vxcan's).

I wonder if this check for (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) 
should be moved to another separate helper function 
can_dropped_invalid_tx_skb()? which can then be called by every 'real' 
CAN driver.

This function could perform can_dropped_invalid_skb() *and* the check 
for CAN_CTRLMODE_LISTENONLY then.

The check for CAN_CTRLMODE_LISTENONLY has not really something to do 
with a correct skb and for that reason can_dropped_invalid_skb() is 
probably not the  best place for it.

Best regards,
Oliver

On 01.11.22 12:04, Dariusz Stojaczyk wrote:
> Hi Oliver, I noticed a bug in vxcan.c but I'm not a kernel developer and I'm not sure where to report it - please point me to any mailing list if required.
> 
> In vxcan_xmit() you can see
>      struct vxcan_priv *priv = netdev_priv(dev);
> followed by:
>      can_dropped_invalid_skb(dev, oskb)
> 
> and can_dropped_invalid_skb() internally also uses netdev_priv, but casts it to a completely different structure:
>      struct can_priv *priv = netdev_priv(dev);
> This gets accessed later on and does an OOB read (probably something from can_ml data)
> 
> I guess most of these can_* APIs shouldn't be used with net devices other than those registered with register_candev(). Perhaps can_dropped_invalid_skb() should be copied to vxcan.c (and vcan.c too!) and modified not to use struct can_priv.
> 
> Regards,
> Darek
