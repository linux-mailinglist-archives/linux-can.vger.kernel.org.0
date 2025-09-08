Return-Path: <linux-can+bounces-4528-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E295B4976E
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BDC201FCA
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFB1C07C4;
	Mon,  8 Sep 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHX8aaZu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06E11187
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353335; cv=none; b=XIViKF4qZBgtPANkB1dHtrLKSAKvDHkLdERKT2yP/dQO9aBamFfghoYzUVz0lJTgCHTAbdFI26w+JIRNJaGeak7uuUl9V9MnL0XZjn94pbDRDKbxUX4vxGr+boVWcTx6RkepT0lpD+hfeUUyMhep0s+hLpEBUiJYCN+XS58+HI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353335; c=relaxed/simple;
	bh=cmDjMsGmcydn3hGG0WomA86rZoUgbWUu3tCQXCV77o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA9G2s0eIrqVkqzNH5VZxsPKcujPrBa6bkmbiWEtPUD+p8VPTjG4hkfrfHY9ES11CTy72Z6OCKv6rn2wAygn8cm2CYFgmPIgy12h6ENg+vT2ARfcRMVf8tck61uuZ6GvVLFuaGHbF/nA47a3V5oQVTH0GPtr52BygdmJ1KYHO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHX8aaZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D172C4CEF1;
	Mon,  8 Sep 2025 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757353334;
	bh=cmDjMsGmcydn3hGG0WomA86rZoUgbWUu3tCQXCV77o0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lHX8aaZu8KMGoAhcyKGzh1xuunXh0RjO8ahdyLOGBZ4F64wDTFkyCl1xnhe+sNevD
	 lIBOITPSiM35BL7mpi5f+Pz4WYKOGOhhP3srPPmsjftOWQBlt4BJElmoNaLisnNzmE
	 4G7DAN3LNEQ63vIh3y5s5NvZafMtnsxOgJS0/7VXozbjGTjElSRf3GmxvgJc6XkL0i
	 MKLdjc+Z4cKXt3ekkh1Xfy9+hIU/+Ly3HuSY0rJku5IEiCqs5Z+KNi6Umlu7anqFJH
	 jGV/kuhu3TjIL98JlKkbe5mg9Tb78k5Gf5v8mRIvJPSO/X7WqAgQQAs1tJ22Aj9X/i
	 2B6D+9MzdgK5g==
Message-ID: <ac73acf8-7372-4ce9-9f89-3682c63fce86@kernel.org>
Date: Tue, 9 Sep 2025 02:42:13 +0900
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
 <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
 <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
 <cc56cf68-49d4-4c94-844c-ec413307dedf@kernel.org>
 <fc1dfbf6-33e1-47a1-943d-806f146c5be6@hartkopp.net>
 <891c738e-f807-46a7-8e03-4223969c9002@kernel.org>
 <2f9fdf70-856c-4b4b-ac69-5e22f4d9e014@hartkopp.net>
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
In-Reply-To: <2f9fdf70-856c-4b4b-ac69-5e22f4d9e014@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2025 at 01:55, Oliver Hartkopp wrote:

(...)

> I think the best way is to properly split up the FD/XL capabilities for CAN XL
> interfaces. Right now CAN FD is implicitly enabled on CAN XL interfaces when CAN
> XL is enabled.
> 
> I would tend to change the code in raw.c in a way that you have to switch on FD/
> XL explicitly. And then the problem would directly show up in write() and FD
> frames would not be silently dropped in can_dev_dropped_skb().

If you can tweak raw.c to achieve this, it can be a better solution. I am just
not sure how you are going to do that without breaking the UAPI. Looking forward
for your patch!


Yours sincerely,
Vincent Mailhol


