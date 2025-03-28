Return-Path: <linux-can+bounces-3248-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11AA745F5
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C207A7185
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93E2116ED;
	Fri, 28 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YPxC2kG6"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556017BA3;
	Fri, 28 Mar 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152745; cv=none; b=mD/zLVjv1zusRF90oP/DBSZraTm+FdTzLlLwQV/QQ74Pd+LbqeKZ9FIQy3oBX4SW+xNoNtHEHOJNvmwcB2Eb8dyfjJU4cQ5P2msQyuhjsmgYgZF/foflf51bnUMzepGhmwLD0E6VtJw0tJdUPfmXZFx3aujlCGAN5lK5QODEzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152745; c=relaxed/simple;
	bh=FyltTlq/4Mc1qZD/jBsdwuXJujyxqVW6iqJAipCJgf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4AGPLuhlIs1XmEoON4cfs9B2uH1pksUuADv1n5s/5mEQSDnuflxd/XRIJ0TI4BLmuHF3NBMnm+DWeecx1YxC22V2j/0BqWyQ2lgV29zKHWzhYCqrhdhosuGUNU1B/3vG1g26y6Y0Rqul32JVA/SpDElq8yogxW2u/ZwIXfwIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YPxC2kG6; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y5dTtTZ1LtnYFy5dXt2I67; Fri, 28 Mar 2025 10:04:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743152667;
	bh=7wY3Ai0hAa7zNeXyqyoYank/PVlzbPVd5LomMXpc3VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YPxC2kG62WquzDllis83SsYfugTg1m2shhUh6OP6hNANXwQ3EgEYP8YUrZtUVghm1
	 Ca105YNZQ7inDbZLW/7F7QkK0ZTAtSio2ndBoqNN3r/imPj66tFWOyupjPO2p++rgN
	 0v5CPxq2sNA9pvdDWUeqTjnSn4x6tyV5gKi05/Nvs+1hMQ3dPv/31F+dXKL3W4Jjrk
	 mKhrhpD1XN0uovDmrNcPaXQQIvOwif9NAtPG0m8F9Mqv2d5qjky4k+aZf7k7L6tBsD
	 a+o6pSDXzRh4lbKk5zeSd6y54yc0ANQye26GwN/fjdLksFD6LoNhEI6kMvAB+VVDXy
	 o7t328gtU0qtQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 10:04:27 +0100
X-ME-IP: 124.33.176.97
Message-ID: <d282c214-20fb-407c-8af5-6b2b9298c877@wanadoo.fr>
Date: Fri, 28 Mar 2025 18:04:18 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/18] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC
 macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-5-biju.das.jz@bp.renesas.com>
 <7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr>
 <TYCPR01MB11332F02DC51A974450A676B486A02@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <TYCPR01MB11332F02DC51A974450A676B486A02@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2025 at 18:02, Biju Das wrote:
> Hi Vincent,
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 28 March 2025 08:54
>> Subject: Re: [PATCH v7 04/18] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>>
>> On 26/03/2025 at 21:19, Biju Das wrote:
>>> Drop the unused macro RCANFD_GAFLCFG_GETRNC.
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v6->v7:
>>>  * No change.
>>> v5->v6:
>>>  * Collected tag.
>>> v5:
>>>  * New patch
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c
>>> b/drivers/net/can/rcar/rcar_canfd.c
>>> index 2d9569fd0e0b..565a91c2ca83 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -94,10 +94,6 @@
>>>  	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
>>>  	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
>>>
>>> -#define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
>>> -	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
>>> -	 reg_gen4(gpriv, 0x1ff, 0xff))
>>> -
>>>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>>>  #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
>>>  #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
>>
>>
>> It seems to me that there are a ton of unused macro in this module:
>>
>> Why are you removing just RCANFD_GAFLCFG_GETRNC an not the others?
> 
> This macro got slipped while adding the fix [1],
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.14&id=1dba0a37644ed3022558165bbb5cb9bda540eaf7
> 
> Can I send separate patch just for dropping all unused macros listed below by adding dependency
> to this series?
> 
> Or 
> 
> You recommend v8, by updating this patch for removing all unused macros?

Your series is already quite long. I am totally OK if this is done
separately.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

(...)

Yours sincerely,
Vincent Mailhol


