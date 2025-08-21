Return-Path: <linux-can+bounces-4289-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85016B2FF82
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3158B630FA
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45809285C8C;
	Thu, 21 Aug 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ+C/95u"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5227AC37
	for <linux-can@vger.kernel.org>; Thu, 21 Aug 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791942; cv=none; b=U70XOkZhBAhvEvNJ+ZClnCdn6h9hutoXfaoSeUTzdd5PxtdCyQv4iBoJ6O+v2Qq96Q8NLUUw6TdWS8RRQFNotQMxvZ97slC7E5ybuxj2DR9GKOCr0n9+otZRGyBmX1zxOPsF5cwylAXgq4iGf1xg5nbCyPWrFVGo9svG5ThXrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791942; c=relaxed/simple;
	bh=qSq69XCOLP2A3IWdWwZI0sMdyXAywn9dWwmpDid/mxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=U6r9Bck/Rw79oWa75utFrpzhljkt2knAEks+jtQbY/74BkNAb0KXoWlEre5LlwjzJBa2c+LSLGW8mh3QxgLxKcVBiNNYrcMDaHxXDuGW07mfM0yla3kHjKqtCRh7YCM+3KXaaLmhYB/EJx/jzul4z9GkoSivREipFcgTP9775MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ+C/95u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86DDC4CEEB;
	Thu, 21 Aug 2025 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791941;
	bh=qSq69XCOLP2A3IWdWwZI0sMdyXAywn9dWwmpDid/mxE=;
	h=Date:From:Subject:To:References:Cc:In-Reply-To:From;
	b=NZ+C/95uA3XiibMI9VIzT0izBQZ1Bj/zUVSZbeVIxdYdzWXhl6sn1MaO9MELH5yIg
	 P3CpbpD31W5Eze5VV7kEBhMT41NcqZDQdSBVQzifGIQniWKD/xOAHr33fRvLylMr3d
	 5iRsPMNXSFJ0tdLsaTFCj7mbmtCR11xVlDRG39EuwxPavVXt69JTTK6MKX1w5XOX4E
	 9PYUmrlwZ9LsrsFqKUI867kVlZFy1B4ttS0mHO7lhbfO+ldacG/O+9SaIxdmvIfHv+
	 bc91QOb3Tigwea2G/9GPPhRuxoGVPrXLito9XwecviJls1ZaGTZWm6esxlNvEDin/9
	 lsvWTdWKJIhoQ==
Message-ID: <6bcd1343-1e4e-42f7-87be-0e6527f9898f@kernel.org>
Date: Fri, 22 Aug 2025 00:58:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH] selftests: can: enable CONFIG_CAN_VCAN as a module
To: Davide Caratti <dcaratti@redhat.com>
References: <fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com>
Content-Language: en-US
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Felix Maurer
 <fmaurer@redhat.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can@vger.kernel.org
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thanks for the patch!

On 8/16/25 1:54 AM, Davide Caratti wrote:
> a proper kernel configuration for running kselftest can be obtained with:
> 
>  $ yes | make kselftest-merge
> 
> Build of 'vcan' driver is currently missing, while the other required knobs
> are already there because of net/link_netns.py [1]. Add a config file in
> selftests/net/can the store the minimum set of kconfig needed for CAN
> selftests.
> 
> [1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com
> 
> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  tools/testing/selftests/net/can/config | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 tools/testing/selftests/net/can/config
> 
> diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
> new file mode 100644
> index 000000000000..11a02b0a0c6a
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/config
> @@ -0,0 +1,5 @@
> +CONFIG_CAN=m
> +CONFIG_CAN_RAW=m
> +CONFIG_CAN_DEV=m
> +CONFIG_CAN_NETLINK=y
> +CONFIG_CAN_VCAN=m

Some of those config symbols are already present in the config file of the
parent directory:

  $ grep CAN tools/testing/selftests/net/config
  CONFIG_CAN=m
  CONFIG_CAN_DEV=m
  CONFIG_CAN_VXCAN=m

Maybe you can remove the now redundant config symbols from net/config and
consolidate everything under net/can/config?


Yours sincerely,
Vincent Mailhol

