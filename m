Return-Path: <linux-can+bounces-4031-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B222B0D91C
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91B5188AD0A
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1D2E8E05;
	Tue, 22 Jul 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pUs++OLI"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D52E8E0C;
	Tue, 22 Jul 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186404; cv=none; b=qIteektGCgoN5kQenqBZANzHrYJtDQ+f1VB8PCTWipDacTUgzwZNr2dSJIUmLISUM3DlJEOARQsly1AhevFEsbOUOeOtWdRMll8B/YiSG18GgFXDscYxzyfA2u/JJhyV9EzUs30diHNoTwWwPjdGzO1TrcEO4OorXEpDfK7/+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186404; c=relaxed/simple;
	bh=u9CymTeGhHwmHEThjnJA9ifjHjtLz4Cw4C1+RHVvYaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9t7qFdT2iHnCcFz+SsvYd55Ch8aqoFBZseLVa7oGTiKQ/oMOwC08PuX3bnRHM/n+BqbAWxK6DeI46G/rthgfZH6QNprQfD2qZuWmh/yMBPhypxQ0v0/ELsfWZaJ9hrsKREcHclj6l2L4/0BIE6QP7jBj0RUsg5vIK1ag8QR/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pUs++OLI; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eBqkutpDDZLLzeBqmuiq1m; Tue, 22 Jul 2025 14:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753186330;
	bh=BInXK0aUIElWXF88CRcdt6heGhuFFOkNCbpfQ3hACD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pUs++OLI0bks4sCHIpdkls7A0Welf5n+B01rBxZOJ1c1ZJT/vzC4R5O0UQ3h87B6x
	 u+nggmHvHFP+ahn/TzBguJHv6JJ9Cm8Ucgu9UxbyXivK4+FDfp0T4rT/N/gqxMIeau
	 uFNORvAVM4tkU2RNQ2XmYbucTkOrPIAs92vLwPFBuRay1+sUhd7z+P/G38ADLJXt3g
	 QBKgNHGd9kh3XOM8QOY5JpfuYlrBaYRZT/pb9y4+amqcrhk8r2WSx0A1SHYYCoBRew
	 K/UYY1YIczMYLAbOBawx8H6lTvUmUJVfDjB11zd+tHb/3Tw4RmDMH4rEcbaFm/jWyD
	 0ABBiu68VEeFw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Jul 2025 14:12:10 +0200
X-ME-IP: 124.33.176.97
Message-ID: <266ff6cc-82f6-4e5f-84c5-39a1ff0aa8a2@wanadoo.fr>
Date: Tue, 22 Jul 2025 21:12:02 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, "Andre B. Oliveira" <anbadeol@gmail.com>,
 linux-can@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250721002823.3548945-1-rdunlap@infradead.org>
 <20250722-delectable-porcelain-partridge-a87134-mkl@pengutronix.de>
 <20250722-godlike-discerning-weasel-fbec72-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250722-godlike-discerning-weasel-fbec72-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/07/2025 at 19:52, Marc Kleine-Budde a écrit :
> On 22.07.2025 12:48:41, Marc Kleine-Budde wrote:
>> On 20.07.2025 17:28:23, Randy Dunlap wrote:
>>> Add a dependency on PC104 to limit (restrict) this driver kconfig
>>> prompt to kernel configs that have PC104 set.
>>>
>>> Add COMPILE_TEST as a possibility for more complete build coverage.
>>> I tested this build config on x86_64 5 times without problems.
>>
>> I've already Vincent's patch [1] on my tree.
>>
>> [1] https://lore.kernel.org/all/20250715-can-compile-test-v2-3-f7fd566db86f@wanadoo.fr/

Don't know how I did not realize the conflict when reviewing :D

>> So this doesn't apply any more. Fixing the merge conflicts result in:
>>
>> index ba16d7bc09ef..e061e35769bf 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>>  
>>  config CAN_TSCAN1
>>          tristate "TS-CAN1 PC104 boards"
>> -        depends on ISA || (COMPILE_TEST && HAS_IOPORT)
>> +        depends on (ISA && PC104) || (COMPILE_TEST && HAS_IOPORT)
>>          help
>>            This driver is for Technologic Systems' TSCAN-1 PC104 boards.
>>            https://www.embeddedts.com/products/TS-CAN1
>>
>> Should be ok?
> 
> If no-one complains I'll add this to my can-next tree and remove the
> Fixes tag. Otherwise stable will pick this up, but it won't apply
> without Vincent's patch.

I do not really mind if those are not backported. No issue for me to drop the
fix tag.

Yours sincerely,
Vincent Mailhol


