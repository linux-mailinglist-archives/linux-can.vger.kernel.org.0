Return-Path: <linux-can+bounces-5936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C46CDDB43
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B68E3010292
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042930BF79;
	Thu, 25 Dec 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5ku14Pg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558E2475CE;
	Thu, 25 Dec 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766661040; cv=none; b=pDZoKbISJihQC3UIMwkzfTP1zSi1pTPK7cyvbETFEGewQmNSNhLI4SaWdJbPn/uSy3LTCIF5Nso5U2oxE8c+wUzS58ju/Tgb6CHMBZZtSPT5BWoKfn4O6eXZVvE6TDbCY/nBSnJP6x1haO1/CsLr1gpeuYCCC7+GmUDheYyAkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766661040; c=relaxed/simple;
	bh=3nXYsUiJYLTzwx+B3iECbz5RL4Hc6kZkm0Op7vNEvAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nezcvp31rBnPMf5mPO7F6mVVn3pmbKQ+5Mq5mE2aWewkMZy/ynWT7TvHRz/abTX2/Auvq5dXLL3Qe3WJ8OlnRzeIPbullqSWrMyqOghybSkoyJKRLhhvLnDP3o4hHXUN3n0ZM+Gsy3AKRjurGXYgMJ5MBwMJL0eTsoNz2ynzA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5ku14Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900E1C4CEF1;
	Thu, 25 Dec 2025 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766661040;
	bh=3nXYsUiJYLTzwx+B3iECbz5RL4Hc6kZkm0Op7vNEvAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I5ku14PgzPmL2DDed3oLe9OwjUq9jtZqQ/G+04na1w5CwCF4/vCa9YUq8oYxqxuZK
	 rgwssg+L8qLyWpGuXYW3u2BKPDreAhZBCcCtdsDN0x7Le3ZF/JyPI5PGcTx5AhsN+C
	 dlyVCjmjMQ7tT0qnT2Tiy2WSnYsqfwhOD4AnjrH286sFqpR7ZL2qJ0P1GrwmZwXcKT
	 yTRqsX8Xc3AZqB4UesxSWK/opL54KF4q96AISNDsG8v5sPGfs+TZgceU2EIu8pKldf
	 +to2ASigC9payYOZBXADtoAvV3hdZ7eES38AclOUJbCnCVOpv7KDMA9hZausITAoTy
	 XUUb34DGh9RLg==
Message-ID: <10c6df0b-e438-4533-989b-c4a169f479b3@kernel.org>
Date: Thu, 25 Dec 2025 12:10:35 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] can: dummy_can: add CAN termination support
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkl@pengutronix.de, socketcan@hartkopp.net
References: <a85b8659-d4c8-443b-abb1-ae557a2a9896@kernel.org>
 <20251225072857.53085-1-rakuram.e96@gmail.com>
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
In-Reply-To: <20251225072857.53085-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/12/2025 at 08:28, Rakuram Eswaran wrote:
> Hi Vincent, 
> 
> Thank you for the review and the detailed feedback.

(...)

> I will address these points and send an updated version. Is it okay to send
> the next version without the RFC tag?

Of course. There is no need to ask for permission here. Just send drop
the RFC tag when *you* feel it is ready.

Yours sincerely,
Vincent Mailhol

