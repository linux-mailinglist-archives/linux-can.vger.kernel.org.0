Return-Path: <linux-can+bounces-5329-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A7C49646
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 22:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F03A989F
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30B2DEA80;
	Mon, 10 Nov 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLSaBVAd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C12FB615
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809734; cv=none; b=uEAe31zSI6cBYpeiRM7S5hGUeZDpMtpEBMt29BDhtm/RJB66qhC2H2FfittoDrYrNvXHW2MHOUkJftexsDiz1jf2dra9TMUZHVeBTOErYovmVTESWJK0emEBNPirvwlOpr0uYb0Jx+NGYwIY5w8y3lFJoBJOrJYwtvot1i/oNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809734; c=relaxed/simple;
	bh=TjUk/iSpI+JlIT2AKZ97h63PVCpcy30d/iT/6PcXoEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tx6pBk2TW6l6R3sfezrWaUJbM7mc0Tg9jIAT1CN53Deyb77HbvJ5/7F2MSCwRiz4+gjKB7lNt6zjL0XgBcUxT/PhAzEopnC0bZ/hhFW202AppNl6LZf5tN6JCWBkBwLUFXSaXF9dL4sxzX1ITp8pRbES7zUUCa2bZz78EuoC5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLSaBVAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99130C2BC86;
	Mon, 10 Nov 2025 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762809734;
	bh=TjUk/iSpI+JlIT2AKZ97h63PVCpcy30d/iT/6PcXoEA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dLSaBVAdd/v4VCkmEM71WwYD3/mXUs5afTWTE8SQ13RnxX8AJOFzz0ZfkyvttZZaj
	 HLC4pxJ+7ptVpu7VTp37cpOdcEoNFtdheLQSoc9ALsnHfEHITtXltaa7Os6RlR94Rc
	 FjPIqS56C7s0BKg4pcIxf4/8XGN6kvcM49NklPCIwvpyfKZHMMU/6N0c1zCKl/bkOP
	 XFr7iIzwmg8hNUvgc3JeyzydJfxOGVi9qEuvdrYMtj+Trx9FZysCC/K0WYNxUregre
	 PtG4YH9iEG9R8ahH9ZUoaMJXVk0tBBNOEIOXg1HU+Ymdvp/7rD6kZi7plKzmjkLlO9
	 jRmS4iOmn2X+g==
Message-ID: <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
Date: Mon, 10 Nov 2025 22:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
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
In-Reply-To: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 09/11/2025 at 22:07, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> I've been playing with the PEAK CAN XL bitrate tool again and it gave me a new
> idea:
> 
> There were settings for different bitrates and the belonging/resulting flags for
> TMS and ES (error-signalling).
> 
> Staring at the options we have only three options for the CAN XL support aka "xl
> on":
> 
> 1. Providing CC/FD/XL bitrates => ES on, TMS off (mixed-mode)
> 
> 2. Providing only CC/XL bitrates => ES off, TMS off (CANXL-only)
> 
> 3. Providing only CC/XL bitrates => ES off, TMS on (CANXL-only)

Why isn't

  4. Providing only CC/XL bitrates => ES on, TMS off

a valid option?

> Therefore we only need "tms" as an additional option when xl is on.
> 
> The error signalling "on" automatically results from the availability of "fd on"
> and the FD bitrate.
> 
> Examples:
> 
> 1. Providing CC/FD/XL bitrates => ES on, TMS off
> 
> ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on xbitrate
> 4000000
> 
> 2. Providing only CC/XL bitrates => ES off, TMS off
> 
> ip link set can0 type can bitrate 500000 xl on xbitrate 4000000
> 
> 3. Providing only CC/XL bitrates => ES off, TMS on
> 
> ip link set can0 type can bitrate 500000 xl on xbitrate 10000000 tms on
> 
> That's simple and provides only the needed switches, which makes
> CAN_CTRLMODE_XL_ERR_SIGNAL obsolete in the netlink API.
> 
> What do you think about this approach?

What really bothers me here is that the ISO standard explicitly state that error
signaling is a configurable option. Making this an implicit option would result
in a somehow non-compliant implementation.

I appreciate that for most of the use cases the error signaling can be inferred
from the other values, and this is what I tried to implement (c.f. the table of
default values which I put in my patch).

But I want to leave room so that people who wants to push the standard to its
limits can.

I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs greater
than 8 in production code? Hell no! But I still want the implementation to give
me this option so that I can do my weird tests.


Yours sincerely,
Vincent Mailhol


