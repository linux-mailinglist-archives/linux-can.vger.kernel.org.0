Return-Path: <linux-can+bounces-3902-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FBAAE99D9
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 11:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229D11C24436
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5B29C344;
	Thu, 26 Jun 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Aerx4SeX"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4542298270;
	Thu, 26 Jun 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929796; cv=none; b=IAufElyMt0bQzgDp0t+jxaOV892lgcqjgizHhJ14M/0LFYzTPw4Ufs526eoqYwd+dMQvCWJgfG8WyNH7LJsqXay10wEXlWIdE7bniJzMPYtqTTJVx7fHkWyoSK0mCsoSZX+YqmWU2X81o20ESE5lNwBroyLM+fwzal3CjFvPtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929796; c=relaxed/simple;
	bh=xQiDfG0JfAa1Tm6olW7FwTlbLbB1AeNI6j+Tvq5aREY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkPlpBvg5o7KTa9G5lj0j6QPsI0ogzJU3Wjy2gSKHUI8i+du/uHPtqMSpo+KvlkNa9VOl6kl06mSujVUq/qKIffIR+/0uOF1MUZQzQOT7kTZ9UO1uVWKbGX0rttxlJoB9isyJjfut6X+VnrCFVYIIy5MjP0WSS+32ISQaPM1ND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Aerx4SeX; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Uip1uI3vBZOjKUip2uDRtA; Thu, 26 Jun 2025 11:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750929791;
	bh=/Xbc6kBGCyhNHHzNgJCbvuELoFJLHHCL5tuXaL6kLK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Aerx4SeXukHUIAul10z53hQ6zE5RDRA5rKvGxZbizaeJSnzmBSkbTb8ngF80oeRQS
	 I4FdP//dTCWhpZ9L79T4HjDNgNTQfLDUp1QkEGjuMr1AYzuIFdJj6yJvAnhLlLdQ7R
	 /1jLWOOU0gLfQHe7qrlck3YCs8DEtTxhxDQ9AyoFdkFNWDGrfa88cdj0ZxELPb96B+
	 6cz/MkqBtFRXEm1Zu7egwaOP8na5cUexg29+fY2drgdYAKOmpNMggQjyxZfZvy6CBy
	 yzi3MXCLWJZ0DyyfLWAFFT8wwJQYlcvFPPDItjwYgDpF0p4ZtKr+6/uqU69kaGPUFs
	 y5OwrmwKTRfWQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Jun 2025 11:23:11 +0200
X-ME-IP: 124.33.176.97
Message-ID: <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
Date: Thu, 26 Jun 2025 18:23:06 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can: ucan: Use usb_endpoint_type() rather than duplicating its
 implementation
To: Markus Elfring <Markus.Elfring@web.de>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
 <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
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
In-Reply-To: <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2025 at 16:22, Markus Elfring wrote:
>>> I am unsure if the check reordering would be desirable for this function implementation.
>>
>> Ah, you want to confirm whether
>>
>>   usb_endpoint_dir_in(ep) && usb_endpoint_xfer_bulk(ep)
>>
>> is the same as
>>
>>   usb_endpoint_xfer_bulk(ep) && usb_endpoint_dir_in(ep)
>>
>> ?
> 
> Exactly, yes.
> 
> Commutativity can probably be applied in this case.
> But the different execution order will influence the corresponding run time characteristics.
> https://en.wikipedia.org/wiki/Short-circuit_evaluation
> https://en.wikipedia.org/wiki/Commutative_property
> 
> The data processing order from known API function implementations might get priority
> also at discussed source code places in the near future.

Yes. This is what I tried to explain in my previous message: that the short
circuit evaluation may impact the result when there is an undefined behaviour
but that it is not the case here.


Yours sincerely,
Vincent Mailhol


