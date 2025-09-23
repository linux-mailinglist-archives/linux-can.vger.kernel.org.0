Return-Path: <linux-can+bounces-4908-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5AB97216
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 19:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25AC7A3AE1
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A032DEA6A;
	Tue, 23 Sep 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnDBeDjb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F082DEA64;
	Tue, 23 Sep 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650079; cv=none; b=IvPv6+8nwV5RwpxsGwBEHA8ZX3ysuiKHErTynSLMcuFlET+9HXkeIAyQg+i8KYOQwLEq2LJMQ1JUYJ/98Rypsj0qWiWFEW10gEqtdpMqQGmjV2/EDeiXwWtLQE1U2NeeaRMhgkm0bGGuPRskPpG5JBd2+B6gLO6PFrObdeCgrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650079; c=relaxed/simple;
	bh=rJ6aiQqxdMPsVP+OV1g5GsOOlkA6GjMmcOXKL/5YFO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzSSol/bFYjVVfo8ZVy7i1EBjab5tozyu0YVfe2UGJLFfncdmll8H3S52rRvan+tTY5hVOaHle95wDP7KSY4YR85UIZHS9bVAzQXeaEBfk9RV3FIqz/ZjZjDgmO65XQNTzEiWV5+PgI0aG9b/GIQeKj+JWdEl+xa6cJqu9DMWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnDBeDjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBB4C113D0;
	Tue, 23 Sep 2025 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758650079;
	bh=rJ6aiQqxdMPsVP+OV1g5GsOOlkA6GjMmcOXKL/5YFO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gnDBeDjb3Fgp+9OxsoeG84Q9GG5kPBG994eTfgLO/gAsH/WDgwWu8EcKDSDFcZUzA
	 3xiiAeqSHdlL0JBrVIgVNGYsZk0KuEqdt0zdCNQ02c76N+Qo6P/4sLwEoOLFGB9oiY
	 xxQdpyvbC5nNQ0VTbma0xP3rTgfH4zSk6xNJC0viSyG7GDcHnKYPB2VtBMayS8nlan
	 /cJpWLK+okM/Maibjz1DDqeKoYRYt6vq8I1JoyTXW3+gOvre26bOVgb8O5H8S6j/vX
	 jRVVWFBKJ24xBEfEOwcnjQ8UBpZ+vOIdbgmoJuCReIwgV/EBeCvn9c980O9G6iTdA8
	 XSby2asi6Ukwg==
Message-ID: <715c6b6d-5672-4ba4-99d1-04fcd1dbb81b@kernel.org>
Date: Wed, 24 Sep 2025 02:54:36 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] can: netlink: preparation before introduction of
 CAN XL step 3/3
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
 <13f98eed-b535-4360-a545-0a11dbc8aa12@kernel.org>
 <20250923-rose-shellfish-of-wealth-c8dee7@lemur>
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
In-Reply-To: <20250923-rose-shellfish-of-wealth-c8dee7@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2025 at 02:08, Konstantin Ryabitsev wrote:
> On Tue, Sep 23, 2025 at 03:02:49PM +0900, Vincent Mailhol wrote:
>>> base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
>>> change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d
>>> prerequisite-change-id: 20250915-can-fix-mtu-050a94b563a0:v2
>>> prerequisite-patch-id: 03836ed1e416f9ea221e149842cc075ac174dd3a
>>> prerequisite-patch-id: dac8f6d20f91cf996553905f08c629ca3e61d86f
> 
> ...
> 
>> So, when sending, I was based on Linus tree instead of net-next. I guess this is
>> why all those prerequisite-patch-id are showing up...
> 
> No, I think something else went wrong here. You did list
> prerequisite-change-id, but it's only a 4-patch series. I'm not sure where the
> other ones came from. Can you push your b4 branch somewhere where I can take a
> look at it?

Thanks for jumping in this thread and volunteering to investigate. This is kind!

I pushed the v3 in my tree under the branch:

  b4/misterious-prerequisite-patch-id

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/log/?h=b4/misterious-prerequisite-patch-id

I did a 'b4 send --reflect' to double-checked that it still has the issue.


Yours sincerely,
Vincent Mailhol


