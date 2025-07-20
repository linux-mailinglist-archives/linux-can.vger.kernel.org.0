Return-Path: <linux-can+bounces-4012-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4002B0B7EA
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F6B7ACC13
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFD1BD035;
	Sun, 20 Jul 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPyUq6tJ"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA298199947;
	Sun, 20 Jul 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753039380; cv=none; b=QvbvH5iBzPAPo7BwZV8cYQGoKK+UGHJy3HOH0MyKC3V4ApeOZdFNDlrPPYbJJ9oV7pYDDHuj6JJdr5GETg2VoBYhOrpeqLYiAex4XNHPtB2qAyz3UGtQq77vt+YLsyuqItX81N0RKhzr2iHLRfzRRTQgBRQ+9RTWIPG0TrypVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753039380; c=relaxed/simple;
	bh=xAuJBoSlmPA52rFpoNJ5TOHr9t7WoTvXU6shfdibLcE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EeKNOXVJ2remz0MMEw95q6+bKCJ6EXXX2ek9pz7lp8XyiA3YbnAA6KW0w3j0p/OfLbUZ/I/rHRwQvLcAryEiHXgmrwxVYrAuEJ7lhzYbuhXJC9zfAP9+agLr9woZpMbhut5xhkD4nxQSywacSXt/i+NVZ+BpYQzAXXZLxBkhGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QPyUq6tJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Mnk0zae2GI/FNHFb21s5XRXzKpoUxC5PsZeOPQSD5Q8=; b=QPyUq6tJxdnBxPrbmjm97YtSsb
	+EMHLKujgArfWgdKT1fuql5MPWVxQe+S6rImsKtIN1l27eNT6vLObucMQnmjmdSqEvrqTkIwuaIuA
	brYrO3dS4NaxHNR0e604RAXs3mcdj7K4rRzRh4mbvs04sdyZ92HDzA36n7bGKcST/3ImX0VRzhzae
	12TAbxeSe7p2K5AbUl4W9F7XJDJest/xmEFARj7WLz9UBt3c7g47+6j/HzjI2hOY6VzAzjGiCSqZ0
	6JVjOY2BGKcJwJwpX8uy8u0lXoSVUucX3L5YfrMOkKhAZrpf/68uD3BC+LkUEwT50J/ZyTOKSG/mk
	s/89WCSA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZcf-0000000Femy-0QBg;
	Sun, 20 Jul 2025 19:22:57 +0000
Message-ID: <c89c30af-e144-4bd1-892b-f97c41760016@infradead.org>
Date: Sun, 20 Jul 2025 12:22:56 -0700
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] can: tscan1: CAN_TSCAN1 can depend on PC104
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "Andre B. Oliveira" <anbadeol@gmail.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250720000213.2934416-1-rdunlap@infradead.org>
 <9ce81806-3434-492f-b255-fad592be8904@wanadoo.fr>
Content-Language: en-US
In-Reply-To: <9ce81806-3434-492f-b255-fad592be8904@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/19/25 9:50 PM, Vincent Mailhol wrote:
> On 20/07/2025 at 09:02, Randy Dunlap wrote:
>> Add a dependency on PC104 to limit (restrict) this driver kconfig
>> prompt to kernel configs that have PC104 set.
>>
>> Fixes: 2d3359f8b9e6 ("can: tscan1: add driver for TS-CAN1 boards")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Andre B. Oliveira <anbadeol@gmail.com>
>> Cc: linux-can@vger.kernel.org
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/net/can/sja1000/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20250718.orig/drivers/net/can/sja1000/Kconfig
>> +++ linux-next-20250718/drivers/net/can/sja1000/Kconfig
>> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>>  
>>  config CAN_TSCAN1
>>  	tristate "TS-CAN1 PC104 boards"
>> -	depends on ISA
>> +	depends on ISA && PC104
> 
> A bit unrelated but ISA depends on X86_32 so I would suggest to add a
> COMPILE_TEST so that people can still do test builds on x86_64.
> 
>   depends on (ISA && PC104) || COMPILE_TEST

Sure, I can change that and see if any robots find problems with it.

I did a few x86_64 builds with PC104 not set, COMPILE_TEST set,
and CAN_TSCAN1 = y / m. I didn't encounter any problems.


-- 
~Randy


