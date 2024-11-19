Return-Path: <linux-can+bounces-2114-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AA9D24FF
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39CA1F248BB
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0E1CACC9;
	Tue, 19 Nov 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SAFKpcBW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776F1C9EDA;
	Tue, 19 Nov 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016210; cv=none; b=VxIg1nyDNVaHciUd6BPrONGLcjSxQlxNyefqFa9ao5Qf/LJJSOWwdZCUHfcZy0bLDL1gEKcYCS93u/k/QZgUdI+t+Vl2gIXe4jVKhq1Lq5KxO7Fpt5NyuytLWXstteD3lS2kU4GfVWUsGjKETVU4N4ytGW34QsnoCgqDsuQnaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016210; c=relaxed/simple;
	bh=la5KRTljLvSnmKiDKbgW9v6clOEXUDkvBBxcNk2vzp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UuOig0GJzUEN9RdskZNnyQtzDjd+wJivvyjl6ad2aPC8OJyzqxQYfmBkbEWEDDNDrkyoW1po53dbKwptS9H2u+5f0ZHzjeFhY7DZHnKBCK3UaQkUDqPJmLvFxQt1u/Zcg8qEOxJCXrYJN20E5MFBlZDW+c4ZBTyEjA02ImSzcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SAFKpcBW; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id DMX1tne6r8AEMDMX2td4J4; Tue, 19 Nov 2024 12:36:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732016201;
	bh=jM4ya2O6hw0Q4RxtNV/BACAcgAvwqiLYCF7hautst5Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=SAFKpcBWqnVyuGCJ02DHX4b0BDeffDZT5ROgXvi3Zl013gMz6pGw/1GhWEXyq8Q9h
	 836JAesmiNMuvvNNC19yJbMttWg7X3Wrl/9z0CslS0YjnTMNgvswYlqhCaETMpOP19
	 ilx1Iy82CGGy/BFRMSiorbvZPvXbSp5EFLNEeKX5Pki69YukTAbtiorMZcBCGafur5
	 fOGsLw2LGzwRuJYXEmAampibO5wrv1rSPu2RXc+e5WqF2dJ/ITVwwQzWWNO3svGtui
	 swymLr64h9Y1wXtYO1xxnILXJFT/KhakqAsE+9MvSZdvQSxYGC+TvEwSONxJ4ddZ77
	 oi9YYHyXQ2eWQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 12:36:41 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7a91c06f-6ea3-4262-82a3-9a1daf481f82@wanadoo.fr>
Date: Tue, 19 Nov 2024 20:36:30 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
 <bfa5200d-6e56-417d-ac3b-52390398dba2@oss.nxp.com>
 <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
Content-Language: en-US
In-Reply-To: <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/11/2024 at 20:26, Vincent Mailhol wrote:
> On 19/11/2024 at 19:01, Ciprian Marian Costea wrote:
>> On 11/19/2024 11:26 AM, Vincent Mailhol wrote:
>>> On 19/11/2024 at 17:10, Ciprian Costea wrote:
> 
> (...)
> 
>>>>   +    if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>>>> +        err = request_irq(priv->irq_secondary_mb,
>>>> +                  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>>> +        if (err)
>>>> +            goto out_free_irq_err;
>>>> +    }
>>>
>>> Is the logic here correct?
>>>
>>>    request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>>
>>> is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.
>>>
>>> So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
>>> FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
>>> not initialized.
>>>
>>> Did you confirm if it is safe to call free_irq() on an uninitialized irq?
>>>
>>> (and I can see that currently there is no such device with
>>> FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
>>> who knows if such device will be introduced in the future?)
>>>
>>
>> Hello Vincent,
>>
>> Thanks for your review. Indeed this seems to be an incorrect logic since
>> I do not want to create any dependency between 'FLEXCAN_QUIRK_NR_IRQ_3'
>> and 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ'.
>>
>> I will change the impacted section to:
>>     if (err) {
>>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>>             goto out_free_irq_err;
>>         else
>>             goto out_free_irq;
>>     }
> 
> This is better. Alternatively, you could move the check into the label:
> 
>   out_free_irq_err:
>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>   		free_irq(priv->irq_err, dev);
> 
> But this is not a strong preference, I let you pick the one which you
> prefer.

On second thought, it is a strong preference. If you keep the

	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
		goto out_free_irq_err;
	else
		goto out_free_irq;

then what if more code with a clean-up label is added to flexcan_open()?
I am thinking of this:

  out_free_foo:
  	free(foo);
  out_free_irq_err:
  	free_irq(priv-irq_err, dev);
  out_free_irq_boff:
  	free_irq(priv->irq_boff, dev);

Jumping to out_free_foo would now be incorrect because the
out_free_irq_err label would also be visited.

>>>>       flexcan_chip_interrupts_enable(dev);
>>>>         netif_start_queue(dev);
>>>>         return 0;
>>>>   + out_free_irq_err:
>>>> +    free_irq(priv->irq_err, dev);
>>>>    out_free_irq_boff:
>>>>       free_irq(priv->irq_boff, dev);
>>>>    out_free_irq:
> 
> (...)

Yours sincerely,
Vincent Mailhol


