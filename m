Return-Path: <linux-can+bounces-2050-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49F9C8640
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EAA1F212EA
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7D1F6669;
	Thu, 14 Nov 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oKXO3QgC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D61F470B;
	Thu, 14 Nov 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576900; cv=none; b=Y0MOKXC5lmrStgi5QAIUlgdGjLSFjioOQUssw3ZZm4wGb21suRwfi1UJMboP3MMqNL5BT6iDAqi6lJkkQ+u7VzMLFG7Hl15ZBTkQ0pBGnhYUzkS7fXDEPzzbNzt48KftxqD0QgNGHUz0I7NuIFv03LEEwbnZiQunBkHIVlZ/+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576900; c=relaxed/simple;
	bh=z6+I7+CYarKdEBPM3FA1TYZtfIOd/tndwNaEyQSMZPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si+o1NdJjWDZmYTHdb0/+2rAyKQyKPdAUSc0+rpGO7zDZ8Os/mBN/JobaifbqlXAuNWzLjPYRgD53Jtz48dU/TaBa8t941H5yBD2LLkQnge//gw2MKFHUXSb/k95joOIYMgqlj0ZIQ83PEMH1j++sZMsKK1AGE4kJpxvCygewK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oKXO3QgC; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BWFRtPe7vUepfBWFVtwEYZ; Thu, 14 Nov 2024 10:34:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731576896;
	bh=FUfrCo/CScN+GZNhfYe1RnJiRuI/wkqeEkNkQMFOKuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oKXO3QgC7FzfFdy24K6cirs9PpHvYwoFE6Z7m7KGTU6+Gh8NYcVb2naYhOLpARhOd
	 9lwfdmZ38E+GDrFpo0Pou7aGe5gaOK8B8ifN6NoYWWwe6ENT9OqDLZx07S6w/jw9aI
	 o6KedacyMCGxGi4QDsn/dsxo8bg7ywzXOQzE5m2N99EhqUvc7VRgiyRAdc/2QGC2QF
	 X9qp+q7kxazuf2ye8i3JnDaj9Ki1c2hFDioPzKTGssmhy3CNUPJ/fT55ns6lHWSqgK
	 siG/kPv1IxGaGmBxdlor+kh1sFIJj/U1aV/JiVcYBg1TYuGBSmuUxbuaG0h//Zfmbj
	 GWi7qSxbPqQkw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 10:34:56 +0100
X-ME-IP: 124.33.176.97
Message-ID: <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
Date: Thu, 14 Nov 2024 18:34:49 +0900
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
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

On 14/11/2024 at 18:03, Dan Carpenter wrote:
> This code is printing hex values to the &local_txbuf buffer and it's
> using the snprintf() function to try prevent buffer overflows.  The
> problem is that it's not passing the correct limit to the snprintf()
> function so the limit doesn't do anything.  On each iteration we print
> two digits so the remaining size should also decrease by two, but
> instead it passes the sizeof() the entire buffer each time.
> 
> If the frame->len were too long it would result in a buffer overflow.

But, can frame->len be too long? Classical CAN frame maximum length is 8 
bytes. And I do not see a path for a malformed frame to reach this part 
of the driver.

If such a path exists, I think this should be explained. Else, I am just 
not sure if this needs a Fixes: tag.

> I've also changed the function from snprintf() to scnprintf().  The
> difference between the two functions is that snprintf() returns the number
> of bytes which would have been printed if there were space while the
> scnprintf() function returns the number of bytes which are actually
> printed.
> 
> Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> ---
>   drivers/net/can/can327.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index 24af63961030..5c05ebc72318 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c
> @@ -623,16 +623,16 @@ static void can327_handle_prompt(struct can327 *elm)
>   			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
>   		} else {
>   			/* Send a regular CAN data frame */
> +			int off = 0;
>   			int i;
>   
>   			for (i = 0; i < frame->len; i++) {
> -				snprintf(&local_txbuf[2 * i],
> -					 sizeof(local_txbuf), "%02X",
> -					 frame->data[i]);
> +				off += scnprintf(&local_txbuf[off],
> +						 sizeof(local_txbuf) - off,
> +						 "%02X", frame->data[i]);
>   			}
>   
> -			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
> -				 "\r");
> +			scnprintf(&local_txbuf[off], sizeof(local_txbuf) - off, "\r");
>   		}
>   
>   		elm->drop_next_line = 1;

Yours sincerely,
Vincent Mailhol


