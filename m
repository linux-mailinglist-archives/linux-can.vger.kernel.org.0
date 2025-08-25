Return-Path: <linux-can+bounces-4367-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F982B34697
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3CE484B14
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744FE2FF654;
	Mon, 25 Aug 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0PK3W7/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA83002C9
	for <linux-can@vger.kernel.org>; Mon, 25 Aug 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137677; cv=none; b=Bj98e+8+T6KaPWW4nKk2cGgop6enrzXxMS9dwhMA6eGpoxdw0kttvSKk4H0JT9Zt6LtuwVy0h2lYy9Fg0BKlj6L0oiH+Px846yzuLD8swRdyTDd++fjGcevDeFA8nkoWQWfQNo+yjG7tpAVzrJQLQ1sp3gQUeW5lDZWZtCtr/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137677; c=relaxed/simple;
	bh=ImELanaDWX2xYDwLUfpNlbKy1dO8fePPjEZOdxzGdeE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8vTBGxe8SgczexSsz9SM7W8k5tYaLtTjfqWoUJX/R6l6+wXFaYnFhwqElaPAIWcTo5pnGolwIVb4vltpfzlOgTnv+so+V/xifO3UMwRQAW+P8l6GxGXmP6fbmF6mjS9fi898U5snYuSR1Xnswhn7xS0aSuigsBJpkdtQ1Jvxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0PK3W7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2ADC4CEED;
	Mon, 25 Aug 2025 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756137674;
	bh=ImELanaDWX2xYDwLUfpNlbKy1dO8fePPjEZOdxzGdeE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=u0PK3W7/2nsRR/VMKpZJFiaoEN0EITZAZqH3VUiByKSF+nsOkmQUvcBN81l+nQOO2
	 1+u4bBawyrTG0tVNTAIrbUepJ9FrIOHwOLsPdDmkWO1jmwzk4O4cdf/bK8ZZh9XGQW
	 8L21FehgxcZ259rx3qBaFM9EaXbnhuke0okNdz6azbFQl/o1rJ82yOlay/OVH+2V8q
	 qODW49dJuPoEcmzbETOgEUFcw5T1j6hC5JpCqDPQNJCxxMHFMm6lj6208qucvM/91L
	 GI45eVESiKRH3g9vuHU+0uwDMMYVBpVl8MI5xkWWpiF6VYERbL8/BLM/pDYbJ/gh8g
	 oCs1lqy4GnFvg==
Message-ID: <129e9fc4-c69e-48d5-b4be-e437184150b2@kernel.org>
Date: Tue, 26 Aug 2025 01:01:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
From: Vincent Mailhol <mailhol@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Robert Nawrath <mbro1689@gmail.com>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
 <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
 <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
 <d73d326f-0c49-4e21-8d59-2f54e2be5f0e@kernel.org>
 <d2ce032e-cca5-4050-ae1a-6fe5f8a0b25f@hartkopp.net>
 <5db57860-05ad-4925-a9b3-18ce2d88ab0d@hartkopp.net>
 <d3cc9f51-e599-4c8d-b2b6-016fd160a081@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <d3cc9f51-e599-4c8d-b2b6-016fd160a081@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 at 17:32, Vincent Mailhol wrote:
> On 25/08/2025 at 16:17, Oliver Hartkopp wrote:
>> On 24.08.25 22:24, Oliver Hartkopp wrote:

(...)

>>> 2. Can you share some PWM code for the iproute2 package or do I need to adapt
>>> this code myself?
>>>
>>> https://github.com/hartkopp/canxl-nl/blob/main/iproute2/0005-iplink_can-
>>> canxl-add-PWM-config-support.patch
> 
> OK. I will upload the iproute2 later on. But same as the above, it will *not* be
> ready for review. So, please, do not share comment for now.

And here it is:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink

This part is far from completion, but at least you have the PWM interface. I
plan to finalize the iproute2 last once the kernel part is fully working.

One more time, this is a WIP which is *not* ready for review.


Yours sincerely,
Vincent Mailhol


