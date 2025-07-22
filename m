Return-Path: <linux-can+bounces-4033-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A21B0E764
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 01:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91EE3A892E
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067328A714;
	Tue, 22 Jul 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U4wl79tR"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE970289E32;
	Tue, 22 Jul 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228632; cv=none; b=YUIOo/Ppq0C3siAwwc/SKm+4kpaMB58roRQVdStiJlOCDDwDLQkVuJh5x1LdW9maX/hqBKHJ5M7J8j22/jRKXExyiGyepr224GjaRvz3qM2EKVgBnkT/vDOWRwLUptMekVmOf6yHpujQGwSqbIZfRL3EW7EjFz0+l5CdXsflXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228632; c=relaxed/simple;
	bh=pktmUuwdhUsTi4dawxHmKwqOBRmLySGnvk1UL1YTlnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEmH9OO8Kv/HzV5E6yc9PzVlSo9wFA566cv3GhNcVePK/ZHzAt+9ujZNGL2xn4BnuTtZ3wx5e/tH+b/Ylh4Or0bgSJ3t4fZBWswd/UVMmmPMYP/Kd4egwxnXb0avYS13sHU42Q6RM3XeSKKxG19foFWjsDdb3CUt91lynBXJcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U4wl79tR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LzTw3TQy4x8voOBDTwRwDXWNoCL87C9cZ53++EGX5IU=; b=U4wl79tRK/N0V6pW+qleOdhIu2
	hY3vYKifGwTaXTm2jXYhYxPNyrtx0BYLyPmFIuaB940kfDG9H1RcpVaw4jBfd6U4PB0CsFZAtJaHo
	8zwq8zx+qbOL+CGbCvPJ8Lmzmbsp3o42n9bqQ81XPGHOpIG5MNl73UgEakLK7y9pBHhaXmYyRcqZ3
	V5Ygy71KLeLv1//YYAFMh0ZL2lR4q141PLMJd9owpCHfrl6jgrM4Zgzggb7FMPhStoC4b9K3KqJHu
	tcH0X7o+gapKWcSZWPCyrjRpO6+PzZC/CgV55abKOF1vA6kieaxS2Wy46NGwvWl6Tysn+6lL1FJLw
	Z7gFZdZg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueMr7-00000003hW3-3OBq;
	Tue, 22 Jul 2025 23:57:09 +0000
Message-ID: <d44b9541-b912-4d3e-8c41-ea2f460ddd17@infradead.org>
Date: Tue, 22 Jul 2025 16:57:09 -0700
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, "Andre B. Oliveira" <anbadeol@gmail.com>,
 linux-can@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250721002823.3548945-1-rdunlap@infradead.org>
 <20250722-delectable-porcelain-partridge-a87134-mkl@pengutronix.de>
 <20250722-godlike-discerning-weasel-fbec72-mkl@pengutronix.de>
 <266ff6cc-82f6-4e5f-84c5-39a1ff0aa8a2@wanadoo.fr>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <266ff6cc-82f6-4e5f-84c5-39a1ff0aa8a2@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/25 5:12 AM, Vincent Mailhol wrote:
> On 22/07/2025 at 19:52, Marc Kleine-Budde a écrit :
>> On 22.07.2025 12:48:41, Marc Kleine-Budde wrote:
>>> On 20.07.2025 17:28:23, Randy Dunlap wrote:
>>>> Add a dependency on PC104 to limit (restrict) this driver kconfig
>>>> prompt to kernel configs that have PC104 set.
>>>>
>>>> Add COMPILE_TEST as a possibility for more complete build coverage.
>>>> I tested this build config on x86_64 5 times without problems.
>>>
>>> I've already Vincent's patch [1] on my tree.
>>>
>>> [1] https://lore.kernel.org/all/20250715-can-compile-test-v2-3-f7fd566db86f@wanadoo.fr/
> 
> Don't know how I did not realize the conflict when reviewing :D
> 
>>> So this doesn't apply any more. Fixing the merge conflicts result in:
>>>
>>> index ba16d7bc09ef..e061e35769bf 100644
>>> --- a/drivers/net/can/sja1000/Kconfig
>>> +++ b/drivers/net/can/sja1000/Kconfig
>>> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>>>  
>>>  config CAN_TSCAN1
>>>          tristate "TS-CAN1 PC104 boards"
>>> -        depends on ISA || (COMPILE_TEST && HAS_IOPORT)
>>> +        depends on (ISA && PC104) || (COMPILE_TEST && HAS_IOPORT)
>>>          help
>>>            This driver is for Technologic Systems' TSCAN-1 PC104 boards.
>>>            https://www.embeddedts.com/products/TS-CAN1
>>>
>>> Should be ok?

Looks good. Thanks.

>> If no-one complains I'll add this to my can-next tree and remove the
>> Fixes tag. Otherwise stable will pick this up, but it won't apply
>> without Vincent's patch.
> 
> I do not really mind if those are not backported. No issue for me to drop the
> fix tag.

Agreed. Not needed.

-- 
~Randy


