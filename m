Return-Path: <linux-can+bounces-4478-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC0B4377C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9D544F03
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151E2E88A6;
	Thu,  4 Sep 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDP4Wvyr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBD2E6CA2;
	Thu,  4 Sep 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979297; cv=none; b=l2e/hHVw7NbwVVA8bvJveDKJ6yOh9MRzzJlUCwUUO6BOksJIQD1nbt7h9quSYPzodDEAmWU/h21w1r8on0+Yz3v7k2VO0dO9e0OShx5EPD0UyF4Pcca/WM5kFC7JFR47T1hhrVwl033VuDMM5/VTCcWxFAluJS60Y5QW0TyYPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979297; c=relaxed/simple;
	bh=eSK9XpQ23zppfzTJkuW3CQJXuqNrz1bU7qRgZXGB6tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+/WAfQhH0J3G4QD9DdM6uvNWsihHbt1IjxfDcn8LKAtFfEM707FeBdWzw+sya0KkMLgsX1KibBt62lP0+TC+8pfpfbRg7Z00N4gRiTLcWRMU7dIVH7EhMYTiFuH+l/aumShHjYstkXjL/mJCyFJhnSJuFP0U2L1Ns05YrInOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDP4Wvyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC20BC4CEF0;
	Thu,  4 Sep 2025 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756979294;
	bh=eSK9XpQ23zppfzTJkuW3CQJXuqNrz1bU7qRgZXGB6tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rDP4WvyryzO4sa/Jyu5jua8sQDsuV+qInwPTVj6okz3LCzBF0dEmdIU5msYpvRp/O
	 1ItTTQrhEzEHsVjYizYLG1BJrmNtTRj/0yGK6mNVwL37e4DnzzJvv0ilif5AgGbPBJ
	 B+M9BRtRlX31AnHpEZrhpmd3mGBMH2afIkuP5MLi5A+X9OlSMLc1KGyd0wcMaeFevp
	 70KuGyTgINlFo5RmGDHWa4maYSHLNnTimpH1shcGHe0trz+qj6CpsupX29e7Oumr4o
	 0yF90bZ0YSbEVFx8bj2H7ulmnEAOTeEL42ZWRSBsRK2ScG/+cWUERKY5LnCwKNN3H7
	 9sveRObNMb2sQ==
Message-ID: <79452f68-c231-4bf2-a4ea-e3dce9b78e2e@kernel.org>
Date: Thu, 4 Sep 2025 18:48:12 +0900
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
In-Reply-To: <b1bf6cc5-f972-4163-8619-e04b887e2d32@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 at 15:51, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 03.09.25 10:50, Vincent Mailhol wrote:
>> The comment in can_validate() is just paraphrasing the code. When
>> adding CAN XL, updating this comment would add some overhead work for
>> no clear benefit.
> 
> I generally see that the code introduced by yourself has nearly no comments.

I tend to disagree. While it is true that I added no C-style comment blocks, I
added a ton of error messages which I would argue are documentation.

For example, this code:

	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
	 * must be set and vice-versa
	 */
	if ((tdc_auto || tdc_manual) != !!data_tdc)
		return -EOPNOTSUPP;

was transformed into:

	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
	 * must be set and vice-versa
	 */
	if ((tdc_auto || tdc_manual) && !data_tdc) {
		NL_SET_ERR_MSG(extack, "TDC parameters are missing");
		return -EOPNOTSUPP;
	}
	if (!(tdc_auto || tdc_manual) && data_tdc) {
		NL_SET_ERR_MSG(extack, "TDC mode (auto or manual) is missing");
		return -EOPNOTSUPP;
	}

Which I think is a huge improvement on the documentation. And this has real
value because the user do not have to look at the source code anymore to
understand why an

  ip link set can ...

returned an error.

> E.g. if you look at the [PATCH 12/21] can: netlink: add
> can_ctrlmode_changelink() the comments introduced by myself document the
> different steps as we had problems with the complexity there and it was hard to
> review either.

Those comments are still here.

> I would like to motivate you to generally add more comments.
This is a refactoring series. I kept all existing comments except of one and
then added a more comments in the form of error message. I am not adding code,
just moving it around, so I do not really get why I should be adding even more
comments to the existing code.

> When people (like me) look into that code that they haven't written themselves
> and there is not even a hint of "what's the idea of what we are doing here" then
> the code is hard to follow and to review.

Is this an issue in my code refactoring or an issue with the existing code?

> We definitely don't need a full blown documentation on top of each function. But
> I like this comment you want to remove here and I would like to have more of it,
> so that people get an impression what they will see in the following code.


Yours sincerely,
Vincent Mailhol


