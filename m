Return-Path: <linux-can+bounces-5311-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCAC2FBE0
	for <lists+linux-can@lfdr.de>; Tue, 04 Nov 2025 08:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D7B4E6FF3
	for <lists+linux-can@lfdr.de>; Tue,  4 Nov 2025 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCD3101B5;
	Tue,  4 Nov 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MwTivhKL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4430FF2F;
	Tue,  4 Nov 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243182; cv=pass; b=PegAfJcnc9FFgfQTxG5qnpHTF2NaNRFa8WQhYkJwqbfD2MpAPoGfl7L6of9HEfhEiLjfkOu5QRpMUh3pjgGO+1U76NY0hZvjA4B6PYFTuLRucZ5XO43FdufnmcvkvhFXmMl4cEgqe7M7DdwBgi9DVFlCoGO5WptNzsXY/X8MK2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243182; c=relaxed/simple;
	bh=jHMHfRzvje1niRGcxn/V6XKwhietog/5hqFtffGjMog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okUozjzQ5PTH6HMswUTR+DYSpEvKTlKyqXUE17uSLhG/ZVEGcELhKeaGbcVWotg4BrOlNN7XdXct3kZ41t/batFV869Hr7XrDr174/73PzU7/85jYnA9JgNx1gnjz7fGJV2HcbtRlq0B1t77WNITjVA26VhleZM7Z2sLDmT+Bu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MwTivhKL; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762243176; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K3oqZOvlkvsaeRKUI4HpaHlgyZK9lZSNQ+gJXrzUg5/8jDUuniGyXj83aeUz22gfK/
    9x4uMISA7mvW+HwoVs8nhoVrH4cwTUOp/82+sJqqrI8Dz5q9lK0wABbt6/tOhQMz6DRX
    HiVcTTqiHIswPK9ySQNvqoSv0cS87I2/dzc3MDGTFrPl1oDHf/12jPIPfyaUjvnj52xT
    lzJUEUZEhmu1BrgYoLfir7YDX60WeBHq8mZw9iyy+bjYU9k09IhukzQ2rMJEKXtav0Ov
    JBLc0g3XjRI/gRzcZxX4d4jDJvNuhMBTnnbbfcUgYCqzpmlXheYZ595r/OT7G3o1fQDy
    jKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762243176;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3SEhGJcm3+ZhNL2YLTbslWeZfp8/PHKFMPTQUZcvMGA=;
    b=FxsbmZRn6HIDd8mJSxxzE1mE+z/VLlbKMxh/O5u9ymwTSJUFiHXL6KoQz7sJ4rMGbH
    Uee6ql8uxxUmoXgxWDTXbJ5vomwNj9HUsGeLy8fi8E3YJ8Nr2+RMxXVYG5/N+0E4CSwB
    uZrTaRzoR931dXtm2YDY4xcHS9pWnbIex2Gu1xWt1IcYuCUVLmeKeOfM2Oi7RsBAtXFL
    oG01A9JwAHIOjwBnf2vTlpwTYALEdlfT6hGwxXCYL4lTLcnclNYPLX+Z3coHFV989gn9
    8rO5h6ALYcjYQ3XIpcYOXmV9frR61dSFplz/s1YFDhiOcRBhO7r5OoUWa0alU9xtC2Mv
    l3ZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762243176;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3SEhGJcm3+ZhNL2YLTbslWeZfp8/PHKFMPTQUZcvMGA=;
    b=MwTivhKL3tR15KJt+JaEh41MxMTnatwDAA8rZnwj0cDMRVoVRjsLzWlL+pgwWI469q
    OkmaSnZbiGBY5Jkg7nW+fsnr7AMbF8Xcox/G94jWODrBSxXALwA2M/oQSAFfr4QSrVjp
    LphIBsbVfovJFRFTdtcElhLjb9DXxkG/yZKvEcbIwqrgx6DWlZVmwnBL7u/9jBeV2L29
    yYIYV/RRPAeC2TucE2grtb14XkaFXVU7u/KrZ8GNMiHIR/As67iFQXEgafeEczMe7UDL
    g0ojA34tZOxefQE/OcaZahJcQOCOVmOkXwQpPM8IDYUP8Ul6i3GhcnJnAOgkqNKQtcft
    9/VQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A47xa79n
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Nov 2025 08:59:36 +0100 (CET)
Message-ID: <eb78ad91-72ff-4094-a1cd-e63a0eb7b980@hartkopp.net>
Date: Tue, 4 Nov 2025 08:59:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] can: calc_bittiming: add sample point calculation
 for PWM encoding
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02.11.25 23:01, Vincent Mailhol wrote:
> I wrote this series in response to Oliver's feedback in [1]. I am
> sending this as an RFC based on top of [2] for the moment so that we
> can discuss this separately. The plan is to merge this to the CAN XL
> branch once we reach a consensus on this part.
> 
> Patch #1 and #2 are refactors, patch #3 introduces a dedicated
> function for the PWM sample point calculation.
> 
> [1] https://lore.kernel.org/linux-can/743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net/
> 
> [2] [PATCH v2 00/10] can: netlink: add CAN XL
> Link: https://lore.kernel.org/linux-can/20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org/
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
> Vincent Mailhol (3):
>        can: calc_bittiming: get rid of the incorrect "nominal" word
>        can: calc_bittiming: add can_calc_sample_point_nrz()
>        can: calc_bittiming: add can_calc_sample_point_pwm()
> 
>   drivers/net/can/dev/calc_bittiming.c | 68 ++++++++++++++++++++++++------------
>   1 file changed, 45 insertions(+), 23 deletions(-)
> ---
> base-commit: ffee675aceb9f44b0502a8bec912abb0c4f4af62
> change-id: 20251102-pwm_sample_point-8823cb3cd459
> prerequisite-change-id: 20241229-canxl-netlink-bc640af10673:v2
> prerequisite-patch-id: 6b3294205bd76b38257516c63b7001ab242c9b62
> prerequisite-patch-id: 56431d12edcc0f325cf5204bb6868742c462c0ed
> prerequisite-patch-id: 1547fd7ea8f1937f0491cfc0996b09890f850991
> prerequisite-patch-id: 1dae270b0454352e46b927f71d1b47ff2bf7a49e
> prerequisite-patch-id: e4d43de873dfdefc023a0b86e397b37ea2b9e9a3
> prerequisite-patch-id: 4f3db477ff411effe70075c59ae6eac04fc65600
> prerequisite-patch-id: 148dbfce9d3bb09537087ee93e60bb7819bdadee
> prerequisite-patch-id: 7996539e26d449e8db260425c7287b4dce8cdf35
> prerequisite-patch-id: 42215044df6a63fff07c7a7d771d7dc375cc8b0e
> prerequisite-patch-id: 640ebf8ac8a1d114dcb91e6c05b9414bd09416fc
> prerequisite-patch-id: 84ee5e4f937f8e4cd97833d601affea78fe55914
> 
> Best regards,


