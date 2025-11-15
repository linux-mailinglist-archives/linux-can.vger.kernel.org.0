Return-Path: <linux-can+bounces-5404-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF81C603AF
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AED3D4E2764
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF627587E;
	Sat, 15 Nov 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjWuLWwC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF92264BD;
	Sat, 15 Nov 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763205474; cv=none; b=eXIwTnW9fBXJPcxbgZt81m0PRJ1X87p6acXNBpuEyBhYehLfiJwb9ImyIjzJ0WkuwcpiI51VCsOP2S3Noo9j8RCjEu8jmRshZX5JWBhdCgCDw+7WC5sZauBnPvRK7NTDDY68Ur99YGidtNNSpkcbFz7cIG9v0+O1C+g/hMUkidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763205474; c=relaxed/simple;
	bh=ZZo9gzrk2AF3euhumKKuVUuk8H8wnBaUGsPBF6xh5vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/x8D/lS1jwTodp8JGeKSXXaZsEQiVOTATP0D/XGZCitQ55KQlj/V9btNfPJgB/IDYdgFr8rp9dva5ZthElsR324c+wzfqOicqWALV3G0XWRhNvBX2+lIT5DKiea+Aq+6QPta52xPeLPi8LQQCPeTx7cV55h9fzjeW4JrGzW2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjWuLWwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C3C19421;
	Sat, 15 Nov 2025 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763205474;
	bh=ZZo9gzrk2AF3euhumKKuVUuk8H8wnBaUGsPBF6xh5vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjWuLWwCKwyZXEukfrK36KKGqWzZWxm6P3C1LZqrI3revPpCzylP5mrXVBUgukDzo
	 T6/NTy8mpQ24iJXmJ93fs985d+0Y4tt8J61zaFv6T2oUXSn9KSJljQBSnqH66pwLT5
	 EAGE82hapV6DMDp3C6L2GHxXeDYlxxx4nY4Rudi5TDGQxnBVo+sFx9WQ19ESylrIVS
	 /kqYOJoA8Ok/nanR3rQ0gAQLOTwy3xvfdspy5o+RH45lHlkwi5KOBgo0plgx5p9/Pu
	 LINqB0y6gu49FsnHaN2eihnp3TXUYEUkkFpjVWpzPxoDdnzhTSQbYawjW/tjs99bMh
	 eWY7qICH/Jk8g==
Message-ID: <0065ed0a-8442-4d6d-b132-789add82ebe9@kernel.org>
Date: Sat, 15 Nov 2025 12:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] can: calc_bittiming: add sample point calculation
 for PWM encoding
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
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
In-Reply-To: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2025 at 23:01, Vincent Mailhol wrote:
> I wrote this series in response to Oliver's feedback in [1]. I am
> sending this as an RFC based on top of [2] for the moment so that we
> can discuss this separately. The plan is to merge this to the CAN XL
> branch once we reach a consensus on this part.

I changed my mind. I will keep this as a separate series. v2 is ready locally, I
will share everything together once the next can-xl series is ready.


Yours sincerely,
Vincent Mailhol


