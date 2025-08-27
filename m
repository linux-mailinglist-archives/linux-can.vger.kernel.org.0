Return-Path: <linux-can+bounces-4381-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637EB37D4E
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B68B1BA1164
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD7B322C7A;
	Wed, 27 Aug 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLDnWe8Q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960821DFF0;
	Wed, 27 Aug 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282466; cv=none; b=BG5MF4i4yZEBepWzcA8SpIOq0Q7mIY+0vz9CZaW4HPXLFQHrqQ26Ziu+tDU6dnuNbJz78s8xKiBB2Qk7j0sB66PKxa/BFTB0KdC7Q2hFFB8ZTmZzxjBXxlvILLAkFg90h902iLOx7+Ic5n3dU6sp6vZsWp36Vr3Oxyzrr/y7hJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282466; c=relaxed/simple;
	bh=WEfVTlwhN12P2iqpeiMXMEx2DULAa/9N/0mrwn60IkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOzJ53sy1LA5RtGuthoPn6jUY958czz8hjX6eHNMvQFC0lNGcVWCzfDXr2mSb73iMGPBG/NKRkN3J9bWvU2JEh6U6W2xjpqr0STUUrDkCx0qX2g1RN6NIAYBB172Sy70WK9dJZ0A87Las5nE1T4sZe4F6ALRIUwvleFZ8tI4xm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLDnWe8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7877C4CEEB;
	Wed, 27 Aug 2025 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756282466;
	bh=WEfVTlwhN12P2iqpeiMXMEx2DULAa/9N/0mrwn60IkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLDnWe8QAr5v/3DWBBCUZx8xX5fZbxZpYX2pPfUkvMyFJuXm7+/8hETRW7J6pn8qy
	 4D+p8OIc4Oa6Ci0unL7bMJTBCGwRLn7QwDXgZDAM5jNPg1i/9zZg7dRemrkZ+5/rjw
	 4nQxem5WhhCFxdHUvUtIY4+DAQoYL1OehGnSewdwfzKyxgwL07bzQR46pJNq041+zC
	 1vsTcYM/f1goIas8pluIbkn9coXTb9VrW7VkI+DyugG7Uw0Jdjci8yl01WvT6sK0JS
	 B1D2TMncWB6IDfOa8aU9TW/F7cxrsSRyrjp5Z0mgBsfpHwLlTQ9ebjWyICyR1CUpGo
	 oImveyAR1jv2A==
Message-ID: <1e8b20dd-1afa-46ed-81a6-52614a43056e@kernel.org>
Date: Wed, 27 Aug 2025 17:14:24 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826105255.35501-2-mailhol@kernel.org>
 <20250827-winged-bizarre-mackerel-a91272-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250827-winged-bizarre-mackerel-a91272-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2025 at 16:40, Marc Kleine-Budde wrote:
> On 26.08.2025 19:48:39, mailhol@kernel.org wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> Now that I have received my kernel.org account, I am changing my email
>> address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
>> wanadoo.fr address was my first email which I created when I was a kid
>> and has a special meaning to me, but it is restricted to a maximum of
>> 50 messages per hour which starts to be problematic on threads where
>> many people are CC-ed.
>>
>> Update all the MAINTAINERS entries accordingly and map the old address
>> to the new one.
>>
>> I remain reachable from my old address. The different copyright
>> notices mentioning my old address are kept as-is for the moment. I
>> will update those one at a time only if I need to touch those files.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> 
> Applied to linux-can-next.

Thanks!

> BTW: The "From" header of your mail only contains you e-mail address,
> not your real name.

Yes, I did not properly set the from field in my .gitconfig and because this is
the very first email which I sent using my new email and git send-email I
couldn't notice it. I spotted the issue just after sending and it is already fixed.


Yours sincerely,
Vincent Mailhol

