Return-Path: <linux-can+bounces-3492-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39470A9D012
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 19:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1481BA2EB6
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F2170A11;
	Fri, 25 Apr 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G0h6ZXpd"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C086FC3
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603812; cv=none; b=lj2Z5IbtN9l2ZqA/6vYdlutdD9GMz7PJXi1gnljjavLqYmb0dUsF2uEMHlPNutOU6YSuEKmHm6e04o4roKro50tIPdPHfEgRBTNgYGLYhSi/gvaz0EnZb5jMsTUjvpawQplJ8R/3G1rcDgU4meQuJyNarBGeu74t0G0KG/vbCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603812; c=relaxed/simple;
	bh=dbXTy5HkOK8jWQS59i3zIlSrccOizx6o9cHtgsEJBIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxJBD50I3jHU++jW341434j2BhI5dWYpARy1bdBXcrNJGo39wb+3ETePeSvYBkKe8mNravdN8FlV10c2JJuq2S9ijT8RHeMIDL4FFun5TmsZ3wGfe2T8/wNzHBYS8oB/9p+L03lVWzpEoBUzyXSTXV0DF+ZcRCyemeHn+mITfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G0h6ZXpd; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 8NHxup0CbSxyX8NI1uBwTX; Fri, 25 Apr 2025 19:56:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745603802;
	bh=YEEIqPma0juAYM58PjOWy5fyPZgL2IwloPC+s6ntjsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=G0h6ZXpdMuqAd2hu53QUD3CoU04s7Whhpz3GcfPavE99KIbSinEsIEDRKk9o1qWuQ
	 1yX/dIdpElmeDA34VLnno8Lgt2L4B/ADfPCiQwo/uqKAyB8pcTmY2JKGvPXZolQjin
	 kHMFAANqebF0vDl8D2wN5+5zh2bZAXslXT7NlW5ttMzNmojhdzxqBRTvWoOQe6uxjj
	 W51qiqudram9TJYwrmPVAzOMRi+qH0b/Dbva6o6R02nslq84hE1RJK1zwWvxv4udNm
	 2vKeY57UzEtzWFv7Le18WPaHQvQdUuLilpkptYOBEgvM6GN3wdd1q2peY9uxqLYhAd
	 oxSFDRAHn07HA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Apr 2025 19:56:42 +0200
X-ME-IP: 124.33.176.97
Message-ID: <69fcab23-4c64-422f-b941-b4e3b606b296@wanadoo.fr>
Date: Sat, 26 Apr 2025 02:56:36 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
References: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
 <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
 <91295576-C918-419E-B529-196BDDF1BE35@vpprocess.com>
 <dbf42ea2-6506-43ea-8f8c-3df9f620a166@wanadoo.fr>
 <A8DDA77C-227E-4F9C-80D4-DC9EAC6C3917@vpprocess.com>
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
In-Reply-To: <A8DDA77C-227E-4F9C-80D4-DC9EAC6C3917@vpprocess.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/04/2025 at 02:48, Kelsey Maes wrote:
>> On Apr 25, 2025, at 10:01, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>> On 26/04/2025 at 01:42, Kelsey Maes wrote:
>>>> On Apr 24, 2025, at 19:26, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

(...)
                                                  ^^^^
>>>> Once you do the above changes, the tdco will be calculated by the
>>>> framework. If I remember well, the mcp251xfd uses a relative TDCO, so
>>>> you should use can_get_relative_tdco().
>>>>
>>>> https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/dev.h#L115
>>>
>>> Are you sure it’s a relative TDCO? The Microchip documentation doesn’t
>>> explicitly say one way or the other but their calculation spreadsheet
>>> matches the existing DBRP * DTSEG1 calculation in the driver and my
>>> own embedded implementations which are all indicative of an absolute
>>> TDCO.
>>
>>
>> No, I am not sure. But if it is an absolute value, then it can only be positive.
>>
>> The fact that it is clamped between -64 and 63 is a strong hint that this is a
>> relative TDCO:
>>
>> https://elixir.bootlin.com/linux/v6.14.3/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L579
>>
>> I also discussed this with Marc in the past. It was a few years ago.
>>
>> But I did not check the datasheet personally, so take my comment with a grain of
>> salt.
> 
> I believe I actually read that thread in researching this issue. I think that discussion
> missed that while the TDCO value can be positive or negative the TDCV value is
> strictly positive, between 0 and 63. None of the CAN controllers I am familiar with
> permit the sum of TDCO and TDCV to exceed the maximum TDCV value. I honestly
> don’t know why this value is allowed to be negative or if it’s a datasheet error.

Yes, I also emitted this hypothesis in the past.

> What I can say is that my testing has shown that when using can_get_relative_tdco() at a
> 4 Mbit data rate the final TDCO value is 1, which is close to the ideal relative TDCO
> of 0 but only 10% of the bit time in an absolute model, I get bus-off errors in dmesg.
> If I use priv->can.tdc.tdco which provides a final TDCO of 8, exactly 80% of the bit 
> time in my configuration, the bus works.
> 
> I’m going to prepare a new patch based on absolute TDCO for now.

If the relative TDCO hypothesis is disproven by your empirical testing, makes
sense to continue with the absolute value.

Just make sure add into the patch description what you just explained above so
that we have a clear record about this relative vs. absolute TDCO.


Yours sincerely,
Vincent Mailhol


