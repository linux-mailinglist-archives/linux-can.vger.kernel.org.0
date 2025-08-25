Return-Path: <linux-can+bounces-4343-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9CB33948
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FD83A40EC
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986D2BEC3F;
	Mon, 25 Aug 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep09O+XL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93902BD033
	for <linux-can@vger.kernel.org>; Mon, 25 Aug 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110776; cv=none; b=nP/xfqCd5o5Ls+ksk18svjjo5MPfQubwvZE6E/nxs9vGWK8wRqIRoD3kDD2ecXSNEbsNgokMQo+tK8n6fASiN0Uef0YSjcaKxmAhmfRkOSsfdecYy/gnWqRFxtWQUoIL691It4gEiOyL2oCq6ct253PvLDXvR4wGiCUJiFVDdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110776; c=relaxed/simple;
	bh=sCGB45VGwjSr55tFCErYCOMSaxRwvKF25iqxBFRHAtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3yDLcKRrXN2e2SlgizJUwdM4YJISZFxsE7FhMqni3wQt16Z0hlAfddFd3R955LNwp+IHqkXeLlmbeal8IybyOogFYidVNSyppjxYM86rOJyi32d3wKMDkE93Zyy5fvIwfI0cMnGY1MN7bqAch69IToq6fbD5BZnwWHNnQirM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep09O+XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23A5C4CEED;
	Mon, 25 Aug 2025 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110776;
	bh=sCGB45VGwjSr55tFCErYCOMSaxRwvKF25iqxBFRHAtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ep09O+XLP2YjQXEMvflPh04ekwjlWpiSBIj8JX+NONc/B/WQeV0anSgAc2W1yPsWQ
	 5P8hPOkHc4n/xuoWpTlxdB0VSXdetquBKFanqaj1jCMZIiXIQtViu37ZhN9YIPtGHx
	 THgsLqU6LLhbBG20xCe/qBagF6ZW4M/stKm8dHAYFm3v0vY5l5u3M5gGh6webYBnOW
	 +OsihGuKvby2VMZNx/udHbkl21qnX1cQd/BNrt7VhkwSjCTKioq85+S7702sNhMqnP
	 5ak+ynKMa/WwbP95H6Vz/kIkr9KHrUzKUOgi6+49L5pT6nocu5mA4Y7HrB/rguP2+4
	 eyQEhVKTYyMxQ==
Message-ID: <d3cc9f51-e599-4c8d-b2b6-016fd160a081@kernel.org>
Date: Mon, 25 Aug 2025 17:32:54 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
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
In-Reply-To: <5db57860-05ad-4925-a9b3-18ce2d88ab0d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2025 at 16:17, Oliver Hartkopp wrote:
> On 24.08.25 22:24, Oliver Hartkopp wrote:
> 
>> On 21.08.25 17:47, Vincent Mailhol wrote:
> 
>>> I uploaded my current WIP here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/ log/?h=b4/
>>> canxl-netlink
>>>
>>> As you will be able to see, most of the features are here. Now, I am trying to
>>> think of all the edge cases and make sure that any incorrect configuration is
>>> correctly rejected.
>>>
>>> I am just sharing this to reassure everyone on the progress. The patches are not
>>> yet ready for discussion. You can have a look if you want, but no need to do a
>>> review as I am still making changes.
>>
>> I upgraded my hardware test setup to 6.17-rc3 with the patches from your b4/
>> canxl-netlink branch.
>>
>> Most things were easy to adapt but the netlink PWM API.
>>
>> Two questions:
>> 1. Why did you make the PWM values u32 as the 6 bit will always fit into a u8
>> value?

u32 is the common method for netlink interface.

Marc raised the point here:

https://lore.kernel.org/linux-can/20250528-encouraging-scallop-of-expression-2d1ebe-mkl@pengutronix.de/

and I agree with him (and anyway, my intent was to use u32 from the beginning
even before Marc sent his comment).

>> 2. Can you share some PWM code for the iproute2 package or do I need to adapt
>> this code myself?
>>
>> https://github.com/hartkopp/canxl-nl/blob/main/iproute2/0005-iplink_can-
>> canxl-add-PWM-config-support.patch

OK. I will upload the iproute2 later on. But same as the above, it will *not* be
ready for review. So, please, do not share comment for now.

> Well, that was an unneeded effort as you pushed your changes just a short time
> after I adapted all my code :-/
> 
> Can you please post your changes here on the mailing list so that the usual
> development process is executed?

Well, what can I say? Read again the message I posted right above:

  I am just sharing this to reassure everyone on the progress. The patches are
  not yet ready for discussion. You can have a look if you want, but no need to
  do a review as I am still making changes.

I thought that I was clear. This is a WIP which I am sharing because you ask for
it but there will be some changes until I am happy with the result.

I will post it using the usual development process when I am fully happy with
it. Meanwhile, it is *not* ready for review. You are welcome to play with it,
but it is *not* open for discussion at the moment.

> E.g. the CAN_CTRLMODE_RESTRIC_OP should be named to CAN_CTRLMODE_RESTRICTED to
> meet the other configuration options.
> 
> The listen-only operation mode is not named CAN_CTRLMODE_LISTENONLY_OP but
> CAN_CTRLMODE_LISTENONLY ...

I named it like that because in ISO 11898-1:2024 it is "restricted operation
mode" not the "restricted mode". But I am fine to rename.

As I tried to stress above, this not being ready for review, I will not be
answering further comments. Sorry if I am disappointing you, but at the moment,
I want to focus on the debugging by myself (and there are a few bugs I am aware
of, if you expect something production ready, please do not use).


Yours sincerely,
Vincent Mailhol


