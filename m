Return-Path: <linux-can+bounces-4647-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C48B51D6B
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58A5167558
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A8261B71;
	Wed, 10 Sep 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLDaypuM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB721507F
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521185; cv=none; b=YLp04rRJTfuAVDowuG/qNIYoQ82XgMPV8AUUVeHP56EQOEon6sJCIcFGfXQR5iiYV5SoXfj0Xk5xylnHq8nHgJK8N26DUlUllPGt6m1kciAxEtUnQE5ycFzazLXOk9q5fi1/Ha+f7GS1HLCmesUoOBFDnbGDFbv5pYMNixp6DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521185; c=relaxed/simple;
	bh=ap5H9wu/EFHK4jHCPiGEPNbM85JYYkVobDCorMzH2AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J4/rfqktSWiAQHPuzhlqxSkMTvVYZwTtAEjf6s2I0GWc90f/qOPo2n5bbboxk1dgXctYn3zziRdQdlzg5coehinaTx03XlcicnmnXdlM17oREq5vX0P6UvZW+t+TlFWxHqQA4CSm2nU0/ymVmEh/8w8m9TL9T6nIZ0c7/qaQ5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLDaypuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517E2C4CEEB;
	Wed, 10 Sep 2025 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521184;
	bh=ap5H9wu/EFHK4jHCPiGEPNbM85JYYkVobDCorMzH2AI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MLDaypuMGnb5ditpKMPob99Qac7uNCsqP3If2idbxbn2DyP1xrJ7+F6Hebc6FNjDG
	 +tsG/cckcc6C4lNiqq/QIatQAIVACbNJC9NfAbx6xp/69evzk3yMWg2m+6GXg/oKN3
	 Me6M0TjA2IAUdCP9JKgSC4p+viQTsAVrU6SBNIZwLJMQX3Qc8TRzolUlFWpcPeeIzj
	 5WtGKW+6m6aVOuixYDt4unFQwtKOgVOVoLM9v3pfo/yOVxYqM7sn773AKiYsqWMwMd
	 oQ8t4aLDffMZEV0N/+Y4/U0wRUMtJnkywWMQG777yTZXv+ZpCgC3spJ5xPWSahEa1e
	 40wWO8a6mBaBQ==
Message-ID: <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
Date: Thu, 11 Sep 2025 01:19:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
In-Reply-To: <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
> On 10.09.25 09:40, Vincent Mailhol wrote:
>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
> 
>>>>      /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>         if (!priv)
>>>>             return dev->mtu == CANXL_MTU;
>>>
>>>          return can_is_canxl_dev_mtu(mtu);
>>>
>>> The MTU of CAN XL interfaces might vary.
>>
>> Maybe this is something that we discussed before, I do not remember, but how is
>> it that the MTU can vary?
>>
>> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
>> frame is variable, but the MTU should be constant, right? Why can it vary?
> 
> Depending on the realtime requirements the length of the CAN frames (and
> therefore the time the bus is blocked) the MTU can be reduced. This is (like the
> bitrate settings) a network architects decision which is enforced by setting the
> MTU accordingly.

Is this an extension we offer in Socket CAN? The standard says nothing about
having the MTU configurable.

For CAN FD, we forcefully set the MTU in netlink.c

https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/netlink.c#L228

I will have to think of what are the implication for CAN XL.


Yours sincerely,
Vincent Mailhol


