Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30A2DADA6
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 14:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgLONE0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 08:04:26 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:19777 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgLONER (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 08:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608037218;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=HAQnopOlSzRJS9cJRLkk6O3g9Yy4jnexC5EmECrg708=;
        b=FSIM+NS75ueP1lkfG5UzYDGDih8ZkRy2DfEP0MgisuWVTWUMs+ZYu66/yD3tzye+fJ
        IrDS/SLDeZDdaRIvhkBvuvjfSkRFD8VfeOqZXgY34BK+7rjdDTsgHvJ2YZGUdht1CtDD
        qM9PVkyK3m/Qn/KuTZCz0CpGU/OTrWESTZignEGKkUlXCNOPH386rgFS6jXAX8Nwvnba
        /EeJDi8EdgkNt4jg+L2pA4UZGQS90Ja4AOXFYzgxU6SYqpLQ55iA+bN5t/AAeGOawek7
        5SRlDVUpjkN72/KHcBWXlmKdgxLGFtEF2eCp44LQagDEjxslWx2ypkZw5yVgImP9M4QT
        iN/Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.3 DYNA|AUTH)
        with ESMTPSA id d0af4dwBFD0E4LA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 15 Dec 2020 14:00:14 +0100 (CET)
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
References: <20201214091426.417867-1-mkl@pengutronix.de>
 <fe7ac11a-410b-ee50-8494-da13055b544e@pengutronix.de>
 <CAMZ6RqKPOmZ9jx83g+dt2p+ZrHquuTWHPZM=BuZqyXiEmC8J5w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9a3f1a77-c636-525d-7f69-3d519f6a1ca4@hartkopp.net>
Date:   Tue, 15 Dec 2020 14:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKPOmZ9jx83g+dt2p+ZrHquuTWHPZM=BuZqyXiEmC8J5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.12.20 12:37, Vincent MAILHOL wrote:
> On Tue 15 Dec. 2020 at 17:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

>> We can calculate this information twice, but I thought we might put it into the
>> struct can_skb_priv.
>>
>> https://elixir.bootlin.com/linux/latest/source/include/linux/can/skb.h#L34
>>
>> Thoughts?
> 
> I am not knowledgeable enough on this part to guarantee if there will
> be no side effects but regardless, I like the idea.
> 
> Also, an u8 is enough to hold the value. I wonder if it would be fine
> to change ifindex to, for example, u16, so that we do not lose any
> memory.

We should not make can_skb_priv.ifindex another type than 
net_device.ifindex:

https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L1899

> 
> I would look like that:
> 
> struct can_skb_priv {
>      u16 ifindex;
>      u8 frame_len;
>      u8 res;
>      int skbcnt;
>      struct can_frame cf[];
> };
> 

Regards,
Oliver
