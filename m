Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6553E8773E
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfHIK1x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 06:27:53 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:20238 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHIK1x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 06:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565346467;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Z42BRwf7wQuXhtKpVEm0LNW0TNRHGYr6QOMyy0Xm1qc=;
        b=jG1bkOMDrNLayFBAOYEVL4HtgqbTLXsw5pUF6QKNW9+3Pj/cB9qrWIRG5aJC9gvbZR
        uZTzb5Fv5Ybl+fs7yD2VGQx5l35zfAgCG/ZrIAClPhImCmuM44ZRSNZ2BHjo/xAUmWla
        0pn/lmdaDRV05K0aLeSGja6StMk/I4RKNI3S/MJwT2HqyQ5rZsr3759ghBfOWts5b9G+
        Ywxc8Shommwu0zyOxOT39F+deYZ64+MOITDUxKec8QKAXllMUujouzyjN2mYHBZiSjSb
        fbJZsNXpysVA4pURZpPSWKFt0ByZieYqQC/Z/a9TIyOnf1G00zRdPlZbdZ+oIBxdBdln
        gFZA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUch5l03U"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv79ARkSZe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 9 Aug 2019 12:27:46 +0200 (CEST)
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
 <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
 <727ad8d4-acc3-d72d-613e-fb3429f670f6@hartkopp.net>
 <6acd5e5b-764a-f3f9-8e2c-6dacd3923e7e@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>
Date:   Fri, 9 Aug 2019 12:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6acd5e5b-764a-f3f9-8e2c-6dacd3923e7e@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 30/07/2019 09.33, Marc Kleine-Budde wrote:
> On 7/26/19 3:18 PM, Oliver Hartkopp wrote:

>> In fact the only point where can_len2dlc() is active is when the CAN
>> frame is sent with a real CAN (FD) controller.
>>
>> Maybe it would make sense to create a special flag for the can-gw
>> modifications like CGW_FLAGS_CAN_FD_SANITIZE_LEN.
> 
> My point is, it makes no sense to do any CAN-FD related len sanitisation
> in the can-gw, as the user will not see any strange length.
> 
>> So we could point out that the CAN FD length information is manipulated
>> and that we offer to round the values or not.
> 
> What I suggest instead is to do len sanitisation in the vcan driver, so
> that the problem I illustrated above will be fixed.
> 
> Another path we have to think about is the loop back of CAN-FD frames, I
> think they are not sanitised as well.

The problem in loopback and vcan is similar.

But the issues that rises up when sanitizing the FD length value in 
loopback/vcan/af_can -> we start to fiddle inside the skb data.

When we do so, we need to skb_copy() the skb instead of working on 
clones to prevent race conditions inside the data, see:

https://elixir.bootlin.com/linux/v5.2.6/source/net/can/gw.c#L387

skb_copy would have a performance impact and it would trigger a big 
rewriting of the current code. Don't know if it's worth that.

I tend to sanitize the CAN FD length values when they are introduced 
into the system (CAN_RAW, CAN_BCM, CAN FD drivers*) and when they are 
modified (CAN_GW).

* = already done

My idea was to fix things up when someone manipulates the CAN or CAN FD 
length field with can-gw.

Or do you think I should just omit it and let the data flow as-is?

Best,
Oliver
