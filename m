Return-Path: <linux-can+bounces-2045-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9E9C861D
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4DE2881A2
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A61F4718;
	Thu, 14 Nov 2024 09:27:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22E1F4FD0;
	Thu, 14 Nov 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576452; cv=none; b=c3IlJ13HgJlW+5bgDN5nLAXYSZDclbGpGK3LVeJgQ9cYdxu0yyH35hthgkXJZsEYsI1QTfKiER+FGgaqvdjCb7FfhUKjW2e+E7ZxLRa1B6dLa/ZO3EU3LcVWn8ij96IHwx6vygMSRZXPcxW98cUPAnX/qdonZjtScz427NMimx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576452; c=relaxed/simple;
	bh=vcmNDMnHTCbsk7v+wIdqk7Q11DIafstDmw6Umqcbmks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNb2LLU8k3p8uBSIs6GiITDOG8LDagjfNRBua42Pj7tzf6ED0hJoq1A4hG+3fYdT2DX/tlkQTMxkctk478K2jEfUNH28qzph9p92PrOeXb7Z+S7c0M9DLLUDG5/W/8x11GWPqPJ5LU5Qd2bnc18TagmCZW3FkHf6N3Qpazkaq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 93ED0102EC3;
	Thu, 14 Nov 2024 09:19:16 +0000 (UTC)
Message-ID: <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
Date: Thu, 14 Nov 2024 18:19:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
From: Max Staudt <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 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
 PsRBqTJGs7jw5gOWMMchFaemEnEJtg==
In-Reply-To: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

On 11/14/24 18:03, Dan Carpenter wrote:
> This code is printing hex values to the &local_txbuf buffer and it's
> using the snprintf() function to try prevent buffer overflows.  The
> problem is that it's not passing the correct limit to the snprintf()
> function so the limit doesn't do anything.  On each iteration we print
> two digits so the remaining size should also decrease by two, but
> instead it passes the sizeof() the entire buffer each time.

D'oh, silly mistake. Thank you for finding it!


IMHO the correct fix isn't further counting and checking within the 
snprintf loop. Instead, the buffer is correctly sized for a payload of 
up to 8 bytes, and what we should do is to initially establish that 
frame->len is indeed no larger than 8 bytes. So, something like

if (frame->len > 8) {
	netdev_err(elm->dev, "The CAN stack handed us a frame with len > 8 
bytes. Dropped packet.\n");
}

This check would go into can327_netdev_start_xmit(), and then a comment 
at your current patch's location to remind of this. Also, snprintf() can 
be simplified to sprintf(), since it is fully predictable in this case.


It's also possible that the CAN stack already checks frame->len, in 
which case I'd just add comments to can327. I haven't dug into the code 
now - maybe the maintainers know?


I can whip something up next week.


Max


