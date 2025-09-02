Return-Path: <linux-can+bounces-4418-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72389B3F4B3
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 07:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B11A853B9
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A52E1EE5;
	Tue,  2 Sep 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laUqgQHR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A092D593E
	for <linux-can@vger.kernel.org>; Tue,  2 Sep 2025 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791739; cv=none; b=ZUqbzr8OmBXir65P0AnKLhZmQ/VeqSJNqXWwaln5000/dLE7lOi2RfZyEslH9dVY7iAoGdf8Ve5/yfDLXaWz9itv2lS6d3MoDd56JrCOIM2dfZhgEDCSFnNT6KxQPHZcDRUl3I38vcepQURDjyrSEUrUUvUXyMOeTL3yraA0EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791739; c=relaxed/simple;
	bh=tC+CaFylWTJq114Fmi3wC8ndoOv6tk5hNTmSrVdLdEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pH5iukSCghVzvXKLz5gvvmF6+Iiq+SjG4F9s9AfBlBb3cZqVDF3/MSp6ghBdkd61HvkY69oJ0kMCfkNskaTMS03bfUUw4RgtIdUWXDloYfSLJXQF/zCyMYVtj0YlDZRvJQwTJuZQh0pCv/OPsymbXQnNzipNRU/RKvD6E6W8uP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laUqgQHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF86C4CEED;
	Tue,  2 Sep 2025 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756791738;
	bh=tC+CaFylWTJq114Fmi3wC8ndoOv6tk5hNTmSrVdLdEI=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=laUqgQHReKLeXX2a4N76tAmCw9vHdBUVArZZzd7m2y8i+PLGTJqIT1Y/tO+eUgrlC
	 FovJqGbD3PTbRm9B1J1Rq5zT3LNK1DL8fWMS1Sm/3cmv6JNd8sDmo3u3ByVTfw6i4h
	 AY+JKX3+YoNBqPqt80+BzmEiglkehmviZlz1w0RYU2PMTmN9t/9vYOm82xfglQSUID
	 6+l1gRy3EMBxrpKIYUmoE76y4cJopFzwTGCFvpxmcsHGMK56/mYeyJSSFKLQSiFnXQ
	 h8tzr/AwXeGN8ggdSmMLYS9q/U/76/7ps3eEUvphTSO0gMXPj2wSrxB3BG/9oNicda
	 FIbRBK7fZvcxA==
Message-ID: <dee9a121-966d-4a0b-978c-582cd3e4b031@kernel.org>
Date: Tue, 2 Sep 2025 14:42:16 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: can: enable CONFIG_CAN_VCAN as a module
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <3424bff9cf34d66633ef410ba506f005a94e310e.1756742645.git.dcaratti@redhat.com>
Content-Language: en-US
Cc: Davide Caratti <dcaratti@redhat.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Felix Maurer <fmaurer@redhat.com>
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
In-Reply-To: <3424bff9cf34d66633ef410ba506f005a94e310e.1756742645.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 at 01:07, Davide Caratti wrote:
> A proper kernel configuration for running kselftest can be obtained with:
> 
>  $ yes | make kselftest-merge
> 
> Build of 'vcan' driver is currently missing, while the other required knobs
> are already there because of net/link_netns.py [1]. Add a config file in
> selftests/net/can to store the minimum set of kconfig needed for CAN
> selftests. While at it, move existing CAN-related knobs from selftests/net
> to selftests/net/can.
> 
> [1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com
> 
> V2:
>  - move CAN-related knobs needed by [1] into selftests/net/can (thanks
>    Vincent Mailhol); remove enabling of CAN_RAW and CAN_NETLINK since
>    Kconfig already implies them

It is preferable to put the changelog after the --- cutter. There is no real
added value to keep the patch changelog in the git history. And people who
really wants to know the details will be able to access it using the thread link
that will be added when picking the patch.

> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Regardless of above nitpick:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


