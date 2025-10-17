Return-Path: <linux-can+bounces-5228-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7776BEAB98
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00AC65C4CB1
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11A2BF3F4;
	Fri, 17 Oct 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMKj8jxI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9A2BF3CC;
	Fri, 17 Oct 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718034; cv=none; b=RU/YgnsaZMmZwDT4jhIULpP4wvBJNuWkCMtUu9mX9uE0PNCaxL0ubCrmr4sOSrJUCteUA8Mm2gwc1biH4eWUgYA3Z5+7W84iueQ5QuXmwpUHFOgKbJTffhT0hirq17gqwtzrSpHEQeGcJxAG+U5SFRNHHXXwdRes64rcrPATcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718034; c=relaxed/simple;
	bh=8ls92eAd8Iogk1kemaZDvIwoOj3U7H92VFc/e+rbz48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byq7Tyv6P+vN9QZYIwkaIJTkGI8DuhyH/mty9fBoQ7rEtkOGzUH6blupYCLGxDsQkezEf86H2H15LGyQwMrZA+2/3+ytvomgF2pJvDQZwrHGE4gcEpN97sb9evrtLwxPYjIjBSgfD0wrInTSOqjib86Z0J1mzje+06l1wVHKoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMKj8jxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB588C4CEE7;
	Fri, 17 Oct 2025 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718034;
	bh=8ls92eAd8Iogk1kemaZDvIwoOj3U7H92VFc/e+rbz48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eMKj8jxIsLCVzTnS8eq8ZgoiiLPsnleb6W8L9yENpjWFv5kr3ZIdVsFWG7g2qHuUR
	 cWOQIYi9sM2grONOFHC6plZ+eHKqiz/ptmbXAvh2osa0GrsJ2TnsB5oTUwm7OUvM7/
	 lLC3FBxPwnPHqk9GWHuBmg2LicrV67DyzHcITsDm9CfZYfypWJxHisXsnCCp4zZprr
	 pTusNBbQzYFNGWkgv6IAjvV3lPP7zwZBfKJE0zzfgM782Fu2ALXhxIEukyc+yUGAIm
	 QwIHcLItvkMO+E2d1c1Y8PchEjR3GhjWyfPhluUi+AkzEoK5k9R+ZAx0bslWm6aTy9
	 YtVIe4/nxRp5A==
Message-ID: <913f6723-a8be-4bce-9a57-0b5c7f2348ef@kernel.org>
Date: Sat, 18 Oct 2025 01:20:31 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
 <a729eeda-22d8-4f3e-bb6b-0cd2f3a06d2a@kernel.org>
 <20251017-spirited-ruby-carp-5d7fe9-mkl@pengutronix.de>
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
In-Reply-To: <20251017-spirited-ruby-carp-5d7fe9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2025 at 01:02, Marc Kleine-Budde wrote:
> On 18.10.2025 00:40:22, Vincent Mailhol wrote:
>> On 17/10/2025 at 22:53, Marc Kleine-Budde wrote:
>>> On 13.10.2025 20:01:22, Vincent Mailhol wrote:
>>>> Following all the refactoring on the CAN netlink done in series [1],
>>>> [2] and [3], this is now time to finally introduce the CAN XL netlink
>>>> interface.
>>>>
>>>> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
>>>> CAN XL also reuses the entirety of CAN FD features, and, on top of
>>>> that, adds new features which are specific to CAN XL.
>>>>
>>>> Patch #1 adds a check in can_dev_dropped_skb() to drop CAN FD frames
>>>> when CAN FD is turned off.
>>>>
>>>> Patch #2 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
>>>> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
>>>> control mode is not specific to CAN XL. The nuance is that because
>>>> this restricted mode was only added in ISO 11898-1:2024, it is made
>>>> mandatory for CAN XL devices but optional for other protocols. This is
>>>> why this patch is added as a preparation before introducing the core
>>>> CAN XL logic.
>>>
>>> What about merging patches 1+2 now?
>>
>> If patch 1 had to be squashed,
> 
> Sorry - I was offering you to take patches 1+2 into can-next-testing
> now.

Ah! This makes more sense. Sorry for misreading you.

Yes, you can pick those two. But could you just push your
can-next-testing branch to git.kernel.org after picking those? This
way, I can rebase my series on top of it instead of dealing with some
complex dependencies.

 
Yours sincerely,
Vincent Mailhol

