Return-Path: <linux-can+bounces-2059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6949C8D5A
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 15:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00DF1F24538
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC974BE1;
	Thu, 14 Nov 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XQvJgcUi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7E3C466;
	Thu, 14 Nov 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596065; cv=none; b=CMrGOpXcclJpfQkTMW6bwn56MCwuFSqKVFAY+ZyJZV22eLU0pCHZpm/w8ediQx7t5i9nq1/FEItqiqjAIqPFzbUAmL3Mxg+eyOl8TKO2axCcGiln2p6UEo1ZZ6CMj8FSOe3fRol5jgzgZQT2GO4xAwS1DwX65E6pcrVIvqvBK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596065; c=relaxed/simple;
	bh=7urnx5vu/yESHJWnIBOTy1RbM2n6RW2xZI/t8XcbpJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joYjcOuqiPVKoSJqBPRSIvDl+dvmsXofU2BKExXeK9PtvQicylWXUECPsx5UdtJKB4yYSdEeuL6sodJQS6Kh8XHMmOI0rhdOK4XxqFkqWWVGJSLdvhSdbqwy0Dp9r7GtNrqTWOcjQdV8lHOIiyvjDE7a9+tckKPsN4af+eijN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XQvJgcUi; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BbEatkpiFKUdDBbEctKGl2; Thu, 14 Nov 2024 15:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731596060;
	bh=6aybBEMH2m5gabV302QoPDrP38h4o14hvmeyTfnxSfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XQvJgcUiwKA0R69DkqnvYqg7v4kaDqqKJCEN8yuYn3+dIw467fIWYLjESWfyuCjIk
	 MhuyrSYGKzE0EAo8iKZ32Xvh4N45zwr7+KeNb7BJuyFLiwEOPVi0wDBw8b2rVX97nt
	 QS41SEmSQX5KRNUdHsj/TgTGmXlcTQmpbQHjhbZ9pWzwtFi5gY1roF/W81KWFMnNFv
	 TmynebIVaI/xeourGNBUDY04YSACdO197A+dXEYTFsF3lkvE2pjjNL1peLRQ6aGu/P
	 sVS1lygl5GtgGomK8HA/YXyyLw7LprLPhKZT+e/u1/h/JvhztlynF7iPLSyWKRDrV2
	 3IjXs2hGzbvaA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 15:54:20 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>
Date: Thu, 14 Nov 2024 23:54:11 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Max Staudt <max@enpas.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
 <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 at 22:34, Marc Kleine-Budde wrote:
> On 14.11.2024 21:35:07, Vincent Mailhol wrote:
>> On 14/11/2024 at 18:57, Dan Carpenter wrote:
>>> On Thu, Nov 14, 2024 at 06:34:49PM +0900, Vincent Mailhol wrote:
>>>> Hi Dan,
>>>>
>>>> On 14/11/2024 at 18:03, Dan Carpenter wrote:
>>>>> This code is printing hex values to the &local_txbuf buffer and it's
>>>>> using the snprintf() function to try prevent buffer overflows.  The
>>>>> problem is that it's not passing the correct limit to the snprintf()
>>>>> function so the limit doesn't do anything.  On each iteration we print
>>>>> two digits so the remaining size should also decrease by two, but
>>>>> instead it passes the sizeof() the entire buffer each time.
>>>>>
>>>>> If the frame->len were too long it would result in a buffer overflow.
>>>>
>>>> But, can frame->len be too long? Classical CAN frame maximum length is 8
>>>> bytes. And I do not see a path for a malformed frame to reach this part of
>>>> the driver.
>>>>
>>>> If such a path exists, I think this should be explained. Else, I am just not
>>>> sure if this needs a Fixes: tag.
>>
>> I confirmed the CAN frame length is correctly checked.
>>
>> The only way to trigger that snprintf() with the wrong size is if
>> CAN327_TX_DO_CAN_DATA is set, which only occurs in can327_send_frame(). And
>> the only caller of can327_send_frame() is can327_netdev_start_xmit().
>>
>> can327_netdev_start_xmit() calls can_dev_dropped_skb() which in turn calls
>> can_dropped_invalid_skb() which goes to can_is_can_skb() which finally
>> checks that cf->len is not bigger than CAN_MAX_DLEN (i.e. 8 bytes).
>>
>> So indeed, no buffer overflow can occur here.
>>
>>> Even when bugs don't affect runtime we still assign a Fixes tag, but we don't
>>> CC stable.  There is no way that passing the wrong size was intentional.
>>
>> Got it. Thanks for the explanation, now it makes sense to keep the Fixes:
>> tag.
> 
> Should we take the patch as it is?

I am not keen of taking it as-is. *At least*, I think that the 
description should be updated to say that this bug can *not* result in a 
buffer overflow because the frame length limit of eight bytes is 
enforced by can_dev_dropped_skb(). If we keep things as-is, I am worried 
that we will create additional work for the CVE team.

As for the code itself, why not, but I prefer the suggestion made by 
Max. If the length can not exceed eight bytes, why writing code to 
handle an otherwise impossible to trigger condition?

I also quickly looked at the hexdump helper functions and found bin2hex():

   https://elixir.bootlin.com/linux/v6.11/source/lib/hexdump.c#L87

It is promissing on first sight, but it produces lower case hexadecimal. 
And it doesn't look like the can327 would accept that.

At the end, I am fine to defer to Max the final decision on what to do 
on the code. At the end, he is the maintainer of that module.


Yours sincerely,
Vincent Mailhol


