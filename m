Return-Path: <linux-can+bounces-2056-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A09C8A11
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 13:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D9B1F22794
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE761F9ED8;
	Thu, 14 Nov 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l9Jn6FuM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0E1F9A8D;
	Thu, 14 Nov 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587727; cv=none; b=sUNRZ3yYvKO1hXhtdz/yjjEeZuUxwaowLYgbWNvY3Q8JxA0Yo8I9jFE/EcwUVGEZrxw2la3A0/FJpzkpQxpMaiUfAcEyBI8/0BhyEhufgejsLDSvF/MDaffLwtVHh8Kh7N2kXG1GiiCPsDdf+neitFgCAMkzXRdcGn1EvqS9eSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587727; c=relaxed/simple;
	bh=0WkcxfAr+SjjzcYjh2T51top57BNY5aFPaykSjgrnC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg2jWAS9kgNLGAtjxAuFM3yu9Zn6HoEolmlEnD5/p8Fjv5d82ghJrr71Co/urh5RQ0e8/+vSHtekPYMRfXxuKnqJD/ZRKIaYan9SaxmsmSsW6Y6kfEtMxG0G60U0371bXTQW4s6DIFtp6yCoO1VdkloTIhmoaKpSSr3LSaNQ0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l9Jn6FuM; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BZ40thIaGgtkHBZ41tUC1a; Thu, 14 Nov 2024 13:35:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731587716;
	bh=BHNcnOVeaZJasUSVXJ8QJzu53w+/kj7LUAx1oq0vuHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=l9Jn6FuMBGr93BnQyPWs2l4LR7uh6VRheNq5TKgkXecQKIJuHI1IZS/H/vDQn5SV4
	 HaRCZr4jrNuflztCnnbIo5O497lgQwskwO7oE3Qir8RLLE5cvp7TMiE1ypnBSploF2
	 WPPxl/O0AUARNFLr8m4yFaAWXxfDDUHPxasy4TX4eqsrdwkP/1Rk35qrSt4u6qvuOc
	 6QMKfFvfDgQ2mVLJFa3Hu9/Rgz6qoyNg1DYQp23ZqgaBwlcxEYxc5n7K9uAACBSjiO
	 eWxk8AzcqXmZibMAoBxEOOoDy/3ifGT6zHlQtKK3TTuoPhykJXVNxZVUX7drOADaN6
	 Ji/mRWELRS8dg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 13:35:16 +0100
X-ME-IP: 124.33.176.97
Message-ID: <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
Date: Thu, 14 Nov 2024 21:35:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
To: Dan Carpenter <dan.carpenter@linaro.org>, Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 at 18:57, Dan Carpenter wrote:
> On Thu, Nov 14, 2024 at 06:34:49PM +0900, Vincent Mailhol wrote:
>> Hi Dan,
>>
>> On 14/11/2024 at 18:03, Dan Carpenter wrote:
>>> This code is printing hex values to the &local_txbuf buffer and it's
>>> using the snprintf() function to try prevent buffer overflows.  The
>>> problem is that it's not passing the correct limit to the snprintf()
>>> function so the limit doesn't do anything.  On each iteration we print
>>> two digits so the remaining size should also decrease by two, but
>>> instead it passes the sizeof() the entire buffer each time.
>>>
>>> If the frame->len were too long it would result in a buffer overflow.
>>
>> But, can frame->len be too long? Classical CAN frame maximum length is 8
>> bytes. And I do not see a path for a malformed frame to reach this part of
>> the driver.
>>
>> If such a path exists, I think this should be explained. Else, I am just not
>> sure if this needs a Fixes: tag.

I confirmed the CAN frame length is correctly checked.

The only way to trigger that snprintf() with the wrong size is if 
CAN327_TX_DO_CAN_DATA is set, which only occurs in can327_send_frame(). 
And the only caller of can327_send_frame() is can327_netdev_start_xmit().

can327_netdev_start_xmit() calls can_dev_dropped_skb() which in turn 
calls can_dropped_invalid_skb() which goes to can_is_can_skb() which 
finally checks that cf->len is not bigger than CAN_MAX_DLEN (i.e. 8 bytes).

So indeed, no buffer overflow can occur here.

> Even when bugs don't affect runtime we still assign a Fixes tag, but we don't
> CC stable.  There is no way that passing the wrong size was intentional.

Got it. Thanks for the explanation, now it makes sense to keep the 
Fixes: tag.


Yours sincerely,
Vincent Mailhol


