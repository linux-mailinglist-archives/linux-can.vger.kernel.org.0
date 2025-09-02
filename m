Return-Path: <linux-can+bounces-4419-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D1B3F6D0
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E49179B53
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1D2E6137;
	Tue,  2 Sep 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umk442UJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A327F01E
	for <linux-can@vger.kernel.org>; Tue,  2 Sep 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798918; cv=none; b=TIbLPhFgqCmHn1/vYWc6wb5TwwJvAphbrELTPcDkawa+B5aSzir83u7tn4ZO4Ag+FCGCJFdprHJsbTBg8hKBuSRLfXkknaSX9EaP+gdJjzAFXW+fyPiBSDwPCwq0aikghlxdceln5s70iwNx4L/yzMzPHpSx+N5rkF+k/ZZUcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798918; c=relaxed/simple;
	bh=++KpgiFJGZZbKH2aud3MRkOn31wjTeu8pJia143GyEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qUrs4u+EkQis+r4Bm/DAbceTdPDbksNymcd2obEXrqqIcCnC0EL7A7vOLjWyL969So9BPwMX1HR6OUL3aXf053HsGKA1JHntk4D5eID6NNSkLvq6Ilgy0FlJNgqxHrr5MgZ1xllzDdZjiUuqcH7OCjum4bOWk7V7uEetviXeGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umk442UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D28C4CEED;
	Tue,  2 Sep 2025 07:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756798918;
	bh=++KpgiFJGZZbKH2aud3MRkOn31wjTeu8pJia143GyEA=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=umk442UJ4W7opnNKW/iikY1e4rLAUt/uRgMAalpmvdjY5alM1YmP0CinevF29pwrJ
	 mRGQahP/PlpOIvYN5v3lRiJ7vwzYDUDQ8F0S1Qygo9EIWOz9mVEQE0ACzUFZSmNa3x
	 R7X2AODXqKEb34kkAJj3tqAa+uO0wLfLTcHKGwNIeY/g+K+SxuHU5xLiEyHwj0VhBW
	 K5w1nikzyfaHUF7MYqRqJnTB4EFl6QQO7bDYRvvhwZiCrDL85P7daeqJuNcj9cnD4g
	 w+9x8b6Shfp7d0HLMtQsC6cy2hs5GkSr/Guo58WhzZx2uXEH89vq8HSvCnE2RK8sSW
	 6/m8vbK8miimg==
Message-ID: <9ccb3940-3432-47b2-a71c-5edb84f6bb0e@kernel.org>
Date: Tue, 2 Sep 2025 16:41:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: can: enable CONFIG_CAN_VCAN as a module
To: Davide Caratti <dcaratti@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <3424bff9cf34d66633ef410ba506f005a94e310e.1756742645.git.dcaratti@redhat.com>
Content-Language: en-US
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Felix Maurer <fmaurer@redhat.com>
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
> 
> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  tools/testing/selftests/net/can/config | 4 ++++
>  tools/testing/selftests/net/config     | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/net/can/config
> 
> diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
> new file mode 100644
> index 000000000000..0cb5598eb702
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/config
> @@ -0,0 +1,4 @@
> +CONFIG_CAN=m
> +CONFIG_CAN_DEV=m
> +CONFIG_CAN_VXCAN=m
> +CONFIG_CAN_VCAN=m

One more nitpick: can you also sort the line in alphabetic order?

  CONFIG_CAN=m
  CONFIG_CAN_DEV=m
  CONFIG_CAN_VCAN=m
  CONFIG_CAN_VXCAN=m

(VXCAN after VCAN)

> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index c24417d0047b..18bec89c77b9 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -120,9 +120,6 @@ CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
>  CONFIG_IPVLAN=m
> -CONFIG_CAN=m
> -CONFIG_CAN_DEV=m
> -CONFIG_CAN_VXCAN=m
>  CONFIG_NETKIT=y
>  CONFIG_NET_PKTGEN=m
>  CONFIG_IPV6_ILA=m

Yours sincerely,
Vincent Mailhol


