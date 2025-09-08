Return-Path: <linux-can+bounces-4504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB75B48319
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 06:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A4177332
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1EC21B19D;
	Mon,  8 Sep 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/909U4r"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3921B199
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304476; cv=none; b=URcLtMUIgxHVjN5XXnrcc6an1msYhuCOMybignZzX1aZCDuJWHbkwBiI2zQV1XsyMffFGwfbdj4W8w+UKeohVK+n8xmeSDwR9qS1Ee1Pcf1mOdSLfYthWP/BIvZD0IQFQ8uTLs3H72ORcsES43tUH5mBBF040+wmeBhJbvNbk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304476; c=relaxed/simple;
	bh=VQzDLEcNyjCMjre+Mil+rRn1B4xNwJupXeWv7nbgh/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+yEvQ3kM3NkrIzVSpFqsY3dsHsR1KgX0XobQXden+DhmafaH9oYmesxP3l1ilssrRUs/O+CvG3xvqfmLQ3reVU05nENASeh94wG+ykjgINTy2udZ0fIU0bFBJD1xRFs4oAZpCgLsgoJ8eXS9NKrjcymBdRZVN0/5dVX1Q4272s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/909U4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D0CC4CEF5;
	Mon,  8 Sep 2025 04:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757304474;
	bh=VQzDLEcNyjCMjre+Mil+rRn1B4xNwJupXeWv7nbgh/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m/909U4roaaOR0qCjJCV1VkSYQg0XOcLZPNTWS2fpsLPMZN8fxuXBS4JAFZ3ho7Xh
	 c2ljidN5WtmhM8sjGHLdFFOkCaibTQWYHZJNmbixVnqsop1nAFnbyZCKDPhIwfLgFY
	 FTMQAjzr70jQRuN8Al7xkE1c3a2eCl0zjqPO6ZmG+kOa2/QPVm1VQNzTz2yEfR5Rpl
	 kQlCaZYZ5WtM6zAm1RMZyWl1B6ZCCXASNZuJhte/EJ+v2sexV3014PHrX1dAOnCqQv
	 1RMQkAfDPUSUWJ9r4vVJjWEgAEBH/7RbA5vv+6hcuhTt1qaQzxM2Ns5NNkSIl0oZn7
	 Lc3xxgSETyI6w==
Message-ID: <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
Date: Mon, 8 Sep 2025 13:07:52 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20250907080504.598419-2-mailhol@kernel.org>
 <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
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
In-Reply-To: <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 at 04:03, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> can_dev_dropped_skb() is not what you are looking for.
> 
> Whether a CAN frame fits to the CAN device is checked in raw_check_txframe() here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/
> raw.c#n884
> 
> Or do I miss anything?

My point is not if it fits or not. Of course, if CAN XL is activated, CAN FD
frames would fit.

My point is that activating CAN XL should not imply that CAN FD is also
activated. Having CAN FD off and CAN XL on is a valid configuration.

Let me take an example, imagine that I configure my device with CAN FD off and
CAN XL on, for example:

  ip link set can0 up type can bitrate 500000 \
     fd off \
     xl on xbitrate 10000000 tms on

Where is the check that, with this configuration, the device is not CAN FD
capable and that the FD frames should be dropped? When I try this under my dummy
driver, the FD frames pass the raw_check_txframe() check, reach the driver's
xmit function and pass the can_dev_dropped_skb() checks. And that is the problem.

So, yes, the frame "fits" in above configuration and no buffer overflows nor any
other security problems occurred. But CAN FD is off so the frame should have
been discarded at some point.

The same issue goes for probing. How do you detect if an interface is CAN FD
capable? By checking that its MTU is at least CANFD_MTU? For example like this
in cangen?

  https://github.com/linux-can/can-utils/blob/master/cangen.c#L802-L805

If I do this check, it would wrongly detect that my interface is CAN FD capable
when in fact, it is turned off in the configuration. So, under my previous
example, cangen is also fooled into believing that it can send CAN FD frames
when in reality the option is turned off.

So, these are my point:

  - how do you configure a vcan so that CAN FD is off and CAN XL is on?
  - when CAN FD is off and CAN XL is on, how do you drop CAN FD frames in the
    kernel TX path ?
  - in the userland, how do you probe that an interface is CAN FD capable or
    not?

Does this clarify the problem?


Yours sincerely,
Vincent Mailhol


