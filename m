Return-Path: <linux-can+bounces-4700-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F1B5774B
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05833A5712
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB12FE07D;
	Mon, 15 Sep 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4mHR2rO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B062FE07B
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933737; cv=none; b=ApVV/psrdoitlhN3B5/v8oYfxjAS8Q1gGy2TAIZJGu6YTVCsSeLmXgRfgaWzl98eulGTQqql98rXGwXM/L49f5I5rD8bp/hf0FFIEUNzLKgvRxebTQVcIrO1kIj9CQBaUkummqBCSFmG26IAthZNA2TN4EYVvUafeS6xJQi+joo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933737; c=relaxed/simple;
	bh=9c+89oE/VMahb0urR4z1FNnSxWL4a54186DgDOpiXzQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=B1rMsv2TTNAvF3AeA5D6M61QJWJ3pBMmOMkTcBu1nBkcBk/tYv0eEyLUFlfYl+Nq78YCtruMQMrPBweGKhQWwvVuF0PGsbaBZ7VXlzNI3g80L7oAnpuWW5d+XYcS1WpHuaGhNNEmoImq7tIUV/wyQR+wQTxzXGPVbVJz49SWxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4mHR2rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4ADC4CEF1;
	Mon, 15 Sep 2025 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757933737;
	bh=9c+89oE/VMahb0urR4z1FNnSxWL4a54186DgDOpiXzQ=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=B4mHR2rOCk2bD5EG8UV/lGvJd+YsiWJxq59wdcNTf2hHvnB3s0qXBJ+aWp70Kqe4N
	 x/oXd1P0Qq+Na5OS9Yp4+zj1vgy7nIiORx6xflcDR2lQZLsPWwwcyo+HZvNfhpgvJo
	 kM25CPIB6c6Fm/bPXCE8LwSxIHmzBsuFJLi1WdqRlvlACptpTlEbmS/KuYNDGwiGCl
	 T11bRv7ckO6spGPFhgYppM6ggz2cPhfMkrnB7oO95/D2LRqhhYuDI3LpF4vt2Z/EDg
	 EAcdHSJfKditxWFsDaOeqCqn7hE/0n748Y7aDDvGh8Fjy1CsNbBm/Cevp4XcFwsvlI
	 2M0WbhJDBtNEg==
Message-ID: <67e0351c-b478-4938-a42d-77764b27b9d1@kernel.org>
Date: Mon, 15 Sep 2025 19:55:35 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
 <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
 <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
 <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
 <6afc7e2d-eecf-4c47-bcef-0e2cdd7f4a89@hartkopp.net>
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
In-Reply-To: <6afc7e2d-eecf-4c47-bcef-0e2cdd7f4a89@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/09/2025 at 05:12, Oliver Hartkopp wrote:
> On 10.09.25 18:19, Vincent Mailhol wrote:
>> On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
>>> On 10.09.25 09:40, Vincent Mailhol wrote:
>>>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
>>>
>>>>>>       /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>>>          if (!priv)
>>>>>>              return dev->mtu == CANXL_MTU;
>>>>>
>>>>>           return can_is_canxl_dev_mtu(mtu);
>>>>>
>>>>> The MTU of CAN XL interfaces might vary.
>>>>
>>>> Maybe this is something that we discussed before, I do not remember, but how is
>>>> it that the MTU can vary?
>>>>
>>>> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
>>>> frame is variable, but the MTU should be constant, right? Why can it vary?
>>>
>>> Depending on the realtime requirements the length of the CAN frames (and
>>> therefore the time the bus is blocked) the MTU can be reduced. This is (like the
>>> bitrate settings) a network architects decision which is enforced by setting the
>>> MTU accordingly.
>>
>> Is this an extension we offer in Socket CAN?
> 
> Yes.
> 
>> The standard says nothing about
>> having the MTU configurable.
>>
>> For CAN FD, we forcefully set the MTU in netlink.c
>>
>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/netlink.c#L228
> 
> Oh. I did not realize before that we can either modify the MTU with setting fd
> on/off and via setting the MTU in can_change_mtu()
> 
> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L313
> 
> ?!?
> 
> The two APIs problem for changing the MTU?!?
> 
> I expected the default MTU for CAN FD capable interfaces to be CANFD_MTU which
> is obviously not the case.
> 
>> I will have to think of what are the implication for CAN XL.
> 
> I would define a default CANXL MTU (CANXL_MTU 2060) which might be changed with
> can_change_mtu().
> 
> And when ever we switch xl on this value is selected as device MTU.
> 
> Or the user can change the MTU as he needs it.
> And when xl on is selected and the MTU is a can_is_canxl_dev_mtu() this value is
> used. When can_is_canxl_dev_mtu() is not true we take CANXL_MTU.
> 
> Something like this.

Yes. I was thinking of something similar. This is what I added locally at the
moment:

	if ((priv->ctrlmode & CAN_CTRLMODE_XL) &&
	    !can_is_canxl_dev_mtu(dev->mtu)) {
  		/* Set CAN XL MTU to its max unless if already set by user */
		dev->mtu = CANXL_MAX_MTU;
	}

But I am still testing it.


Yours sincerely,
Vincent Mailhol

