Return-Path: <linux-can+bounces-4498-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37824B45C1F
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411F51BC520B
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5231B833;
	Fri,  5 Sep 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOKuUiKS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D431B81F;
	Fri,  5 Sep 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085138; cv=none; b=fKaRFluSF2nmOVAGQe2jtdQ7m2eRRTw1hyrVU8VrtvRnW/2Jx/hKVON8EOqbDcHb9QwOn13QmSPpUlys812AiB1WDAS7bLNzAJJfbZ0QZ0OJfLMFxSKjpbs4SGqgp1BPm2GSwkbsVd2SZeWJ84g7gY+K7OL857hAipFz+dqtgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085138; c=relaxed/simple;
	bh=GqWmfiP16k/SjEKn56UrkAlZm2tla0SwMryFGU5QCEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hP0V0f9rHgravAreGOoSkeDeOV5tAGsJm1Tw6BvOaO08nCefkPtAlVFPuBjPrLQaTCGuIiC8HU694ytlK+88GJYv1lHJ3LsEzCIGPHIm+InyHmf7H2FH1PrfWefmVMI9f+tp6/wUS2ks9rWmYrk4MQ2FOnL//ZgvKflWlLD+k+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOKuUiKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4695FC4CEFA;
	Fri,  5 Sep 2025 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085136;
	bh=GqWmfiP16k/SjEKn56UrkAlZm2tla0SwMryFGU5QCEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rOKuUiKS4wEKL970qs6ZsqxCbHLXUePx88xJxvBNTYN383sl3tGk4xmXWpA2WveM2
	 DA6+lgqzbwHDBBJqe6OW5X+ofknc29pDE+TLOQ2s7C63okiPEkrQql1SyYJ0PAZBVA
	 U58Cq02kg/RNEASYqzaf71Z5mpuMzypgqhRfYsE6Z/6SlvFWKgmopipwx3uuh/6INn
	 Lunacs6wcDzbW6sbbzL2O3GSqEzoVYTwfn+NQFrgxmYOYaMq9eZc2WuSGfa285ZGv+
	 ZYvfe1JjwdSlN9vc62cim5QJLy88TsdDAlYt8vu4VuMearqzPoOQKTH7wlvaR4RVNW
	 hQHfJ9x5QxhTg==
Message-ID: <59bc3e3b-bc96-4125-8e4d-4dbe92f8b2fc@kernel.org>
Date: Sat, 6 Sep 2025 00:12:14 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] can: netlink: remove comment in can_validate()
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <20250903-canxl-netlink-prep-v1-7-904bd6037cd9@kernel.org>
 <b1bf6cc5-f972-4163-8619-e04b887e2d32@hartkopp.net>
 <79452f68-c231-4bf2-a4ea-e3dce9b78e2e@kernel.org>
 <a4c0fade-52b6-4077-8a6a-fce6f2d62cd2@hartkopp.net>
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
In-Reply-To: <a4c0fade-52b6-4077-8a6a-fce6f2d62cd2@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 at 19:55, Oliver Hartkopp wrote:

(..)

> No need to defend yourself with specific references or even feel personally
> attacked.

Thanks. I was not sure how to read your previous message.

> My overall feeling is that you spend an excellent effort in commit messages but
> this information is then omitted in code comments.
> 
> As I've already written "I would like to motivate you to generally add more
> comments.". And this can also happen when refactoring things where new functions
> are created which reduces the context to the original code section.

My current mind set is that I want to do more ironing on the upcoming XL
patches. Because I do the documentation last once everything is working well,
this is still on my TODO list.

And when this is done, there is also

  Documentation/networking/can.rst

which need an update. At the moment, I am rather happy by just keeping the
existing documentation in this refactor series and want to put the extra effort
on the new stuff. Thinking of the upcoming work and of my current bandwidth, I
am really not in the mood into injecting more time in the refactor.

That said, on a second thought, I finally decided to keep the comment which I
previously wanted to remove. I will just move it from can_validate() to
can_validate_databittiming() in patch 06/21 "can: netlink: add
can_validate_databittiming()".


Yours sincerely,
Vincent Mailhol


