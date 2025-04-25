Return-Path: <linux-can+bounces-3490-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31AA9CF45
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062A11BC5203
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2F1A23A0;
	Fri, 25 Apr 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="n5ptvBG4"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB41A5BA0
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601087; cv=none; b=cju+4KjFJu2OnX7CL0EURMGf+sJaj/jOBneSMcK/nF8pP+ZkflR9o3JGUhbOwrgiLNktmuyyhOrRfzr2GojcKVIf+OGg1BXtlgmGx2NGy7EtG7MI017+Y3jBUA6FRfj9ep6oLLUVG4CuYFhQL54CUI9HVQ1WZFv5P5AHLaxHle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601087; c=relaxed/simple;
	bh=19fRMffmY4AGH0iWndwlMSmWXyrR49aoHhibf2n219Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5KHhZhcJH46ROzXaXC+amqnbpFieIYOn15zEUjQani+2ruQRYDYK/SfUNuDmOXHqZ+f+jtdUhgtW4BEFSZZ4jhhNO3WqLjTva0AUUF33jzb3xvKulPHwdmmK72RR+XZF2vr0Z/xSTmJYLvD13wHXhe2DkusjK24pTAUUG+zJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=n5ptvBG4; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 8MQruzplDvf4p8MQvuzN5S; Fri, 25 Apr 2025 19:01:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745600511;
	bh=aoXybO5z2rVqmAnpHXrnCtFhxJMiNMpClLrCWmHMlhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=n5ptvBG4r2gQlz0yn4O6xjg3iTa3TD0b+W69/BTc9CIfKhPY9fkzSf2cOEkz5Aj7b
	 DjArrZG7Wjk1/Zc0SOfRuxCmZW+rhXOgQzxapnWlQQrTGlGb9dgMcq+0UsDFdASF1f
	 /wN4cizKx4XhtwkgRCsZUwQS8VdUlLCfEiyoGMlG1TNb8W1nbLwr/38yolLuujJRwA
	 IbdpjQrt7gvtt941IuBTxZZConz9PxTIGbilFZh7F/w1GDZFfsktyIuD+LTU73cNk5
	 hU2XmtS7KIEHeD4j2lk7eJkpTks9QJhdIpw5nsboPYaIsJh6dqXhW3k6Kgv7UWlhxm
	 PLHlGPe8czr/A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Apr 2025 19:01:51 +0200
X-ME-IP: 124.33.176.97
Message-ID: <dbf42ea2-6506-43ea-8f8c-3df9f620a166@wanadoo.fr>
Date: Sat, 26 Apr 2025 02:01:43 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
References: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
 <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
 <91295576-C918-419E-B529-196BDDF1BE35@vpprocess.com>
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
In-Reply-To: <91295576-C918-419E-B529-196BDDF1BE35@vpprocess.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/04/2025 at 01:42, Kelsey Maes wrote:
>> On Apr 24, 2025, at 19:26, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>>> ---
>>> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++----
>>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> index 3bc56517f..1180c489b 100644
>>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> @@ -577,9 +577,13 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>>>        /* Transmitter Delay Compensation */
>>>        tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
>>>                       -64, 63);
>>> -       val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>> -                        MCP251XFD_REG_TDC_TDCMOD_AUTO) |
>>> -               FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>>> +       if (can_tdc_is_enabled(&priv->can))
>>
>> Did you test that this function ever returns true? The framework can
>> normally detect whether TDC should be turned on or off, but for this,
>> it needs to do some basic calculations using the TDC const values
>> which you did not provide.
> 
> Good point, I did not test it directly. The propagation delay of my loop is
> low enough that it should work without TDC at all in most cases, even at
> 4 Mbit. 
> 
>> For this, you will need to populate:
>>
>>  priv->can.tdc_const
>>
>> To test, use:
>>
>>  ip --details link show can0
>>
>> On a low dbitrate, the TDC should be off, but on higher bitrates (e.g.
>> 5 Mbps) you should confirm that the TDCO value is calculated.
> 
> That command doesn’t give any indication of TDC. Does this mean it’s not
> enabled? What should I be looking for?

No TDC indication means it is off.

Look at the description of this commit:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0c263d7c36ff99cd2f6bc1e0702181cbdc50f7b8

I posted the TDCO output there.

Look at the ctrlmode flags:

  $ ip --details link show can0
  1:  can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group default
qlen 10
      link/can  promiscuity 0 minmtu 0 maxmtu 0
      can <FD,TDC-AUTO> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
              ^^^^^^^^

Here, the TDC-AUTO flag is on. If none of the TDC flags show off, then TDC is
off and the tdc section is missing.

> I will try populating tdc_const as well.
> 
>>> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>> +                                MCP251XFD_REG_TDC_TDCMOD_AUTO);
>>> +       else
>>> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>> +                                MCP251XFD_REG_TDC_TDCMOD_DISABLED);
>>> +       val |= FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>>                                                         ^^^^
>> Once you do the above changes, the tdco will be calculated by the
>> framework. If I remember well, the mcp251xfd uses a relative TDCO, so
>> you should use can_get_relative_tdco().
>>
>>  https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/dev.h#L115
> 
> Are you sure it’s a relative TDCO? The Microchip documentation doesn’t
> explicitly say one way or the other but their calculation spreadsheet
> matches the existing DBRP * DTSEG1 calculation in the driver and my
> own embedded implementations which are all indicative of an absolute
> TDCO.


No, I am not sure. But if it is an absolute value, then it can only be positive.

The fact that it is clamped between -64 and 63 is a strong hint that this is a
relative TDCO:

https://elixir.bootlin.com/linux/v6.14.3/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L579

I also discussed this with Marc in the past. It was a few years ago.

But I did not check the datasheet personally, so take my comment with a grain of
salt.

>>>        return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>>> }
>>> @@ -2086,7 +2090,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
>>>        priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>>                CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
>>>                CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
>>> -               CAN_CTRLMODE_CC_LEN8_DLC;
>>> +               CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>>>        set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>>>        priv->ndev = ndev;
>>>        priv->spi = spi;
>>
>> Your patch is corrupted:
>>
>>  Applying: can: mcp251xfd: make TDC controllable from userspace
>>  Patch failed at 0001 can: mcp251xfd: make TDC controllable from userspace
>>  error: corrupt patch at line 10
>>
>> It seems it has to do with encoding. Here is what I get
>>
>>  $ wget https://lore.kernel.org/linux-can/07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com/raw
>>  $ ./scripts/checkpatch.pl raw
>>  ERROR: patch seems to be corrupt (line wrapped?)
>>  #64: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:576:
>>  mcp251xfd_priv *priv)
>>
>>  ERROR: spaces required around that '=' (ctx:WxV)
>>  #73: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:578:
>>  +        val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>               ^
>>
>>  ERROR: spaces required around that '=' (ctx:WxV)
>>  #76: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:581:
>>  +        val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>               ^
>>
>>  ERROR: spaces required around that '|=' (ctx:WxV)
>>  #78: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:583:
>>  +    val |=3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>>           ^
> 
> Ah wonderful. I will try and sort this one out. This is my first attempt at an email
> patch submission.

No problem. Congrats for your first patch. That's already a pretty good
submission for a first attempt!


Yours sincerely,
Vincent Mailhol

