Return-Path: <linux-can+bounces-7888-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vf88I49tNWp5wAYAu9opvQ
	(envelope-from <linux-can+bounces-7888-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 18:25:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25596A70B6
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 18:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fR+gLC+b;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7888-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7888-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5627830056FD
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0853BCD17;
	Fri, 19 Jun 2026 16:24:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FB3B38B4;
	Fri, 19 Jun 2026 16:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886284; cv=none; b=n6rp9pkN1/JyXL4WtuWTA39+vQT2CYti7BSU6ocUmKhPGUIEpn/R2M9D5gIHY3tiuGGY4ChQZZIP3IvHCHnZJYfHaEgaS8Zlfa8er0QJtjHvJ7ymX4uv7s6hE+xjZyKqTPSn/jYpNw92RzT0rMb9iOM7De1eRX6hMcXVyp+4jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886284; c=relaxed/simple;
	bh=k6vYDnp3cAk9toU5lORwP/UtW3DK+KmT5s016A+17+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+CXbrpyEqE0x7Y6QuFfhLp8zpVBOlm981Wc0nwcQFgB0m9zs8kyrK7N1hxl02qlVK+SGSEXN9UkKIM9vGrDstQEoRLLnmvq8DDvs5zfDzkF8STia/xqXnAM/ifvJnF+mHxxBtbAdEri25zlanLnV1GV0jKWSxd5LYhIZ+lGzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR+gLC+b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF2A1F000E9;
	Fri, 19 Jun 2026 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781886283;
	bh=uuMShKa/k8xBx2/gbNaT3GpbM0w/ZyqrWY+OL/X3LGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fR+gLC+b1oYYX+8dFc0eL7AKIlzC9/UFeKcLuQU5BQPT89qvDZaZK+hjmXJHyTtU5
	 7E5LCnz8rDLAH25vLsVnSgMXIuiuacXNT5Pw4I99XHjXo/yBIw75b6zVmbLeQEW3OH
	 H4y34raaQZTQmQFGuuE4hqwXHmpfUwTcLyd2vOcnU9UfvH0kIk/QyuhnttMhTmJ6X4
	 Bii6i4+Z8YGsgT6i1GYRKPK9CrOPvHgmZeWpxmSjg7gER6zoTHwvpo+ionWY8loor0
	 Ii1u2I7AfGD+de4r/WtvPzedV85hIljzI1JPSKNtXdfvPnYFjB316+rfqsrgunHj+T
	 AuEUBXcq0kJLQ==
Message-ID: <38387630-513e-470c-9c19-b5f7391f1fc3@kernel.org>
Date: Fri, 19 Jun 2026 18:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] can: Add Loongson CAN-FD controller driver
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen
 <chenhuacai@loongson.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Bingxiong Li <libingxiong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-can@vger.kernel.org, jeffbai@aosc.io
References: <cover.1780908445.git.zhoubinbin@loongson.cn>
 <ed069249061d105d72d2115b8a05216a60cebffb.1780908445.git.zhoubinbin@loongson.cn>
 <c9598f85-5b17-4d38-855e-c3840a01452f@kernel.org>
 <CAMpQs4J5vq8U-_1BanyFcn6PYhnws=vuE3Yq1hvSBbLZJC8aEQ@mail.gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMpQs4J5vq8U-_1BanyFcn6PYhnws=vuE3Yq1hvSBbLZJC8aEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7888-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:zhoubinbin@loongson.cn,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E25596A70B6

On 18/06/2026 at 11:49, Binbin Zhou wrote:
> Hi Vincent:
> 
> Thanks for your detailed review and sorry for the late reply.
> 
> On Tue, Jun 9, 2026 at 1:43 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> On 08/06/2026 at 10:49, Binbin Zhou wrote:

(...)

>>> +static void loongson_canfd_set_mode(struct loongson_canfd_priv *priv,
>>> +                                 const struct can_ctrlmode *ctrlmode)
>>
>> Rename this to loongson_canfd_set_ctrlmode(). Otherwhise there is a
>> risk of confusion with loongson_canfd_do_set_mode()
> 
> Actually, this function sets the `LOONGSON_CANFD_MODE` and
> `LOONGSON_CANFD_CONF` registers based on `priv->can.ctrlmode`.
> 
> How about rewriting it as follows:
> 
> static void loongson_canfd_set_confmode(struct loongson_canfd_priv *priv)
> {
>         u32 ctrlmode = priv->can.ctrlmode;
> .....
> }

That also works. My point was to avoid the confusion with
loongson_canfd_do_set_mode(). As long as there is enough disambiguation,
it is OK for me.

(...)

>>> +     /* Write Data payload */
>>> +     if (!(cf->can_id & CAN_RTR_FLAG)) {
>>> +             for (unsigned int i = 0; i < cf->len; i += LOONGSON_CANFD_DW_BYTE) {
>>> +                     regmap_write(priv->regmap,
>>> +                                  LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_FRAME_DB_1 + i,
>>> +                                  le32_to_cpu(*(__le32 *)(cf->data + i)));
>>                                                   ^^^^^^^^^^
>> This cast is just wrong. What if the code is run on a big endian
>> machine?
>>
>> To begin with, here, you are writing to your registers. So it should
>> be the other way around: cpu_to_le32(). And to add to it, if you need
>> endian conversion, populate regmap_config.val_format_endian.
>>
>> Also, why do you need some endian conversion only here and not on the
>> other registers?
> 
> Sorry, this is the old test code—I forgot to update it. Just use `u32`:
> 
>  for (i = 0; i < len; i += LOONGSON_CANFD_DW_BYTE)
>                 regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32
> *)(cf->data + i));

OK. Note that I don't mind if you want to keep the declaration of i in
the for loop:

  for (unsigned int i = 0; i < len; i += LOONGSON_CANFD_DW_BYTE)
  	/* ... */

>>> +             }
>>> +     }
>>> +
>>> +     return true;
>>> +}

(...)

>>> +static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
>>> +{
>>> +     struct net_device *ndev = (struct net_device *)dev_id;
>>> +     struct loongson_canfd_priv *priv = netdev_priv(ndev);
>>> +     u32 isr, imask;
>>> +
>>> +     for (unsigned int irq_loops = 0; irq_loops < 10000; irq_loops++) {
>>> +             /* Get the interrupt status */
>>> +             regmap_read(priv->regmap, LOONGSON_CANFD_INT_STAT, &isr);
>>> +             if (!isr)
>>> +                     return irq_loops ? IRQ_HANDLED : IRQ_NONE;
>>
>>                         if (irq_loops)
>>                                 return IRQ_HANDLED;
>>                         else
>>                                 return IRQ_NONE;
>>
> Emm...
> Is the ternary operator here more concise than `if-else`?
> 
>                 if (!isr) {
>                         if (irq_loops)
>                                 return IRQ_HANDLED;
>                         else
>                                 return IRQ_NONE;
>                 }

Unless you are getting an actual checkpatch.pl warning here, if I record
correctly, the curly brackets can be ommitted here:

		if (!isr)
			if (irq_loops)
				return IRQ_HANDLED;
			else
				return IRQ_NONE;

> vs
> 
>                if (!isr)
>                        return irq_loops ? IRQ_HANDLED : IRQ_NONE;

Yes, it is more consise, but is it more readable?

Actually, you might say that which one is the most readable is a
subjective topic and you would be right.

But it is the prefered style here. The indentation of the if/else makes
it more visual. And when you review thousands of line of code, it starts
to make a difference.

And I this is not my personnal opinion. For example, see this message
from Greg:

  https://lore.kernel.org/all/20250311150130.7a875e63@bahia/

So, even if this is an arguable case, let this be an if/else.

(...)

>>> +static const struct net_device_ops loongson_canfd_netdev_ops = {
>>> +     .ndo_open       = loongson_canfd_open,
>>> +     .ndo_stop       = loongson_canfd_close,
>>> +     .ndo_start_xmit = loongson_canfd_start_xmit,
>>> +};
>>
>> Also add a struct ethtool_ops and populate
>> ethtool_ops.get_ts_info. Something like:
>>
>>         static const struct ethtool_ops es58x_ethtool_ops = {
>>                 .get_ts_info = can_ethtool_op_get_ts_info_hwts,
>>         };
>>
>> Refer to what the other CAN drivers with hardware timestamps are
>> doing.
> 
> Regarding the hardware timestamp, could this be submitted as a
> separate feature patch? I need some time to resolve the related
> issues.
> Could we proceed as follows for now:
> 
> static const struct ethtool_ops loongson_canfd_ethtool_ops = {
>         .get_ts_info = ethtool_op_get_ts_info,
> };

OK, but make sure to remove all your local hacks. We will not accept the
use of the reserved fields in sturct canfd_frame for that.

Note that once you undertsand the timestamp framework, I would expect
the patch to be rather tiny.



Yours sincerely,
Vincent Mailhol


