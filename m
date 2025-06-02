Return-Path: <linux-can+bounces-3762-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE5ACB4A3
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D824A1109
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF0222571;
	Mon,  2 Jun 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I57TAqes"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A61CAA7D;
	Mon,  2 Jun 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875095; cv=none; b=hmQj28gS78HJQ2uGihtF4XaPFn4NwJOOydUNzmeNGVzEUNjJv/aJjttVAFaJOAI3bQ2+Dhd5TbwCTJP9M/fkyMjLCY9UpqNktilSMxnzxklsaiAOMvWqOxpe5YyIXpL8YnC/7sp34BRdK6SkwuShUokzqngwYRAQ3gWWZVeWK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875095; c=relaxed/simple;
	bh=YWph8DqEtl3QRx+BBfajE6GttVswr8QwnNU45whQdhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHj37WIhIwaCGodLoJAhfS51bqcHLoTAQa52MSl9CMG2Sgupl6JqxfPukZNtX/3nf9N04BiZ9/66f6qCfePf5aYB1oiyNhHLQBkra5ATwojZ49JaQ6cnzlVwOvDkS2yeNdzRaznB8MDgxTubvZ/1Q00SPjnxcitpj3+r7G3QffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I57TAqes; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M6Icu0uk6Q1a2M6IduTrDL; Mon, 02 Jun 2025 16:38:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748875088;
	bh=Q3FY7W/SN+3RTIKTpGqSErEG0R0kJpBVY5zlTwSvIZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I57TAqescbmwFxWJQFo9xNbOaRC2pmg/OIQhkTomC5atGWPcJYYvKUD+nK6zNJM4N
	 /IOBPM83QdQ5a/fHJTYRQTNXE4Pn095FsWR50oroTca6JKdDYM1U+AzCXUuIQ7eVCt
	 VupOAdF4cRLxZlRaBOHcX9XMqDSXP3iRjFnkenXCHk39Ysw4Ifoqcs+mAqzsEV2O7I
	 OJbvSBVRt/MN/o+2+fy2SEqIaFAIye449zuUbZVtZgwt7FzqSfZokM7Y3Ny5cIbHhK
	 bpxESaGdGZdtJUwzW7TrGje2jQ1WImWNaQ6rR1D2oxSmywE2lmSbnOboldVC+OjYLO
	 qJTItwIwBhRtA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 16:38:08 +0200
X-ME-IP: 124.33.176.97
Message-ID: <f712180d-7a8d-4ce0-9e3e-a4ded446c40d@wanadoo.fr>
Date: Mon, 2 Jun 2025 23:38:01 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] can: rcar_canfd: Add support for Transceiver Delay
 Compensation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1748863848.git.geert+renesas@glider.be>
 <c830bd8b65d5f96c8831a2967c5b4c0eeb30e0af.1748863848.git.geert+renesas@glider.be>
 <7df51717-ffd1-43c1-8c5a-ab181439f580@wanadoo.fr>
 <CAMuHMdU0PNpsfNfDUAW09d5DTuuwJ_FnEFYk6a3KAC7sPRmkeg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdU0PNpsfNfDUAW09d5DTuuwJ_FnEFYk6a3KAC7sPRmkeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/06/2025 at 23:08, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> On Mon, 2 Jun 2025 at 15:41, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>> On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
>>> The Renesas CAN-FD hardware block supports configuring Transceiver Delay
>>> Compensation, and reading back the Transceiver Delay Compensation
>>> Result, which is needed to support high transfer rates like 8 Mbps.
>>> The Secondary Sample Point is either the measured delay plus the
>>> configured offset, or just the configured offset.
>>>
>>> Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
>>> (writing instead of reading the field).  Add register definition bits
>>> for the Channel n CAN-FD Status Register.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -191,9 +191,19 @@
>>>  /* RSCFDnCFDCmFDCFG */
>>>  #define RCANFD_GEN4_FDCFG_CLOE               BIT(30)
>>>  #define RCANFD_GEN4_FDCFG_FDOE               BIT(28)
>>> +#define RCANFD_FDCFG_TDCO            GENMASK(23, 16)
>>>  #define RCANFD_FDCFG_TDCE            BIT(9)
>>>  #define RCANFD_FDCFG_TDCOC           BIT(8)
>>> -#define RCANFD_FDCFG_TDCO(x)         (((x) & 0x7f) >> 16)
>>> +
>>> +/* RSCFDnCFDCmFDSTS */
>>> +#define RCANFD_FDSTS_SOC             GENMASK(31, 24)
>>> +#define RCANFD_FDSTS_EOC             GENMASK(23, 16)
>>> +#define RCANFD_GEN4_FDSTS_PNSTS              GENMASK(13, 12)
>>> +#define RCANFD_FDSTS_SOCO            BIT(9)
>>> +#define RCANFD_FDSTS_EOCO            BIT(8)
>>> +#define RCANFD_FDSTS_TDCR(gpriv, x)  ((x) & ((gpriv)->info->tdc_const->tdcv_max - 1))
>>> +#define RCANFD_FDSTS_TDCVF(gpriv) \
>>> +     ((gpriv)->info->tdc_const->tdcv_max > 128 ? BIT(15) : BIT(7))
>>
>> See my previous comment: no more function like macro please.
> 
> OK, "int rcar_canfd_get_fdsts_tdcr(gpriv, sts)".
> 
> RCANFD_FDSTS_TDCVF() is unused, so I'll drop it.
> 
>>> @@ -634,6 +645,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>>>       .brp_inc = 1,
>>>  };
>>>
>>> +/* CAN FD Transmission Delay Compensation constants */
>>> +static const struct can_tdc_const rcar_canfd_gen3_tdc_const = {
>>> +     .tdcv_min = 1,
>>
>> Interesting. This is the first time I see a driver with the tdcv_min and the
>> tdco_min different than 0. At one point in time, I wanted those to be implicit
>> values. Guess it was finally a good idea to include those minimums to the framework.
> 
> Really? As most other timing values need subtracting 1 when programming
> the hardware, I would expect it to be rather common.

Do a

  git grep "tdc[ov]_min ="

and see by yourself :)

I also expected that this might occur one day, so glad I anticipated.

>>> @@ -1477,6 +1514,22 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>>>       rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
>>>       netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
>>>                  brp, sjw, tseg1, tseg2);
>>> +
>>> +     /* Transceiver Delay Compensation */
>>> +     if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
>>> +             /* TDC enabled, measured + offset */
>>> +             tdcmode = RCANFD_FDCFG_TDCE;
>>> +             tdco = tdc->tdco - 1;
>>> +             netdev_dbg(ndev, "tdc: auto %u\n", tdco);
>>
>> Same as previously. Are those debugs really useful? You can get the value
>> through the netlink interface (OK, you still have to do the minus one by hand,
>> but don't tell me that's the reason).
> 
> No, I just mimicked the existing debug prints, which we already agreed
> upon to remove.
> 
>>> +     } else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
>>> +             /* TDC enabled, offset only */
>>> +             tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
>>> +             tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
>>
>> That's an edge case I did not think of and that is thus not handled by the
>> framework. This min() is a bit hacky, but I do not see a better workaround.
>> Also, I guess that this edge case will rarely occur.
> 
> can_calc_tdco() also does a silent min(..., tdc_const->tdco_max).

Good catch!

>>> +             netdev_dbg(ndev, "tdc: manual %u\n", tdco);
>>> +     }
>>> +
>>> +     rcar_canfd_update_bit(gpriv->base, RCANFD_F_CFDCFG(gpriv, ch), mask,
>>> +                           tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
>>>  }

Yours sincerely,
Vincent Mailhol


