Return-Path: <linux-can+bounces-2112-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB199D24C7
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 12:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CA628165C
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB711C4A0A;
	Tue, 19 Nov 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dD5In/S0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A0198A37;
	Tue, 19 Nov 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015600; cv=none; b=Tkcw9N2q5AnbXHm3thpNOaLjFUFGca6ywVPOIWVjzFQZoWlL26H+nqlOkiF/ageX/PH5KUX6Slz17Uu4aIuAOiRZ4SxYrPMStiqQunfPJ9W1ZD0NvU1KPqmpf5EBVnGAt7YfgA2MzYJcJV8VphVj1kDMqBH2SEm1V6j534TSxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015600; c=relaxed/simple;
	bh=jikjswAKs7ol2d86wYoGsx6UY//r1CS50Ko2Q/uD/Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTj0YeWDFr+26Su8EJFlLEAPGtd1YmyitqijGRAxKqW6gpRfKv6F0I8It1fNZPk+XSoTWQTCXROMG2HztKeaxCh+kqVUTKyzsLkePRSnM6ahQL/LLOHkjHvfEGHL/Yhg/txCRSY1oqgzkCug2sBLYCpf/aHjemsoU0FbyH6okoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dD5In/S0; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id DMNHtEHNmNywhDMNIthG2G; Tue, 19 Nov 2024 12:26:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732015595;
	bh=d9GXcffo0UAX9pD8MRFRvCySp0v93Es0xkObTh1140o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dD5In/S04frbfPzHzkSlfngFTsOTi/1BdloRL546rlbqNKsazcYCgHaFYx2xGnCWK
	 DkRKSXvHVziTyYsylfNvmgM7XUBAn7TiJ9XUNGojfc96r7k/jQOueoXvGUUnOD290K
	 P37KMcSaylJNiEgzRZIsDtxkD18NkhW62HlNEoJeJbXVpfde5GhyhV4ONTlrWX1a+O
	 aY2Cj1KwuxtgfMyzd+KT5YreEiVwLtKZnwJnFTcCYgtverp+jT0hUn+ApIWLA+t/Zx
	 bxOZBYw4aGn8VIEvQEpCD04GtgTWpOLPcev/awAWKQxe1ynVQ4ryGZNxu8nRNrw0Zj
	 +scF5J1bswNBw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 12:26:35 +0100
X-ME-IP: 124.33.176.97
Message-ID: <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
Date: Tue, 19 Nov 2024 20:26:26 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
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
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <bfa5200d-6e56-417d-ac3b-52390398dba2@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/11/2024 at 19:01, Ciprian Marian Costea wrote:
> On 11/19/2024 11:26 AM, Vincent Mailhol wrote:
>> On 19/11/2024 at 17:10, Ciprian Costea wrote:

(...)

>>>   +    if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>>> +        err = request_irq(priv->irq_secondary_mb,
>>> +                  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>> +        if (err)
>>> +            goto out_free_irq_err;
>>> +    }
>>
>> Is the logic here correct?
>>
>>    request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>
>> is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.
>>
>> So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
>> FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
>> not initialized.
>>
>> Did you confirm if it is safe to call free_irq() on an uninitialized irq?
>>
>> (and I can see that currently there is no such device with
>> FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
>> who knows if such device will be introduced in the future?)
>>
> 
> Hello Vincent,
> 
> Thanks for your review. Indeed this seems to be an incorrect logic since
> I do not want to create any dependency between 'FLEXCAN_QUIRK_NR_IRQ_3'
> and 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ'.
> 
> I will change the impacted section to:
>     if (err) {
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>             goto out_free_irq_err;
>         else
>             goto out_free_irq;
>     }

This is better. Alternatively, you could move the check into the label:

  out_free_irq_err:
  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
  		free_irq(priv->irq_err, dev);

But this is not a strong preference, I let you pick the one which you
prefer.

>>>       flexcan_chip_interrupts_enable(dev);
>>>         netif_start_queue(dev);
>>>         return 0;
>>>   + out_free_irq_err:
>>> +    free_irq(priv->irq_err, dev);
>>>    out_free_irq_boff:
>>>       free_irq(priv->irq_boff, dev);
>>>    out_free_irq:

(...)


Yours sincerely,
Vincent Mailhol


