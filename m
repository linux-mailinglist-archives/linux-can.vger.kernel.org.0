Return-Path: <linux-can+bounces-7839-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nxH8GVq6L2rfFAUAu9opvQ
	(envelope-from <linux-can+bounces-7839-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 15 Jun 2026 10:39:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4BF684A1E
	for <lists+linux-can@lfdr.de>; Mon, 15 Jun 2026 10:39:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DHx4Egmk;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7839-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7839-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5910D3013727
	for <lists+linux-can@lfdr.de>; Mon, 15 Jun 2026 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98C3CF1E8;
	Mon, 15 Jun 2026 08:35:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235983D0C1C;
	Mon, 15 Jun 2026 08:35:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512528; cv=none; b=bP0VUhuXw9IuGdGJILJlPn+xD11C3XBRVD2WRq6abKDyhruV/4LiO4rvLD4Qy8hGJFcwKvpRcPXD/biMIeXw2SqqTH+yUAqQolkYulU8wU/+n5lzsG8oMytlj/x6dxP72ECtBT4F64Q1hvlUurbdSbls6wwYxCFjwRgE4GXca30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512528; c=relaxed/simple;
	bh=zXrYO5vMbWIQaRpm6C4Na4L2gLkO1PmEeCbpHHul3IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDw+XKU92T70x/hc+HFF3Nlpfj+ok2kbuWdTp16qUXtsaVRqaA/8/CmDEatyiRChBf42FbmK/6c9ONnuOc6Fhli0DnpaC6RZzVhyjJK7EoQ42vRqm41c/vVoxC93JnCNrWxwKkzp2J9VHWrK38M4QwUnkoGw3z8/k8OsxjqBKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHx4Egmk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6E61F000E9;
	Mon, 15 Jun 2026 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512524;
	bh=YVOrQAv74TqwYH6NvuxkRgGldcsF+veBZEKO4rbxm7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DHx4EgmksXmmSYl/TmCMpS6Vl3hV+J/xCu6746Xi8CaLWr1PVlOfCwBhCAs4ApNSF
	 8SSWOkm0lJFvfIe0J00bAnbn+4ysKbR8bPRYwQTko46j8F3b+QU5pQspr/fSIozjR1
	 q3Tt2eP8kJvLUjsVRNoiObpk1fSg7Hws2Kf/Nx4gNm+ByP5lLPvywULVcSpTKLMQMe
	 5ORfo4bMQfCD7ASNoX/hBz0I6plocbMrlFOtiN8zhoMIRbrJbjcUOrcKKg4yyHRJnm
	 UYR3ZYCNe8UiYbXcKHV4fvmSPxLRaAvkJ9AorN6yG+hrwiAzzInCxF/vYo6VswRUxk
	 CSCZEi8cWqOyw==
Message-ID: <e69f520d-3b19-40fd-9be9-5df6d2b71763@kernel.org>
Date: Mon, 15 Jun 2026 10:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] can: loongson_canfd: Add RXDMA support
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen
 <chenhuacai@loongson.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Bingxiong Li <libingxiong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-can@vger.kernel.org, jeffbai@aosc.io
References: <cover.1780908445.git.zhoubinbin@loongson.cn>
 <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
 <11d8ceff-d05a-4446-96cc-f9f97538d12e@kernel.org>
 <CAMpQs4Kpas0qB=_h3KEJW3WL5i=mZjX53szAhhPrOCo8YKLAYA@mail.gmail.com>
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
In-Reply-To: <CAMpQs4Kpas0qB=_h3KEJW3WL5i=mZjX53szAhhPrOCo8YKLAYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7839-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD4BF684A1E

On 15/06/2026 at 03:35, Binbin Zhou wrote:
> Hi Vincent:
> 
> Thanks for your detailed review and sorry for my late reply.
> 
> On Mon, Jun 8, 2026 at 8:13 PM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> On 08/06/2026 at 10:49, Binbin Zhou wrote:
>>> Add optional DMA support for RX path using the Loongson APB CMC DMA
>>> engine. When a DMA channel is successfully requested, the driver:
>>>
>>> - Uses DMA cyclic transfers to write incoming CAN frames directly to
>>>   a coherent DMA buffer
>>> - Replaces RXBNEI (RX buffer not empty interrupt) with DMADI (DMA
>>>   done interrupt)
>>> - Dynamically switches between DMA and PIO modes based on channel
>>>   availability
>>>
>>> This significantly reduces CPU intervention under high RX load,
>>> especially beneficial for CAN FD at higher data rates.
>>>
>>> Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
>>> Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>> ---
>>
>> Please check the W=2 warnings:
> 
> OK. I usually compile with `W=1` and didn't notice these issues.

The W=2 used to be too spammy and people simply ignored it. I went
through a quest to reduce that noise. See

  660e899103e2 ("kbuild: remove gcc's -Wtype-limits")

with this, the output is less bloated and I think a bit more useful. Not
that you need to systematically address all warnings, but at least,
review the list.

>>   $ make W=12 drivers/net/can/loongson_canfd.o
>>     DESCEND objtool
>>     INSTALL libsubcmd_headers
>>     CC      drivers/net/can/loongson_canfd.o
>>   drivers/net/can/loongson_canfd.c:1917:9: warning: missing initializer for field 'driver_data' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
>>    1917 |         { "LOON0015" },
>>         |         ^
>>   In file included from ./include/linux/acpi.h:16,
>>                    from drivers/net/can/loongson_canfd.c:8:
>>   ./include/linux/mod_devicetable.h:219:24: note: 'driver_data' declared here
>>     219 |         kernel_ulong_t driver_data;
>>         |                        ^~~~~~~~~~~
>>   drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_start_xmit':
>>   drivers/net/can/loongson_canfd.c:1116:13: warning: 'buf_id' may be used uninitialized [-Wmaybe-uninitialized]
>>    1116 |         u32 buf_id, tx_stat, i = 0;
>>         |             ^~~~~~
>>   drivers/net/can/loongson_canfd.c:1116:13: note: 'buf_id' was declared here
>>    1116 |         u32 buf_id, tx_stat, i = 0;
>>         |             ^~~~~~
>>   In function 'loongson_canfd_insert_frame',
>>       inlined from 'loongson_canfd_start_xmit' at drivers/net/can/loongson_canfd.c:1144:7:
>>   drivers/net/can/loongson_canfd.c:1079:15: warning: 'meta1' may be used uninitialized [-Wmaybe-uninitialized]
>>    1079 |         meta1 |= FIELD_PREP(REG_FRAME_META1_DLC, can_fd_len2dlc(cf->len));
>>         |               ^~
>>   drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_start_xmit':
>>   drivers/net/can/loongson_canfd.c:1052:20: note: 'meta1' was declared here
>>    1052 |         u32 meta0, meta1;
>>         |                    ^~~~~
>>   drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_probe':
>>   drivers/net/can/loongson_canfd.c:1807:13: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
>>    1807 |         int ret, irq;
>>         |             ^~~
>>   drivers/net/can/loongson_canfd.c:1807:13: note: 'ret' was declared here
>>    1807 |         int ret, irq;
>>         |             ^~~
>>   drivers/net/can/loongson_canfd.c: At top level:
>>   drivers/net/can/loongson_canfd.c:47:9: warning: macro 'LOONGSON_CANFD_RX_FR_CNT' is not used [-Wunused-macros]
>>      47 | #define LOONGSON_CANFD_RX_FR_CNT        0x50    /* Receive Message Count Register */
>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Regarding the definitions of these controller registers, even though
> they aren’t currently referenced, can they be retained to make the
> code seem more complete?

Only keep the registers for features which are not yet implemented. For
the register which are already handled in a different way without
relying on the macro, please remove.

I can think, for example, of:

  LOONGSON_CANFD_TX_DATA_10

You handled the tx data in a for loop and this macro is purely dead and
do not serve anymore documentation purpose. The only thing it does now
is to add confusion.

(...)

>>>  config CAN_LOONGSON_CANFD
>>>       tristate "Loongson CAN-FD controller"
>>> -     depends on HAS_IOMEM || COMPILE_TEST
>>> +     depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)
>>
>> The logic is odd here. If your driver can be COMPILE_TESTed without
>> HAS_IOMEM, then patch 1 should be:
>>
>>         depends on HAS_IOMEM || COMPILE_TEST
>>
>> and patch 2 should be:
>>
>>         depends on (HAS_IOMEM && LOONGSON2_APB_CMC_DMA) || COMPILE_TEST
>>
>> If your driver need HAS_IOMEM even for a compile test, then patch 1
>> should be:
>>
>>         depends on HAS_IOMEM
>>
>> and patch 2 should be:
>>
>>         depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)
> 
> For me, the 2nd way is correct.

Ack.

Just for confirmation, do you think that your device will ever be used
in production on a board which would not have LOONGSON2_APB_CMC_DMA? If
yes, it could make sense to add the RXDMA as a separate module.
Otherwise, it is good as-is.

>>
>> Here, you are doing a weird mix.
>>
>>>       select REGMAP_MMIO
>>>       help
>>>         This is a canfd driver switch for the Loongson platform,


Yours sincerely,
Vincent Mailhol

