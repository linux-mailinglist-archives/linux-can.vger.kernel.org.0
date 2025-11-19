Return-Path: <linux-can+bounces-5503-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E324C70A20
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37DA135380B
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9A366DD8;
	Wed, 19 Nov 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pqJoX4OA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lkvsMwVd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78E313523
	for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576250; cv=pass; b=BhHkigR55o6PvCKU3SJ3WzZLF7R28w2aETTFAzt5sT7nykxAWKAKL+ZO3xcPOScrmvIABrAjYZTvOvk5DYfAnO1QyR//zFXjExtczIkvzaaFvQe2s9Rcqx/FaqjoVe456iEulubPrZcZyRm2JPylkAOjYtxWNQpSPhPgQcG+2u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576250; c=relaxed/simple;
	bh=p6DZc8DM3xDqAdlSAVzbNegzIgSz6civCZCFQuuuF1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qVVZxf3niv9j04+Y4XED0+Os7oivoVdSu7f6WbIj1eNXmy+StHVd86AEr3u4IDWMbqiSz1Pos2ZMeyk5kk8kH5U2/8P+4OrtZr4BD/xo3pl58QgSgRKEMUIwY0u0sDFho4Z/aSzmOcmtQTyn7fI3QLMEWxxImFMUK3TlGi5IJdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pqJoX4OA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lkvsMwVd; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763576226; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VM4VCkGws72VAsqI/XCETjZkgJrtHSSr04eGYk9o2RZyj8QMTY5SRYHXBNoa1T8FOt
    ClcV1daGxiKSK3JJBUgqVsspEzKT7ohUEd/ww8UlngHwE6M9L2ira7fecFz+tGzMAgAy
    VAbWvSVjdOAs5mBvGhmCHRX1I1Y5xGk8kEKRey1zdF65eICSiziUdHX55Hsagcb37aAY
    T76qvY5KA781BYHiV3opvCf8dj0D7GXOjodCm5VW8y/t4m+uKCQgfTWENWqTar+xmU2W
    eSMAPiSFb+d9hkRmI5joani++hbgn25FIG/FijgSRvBGxQuhbOVuR1/pehdPqqjPFC8R
    s35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763576226;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uDHJgEGMIwSuOALirm8bld1EKOA2tQeCJrjLOgL0/jE=;
    b=jtpv9imgMV6+GIDv8WhUrJ2z5BndqQsNjgmvpTqih8lhUHK0TDSWpXlKjhCpShFK2t
    cvXTaPbuHPbJMEkKrgbuTe/yorZ5ysKgIOjRBR+BYHK+IU1q7t08jxdkfSAm7+ldFSzx
    NSmKeFYVhKFWBxMykjfR/UydljRrJronhXTbCr+sNaGAOWpWVX0Wqbz+U3N3QgHcrf6K
    lSpJTyJtKC2Skd5q1sAU/cU9U194Kkk7ZPIQwu50NFj/aj4/NBgpilYyG+NhcF40WQt2
    LSmksWNScr4pzpVtC1heV9BIqpAR5eKVThGGw4NOCfXt2gRUzvNsmIb3BNaLK7G9TN99
    j4Yg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763576226;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uDHJgEGMIwSuOALirm8bld1EKOA2tQeCJrjLOgL0/jE=;
    b=pqJoX4OA50bDVOS7O5bDu/DGYfbhMGrcVkHREG+t5nKtT07g5dr5NTSkfAEU5SQm7W
    hujhoWbJkqSp+FVIGLvSezr1ELbgUGb4wS3u5n2WGSBmeYFg4d1u5gcfg/69uR/gfCVz
    g8z/AAJzg8XlC+ggr92A76CYM24aZX71wHO1NELMOOxDzU4zxk46GMu4nOyZKEEBocdE
    97i/qhaxqm5JHehYYxwrtQYxmpUP2JgbYTRxzo/EbNI/np/XKxpDqaNi7zzDh1VQoMHB
    fm8lObq8QYSH/XFSN1cQh6WS4qfW+/Jyb9oEfSxz9Yi8xRt9isnNAzrzXAij3KARXe4D
    PfYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763576226;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uDHJgEGMIwSuOALirm8bld1EKOA2tQeCJrjLOgL0/jE=;
    b=lkvsMwVdOUnWODSFI3lWBnmPAlggN8rNUf3ySUhYosdVoHqG1R4RrnG2j9IAh49DtA
    NP9YT+Raa5ylvFKHFdCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AJIH62r5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 19 Nov 2025 19:17:06 +0100 (CET)
Message-ID: <cedee756-ae5b-456c-96b0-9263177a647a@hartkopp.net>
Date: Wed, 19 Nov 2025 19:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Marc/Vincent/Stéphane!

We are right before Linux 6.18-rc7 and I would like to have the CAN XL 
support ready for the 6.19 merge window.

Unfortunately the reaction time and feedback from Vincent is currently 
very intermittent. This is no criticism but risky for catching the 6.19 
merge window.

This v2 patch set is feature complete and tested.

Finalized discussions (code complete in v2 patch set and tested):
- make RESTRICTED a normal ctrlmode_supported option
- make TMS a normal ctrlmode_supported option
- omit CAN_CTRLMODE_XL_ERR_SIGNAL in netlink API

Open discussions / review results:
- not removing "const" in can_update_sample_point()
- have the ctrlmode names in ip feedback messages capitalized
- increase the resolution to two decimal places in can_calc_bittiming()
- can_calc_pwm() has no return value (kernel test robot report)

The latter are tiny fixes and beautifications that potentially can also 
be done after the merge window.

Therefore I would propose to mainline the current v2 patch set right now 
and see what we can improve until the merge window closes.

@Vincent: If you are currently busy I can offer to work on the open 
points for you. So it would just be a review-job for you and I would 
send a v3 patch set until Friday (latest).

Best regards,
Oliver

On 15.11.25 17:37, Oliver Hartkopp wrote:
> This series is based on Vincents CAN XL patches 2025-10-13 11:01
> 
> https://lore.kernel.org/linux-can/20251017-enchanted-quiet-civet-84dd47-mkl@pengutronix.de/T/#mdecc959e0ef7c16c64f35e9dd3d687954e15c8ac
> 
> For a better review here is the complete series of available patches with
> some changes, especially the error-signalling handling.
> 
> The changes to Vincents original patches are documented below:
> 
> Oliver Hartkopp (2):
>    can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
>    (replaces can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL flag patch)
>    can: raw: instantly reject unsupported CAN frames
>    (the adapted version using can_dev_in_xl_only_mode() helper)
> 
> Vincent Mailhol (13):
>    can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
>    (no change)
>    can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
>    (no change)
>    can: netlink: add CAN_CTRLMODE_RESTRICTED
>    (no change)
>    can: netlink: add initial CAN XL support
>    (remove the "bad device" warning for CAN_CTRLMODE_RESTRICTED)
>    can: netlink: add CAN_CTRLMODE_XL_TMS flag
>    (remove the requirement that TMS MUST be set. Use defaults: off)
>    can: bittiming: add PWM parameters
>    (no change)
>    can: bittiming: add PWM validation
>    (no change)
>    can: calc_bittiming: add PWM calculation
>    (no change)
>    can: netlink: add PWM netlink interface
>    (no change)
>    can: calc_bittiming: get rid of the incorrect "nominal" word
>    (no change)
>    can: calc_bittiming: add can_calc_sample_point_nrz()
>    (no change)
>    can: calc_bittiming: add can_calc_sample_point_pwm()
>    (no change)
>    can: add dummy_can driver
>    (remove CAN_CTRLMODE_XL_ERR_SIGNAL but print error-signalling state)
> 
>   drivers/net/can/Kconfig              |  17 ++
>   drivers/net/can/Makefile             |   1 +
>   drivers/net/can/dev/bittiming.c      |  63 ++++++
>   drivers/net/can/dev/calc_bittiming.c | 104 +++++++--
>   drivers/net/can/dev/dev.c            |  18 +-
>   drivers/net/can/dev/netlink.c        | 319 +++++++++++++++++++++++++--
>   drivers/net/can/dummy_can.c          | 284 ++++++++++++++++++++++++
>   include/linux/can/bittiming.h        |  81 ++++++-
>   include/linux/can/dev.h              |  68 ++++--
>   include/uapi/linux/can/netlink.h     |  34 +++
>   net/can/raw.c                        |  54 ++++-
>   11 files changed, 970 insertions(+), 73 deletions(-)
>   create mode 100644 drivers/net/can/dummy_can.c
> 


