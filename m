Return-Path: <linux-can+bounces-6065-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEECD08B79
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 11:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6113089CC0
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9C33A003;
	Fri,  9 Jan 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcsZV64S"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D3337B86;
	Fri,  9 Jan 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955848; cv=none; b=kmoMRgRuFoGAdbjXHpFUHOgtNuQc3hlPfCAL0jBcjT8mFSMDM6vEbMYhgbgmRxjZBpO1e+qVZZLFy2Ejsi5xtg5eHA0dYhs5LhVGFqsjRtgMfzFMZpAx1vav13K98c+qdN/vtAeaB/w0MoOaWx9CmhYXJv//r++o6pqgpzDL6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955848; c=relaxed/simple;
	bh=rXFRQfI992+9JEO4gIL3HRtq2VYV1hcEXouljOX9Ubs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krgFC8C/bqmOsRDwjnfLFqAMc5vpvTWlK9zDEcEbSxHXVx0ymsqmmzaA/EqT2h6HU06N48dbNHokpx1gD+R48IZ4ura6TKgZ2TO3hAVdlQLC/6pFBA3NHqd95rHJhPLIyZvOZ/a9iCLGTUBgLPq+JKPluSqeMR0wQu1Egd7kJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcsZV64S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C1CC19422;
	Fri,  9 Jan 2026 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767955848;
	bh=rXFRQfI992+9JEO4gIL3HRtq2VYV1hcEXouljOX9Ubs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WcsZV64S142yTC/3eTmT5osLDKewnzryrCl2jA/F+SVOksTjUJ13SM+hFsM9ktiC8
	 ukvZqvabRy8YS4fYH0cBJEpYsPBDM4rQYlUbGUfuc1gT6LqFSRqoQo2RvZ1fcmG967
	 9cskDgVUACtEo6Y+ysTzuEfnxr2jgeaPFAS+9iX41PNXGsSdsbqAIT+wIksAKjXUaD
	 WKr4GJv64ZK+2AanRF0UQBsGqdG4+VWsXDy3JZVu+VsBMCt/scwg8IVjmBdIOhHLuP
	 l47QJz9x0lEkqfvEH0jxOtMbUcjcTdKQ06Ica2z9P4iE4bpNZ6MXag+e4YK9qZHZ0I
	 NuS7SUh0f9kGw==
Message-ID: <25616e3d-9fd9-491e-9a93-fa48d3e7ba2c@kernel.org>
Date: Fri, 9 Jan 2026 11:50:42 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
 linux-can@vger.kernel.org, David Laight <david.laight.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Jiri Novak <jnovak@fel.cvut.cz>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
 <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
 <202601060153.21682.pisa@fel.cvut.cz>
 <c3dd8234-3a7e-4277-89cf-1f4ccb2c0317@kernel.org>
 <20260109-robust-clay-falcon-2f3ecb-mkl@pengutronix.de>
From: Vincent Mailhol <mailhol@kernel.org>
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
In-Reply-To: <20260109-robust-clay-falcon-2f3ecb-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2026 at 10:29, Marc Kleine-Budde wrote:
> On 06.01.2026 23:14:47, Vincent Mailhol wrote:
>>> thanks for pointing to Transmission Delay Compensation
>>> related code introduced in 5.16 kernel. I have noticed it
>>> in the past but not considered it yet and I think
>>> that we need minimal fixes to help users and
>>> allow change to propagate into stable series now.
> 
> How to proceed. Take this fix now an (hopefully) port to the mainline
> TDC framework later?

While I would definitely prefer to see the TDC framework implementation
rather than this quick fix, I will also not block it.

If you feel confident to continue with that patch, go ahead.

Yours sincerely,
Vincent Mailhol


