Return-Path: <linux-can+bounces-7751-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1R2CE/ESIGoAvgAAu9opvQ
	(envelope-from <linux-can+bounces-7751-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 13:41:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBB63728C
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 13:41:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Etci4ml0;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7751-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7751-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B698130034BB
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83698426D0B;
	Wed,  3 Jun 2026 11:31:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620973AC0F3;
	Wed,  3 Jun 2026 11:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486287; cv=none; b=ovyCO9ghr2mqdU4QEQrvKtdrJyCEALWMZ+82AnyXUE1BDPrlOcUoOrLNwtRYXkNIr7SyQgzZTFuE8ne39dTSketK9866jEQMva9xvEElx+yZ+SXZIKkFv/A1rUqtt4nO/SVfZUlbU1mkeOTmn6nl8edIA4PDGGvJZecH78o0kOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486287; c=relaxed/simple;
	bh=rFDKJ23nKbw5QnhMlSLvWH/4mzsJuPpgVZIhH6YP8Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXiJD0BLfF8ldbOznjFB0wC4jU4/G5kOeT+Kc+SPgIscZFamyZbTOqVunGbhc9eaXDX8TCuoZAzkAobyuQ/sb4UynbAGnHgjA4LfQmNhHTV7FIT/pmu69JpmqvbG3JxoSMF+CI8j3YQCGyHd66IEvOHhUadGP585n4BK9I/cHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etci4ml0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD51F00893;
	Wed,  3 Jun 2026 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486286;
	bh=8n1IjDK9oizFvDn9xZasLePZiA2bH/K/fyrOPQk364g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Etci4ml0STfQYPuBx1KBuGawQr0Jo9ZPJfZcRQwqRmSAkW3oMWZVhCn+pY8IGC8t8
	 5vAOMz/wZSxoRnHwrPKB7lSSBUNlhNTUIBEBGvlKsej8FJYVJRZRfoa8v9OMP80brr
	 gR0HxTJaS+DkF2eBbOIJUu69sia7QPzW4ja7iHisnpqXUSWxlAffdYZYusoN9wTY/j
	 WyJiLdjHGsjz3ptTvfiSJ171O3/TED+KCPLm8trkAHNU06Cy9PmVmvFOIfjTBRonfG
	 iOQ7EB15PkVPt0AunNJ7Y8oOl4e9T4o0JoqDQrf5+q49YxH6s9OWn/18s65kokItPz
	 OvFx7nKGu7q+A==
Message-ID: <1f45fc18-3f3b-4ced-bf62-844e217f5cfd@kernel.org>
Date: Wed, 3 Jun 2026 13:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mscan: replace in_8/out_8 with ioread8/iowrite8
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 chleroy@kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20260602223431.17672-1-rosenp@gmail.com>
 <36da6192-a69e-4ab8-90f6-590f620ecc5f@kernel.org>
 <CAKxU2N86OYiXvtw=n5gNAtRzYeqf8UKA-Y=NTNoXMza70hHnjg@mail.gmail.com>
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
In-Reply-To: <CAKxU2N86OYiXvtw=n5gNAtRzYeqf8UKA-Y=NTNoXMza70hHnjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:chleroy@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7751-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58EBB63728C

On 03/06/2026 at 02:43, Rosen Penev wrote:
> On Tue, Jun 2, 2026 at 5:29 PM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> On 03/06/2026 at 00:34, Rosen Penev wrote:
>>> Mechanical conversion of the ppc4xx-specific in_8/out_8 accessors and
>>> the setbits8/clrbits8 macros to the generic ioread8/iowrite8 helpers
>>> for portability.
>>>
>>> Add HAS_IOMEM as these functions need it.
>>>
>>> Add COMPILE_TEST as a result. This can be built anywhere now.
>>>
>>> Assisted-by: opencode:big-pickle
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> I left a comment for a potential extension of the patch, but it is ok as-is.
>>
>> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>>
>>> ---
>>>  drivers/net/can/mscan/Kconfig |   3 +-
>>>  drivers/net/can/mscan/mscan.c | 143 +++++++++++++++++-----------------
>>>  2 files changed, 73 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
>>> index dfe6bd9947bb..ef3a99b3d3db 100644
>>> --- a/drivers/net/can/mscan/Kconfig
>>> +++ b/drivers/net/can/mscan/Kconfig
>>> @@ -1,6 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>  config CAN_MSCAN
>>> -     depends on PPC
>>> +     depends on PPC || COMPILE_TEST
>>> +     depends on HAS_IOMEM
>>
>> It seems to me that following your changes, it should also now become
>> easy to add COMPILE_TEST to config CAN_MPC5XXX.
> I'll look into this.
>>
>> mpc5xxx_can.c has a couple of unused headers, after removing those, I
>> could compile test it!
>>
>> These are my local changes:
>>
>> ----8<----
>> diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
>> index ef3a99b3d3db..9bffd91ea418 100644
>> --- a/drivers/net/can/mscan/Kconfig
>> +++ b/drivers/net/can/mscan/Kconfig
>> @@ -13,7 +13,7 @@ if CAN_MSCAN
>>
>>  config CAN_MPC5XXX
>>         tristate "Freescale MPC5xxx onboard CAN controller"
>> -       depends on (PPC_MPC52xx || PPC_MPC512x)
>> +       depends on PPC_MPC52xx || PPC_MPC512x || COMPILE_TEST
>>         help
>>           If you say yes here you get support for Freescale's MPC5xxx
>>           onboard CAN controller. Currently, the MPC5200, MPC5200B and
>> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
>> index 0080c39ee182..759efb71d843 100644
>> --- a/drivers/net/can/mscan/mpc5xxx_can.c
>> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
>> @@ -9,8 +9,6 @@
>>   */
>>
>>  #include <linux/kernel.h>
>> -#include <linux/module.h>
>> -#include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/property.h>
>>  #include <linux/netdevice.h>
>> @@ -18,11 +16,6 @@
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>> -#include <linux/of_platform.h>
>> -#include <sysdev/fsl_soc.h>
>> -#include <linux/clk.h>
>> -#include <linux/io.h>
>> -#include <asm/mpc52xx.h>
>>
>>  #include "mscan.h"
>> ----8<----
>>
>> Et voilà ! Both CAN_MSCAN and CAN_MPC5XXX can now be compile tested!
> drivers/net/can/mscan/mpc5xxx_can.c:22:10: fatal error:
> 'sysdev/fsl_soc.h' file not found 22 | #include <sysdev/fsl_soc.h> |
> ^~~~~~~~~~~~~~~~~~
> 
> drivers/net/can/mscan/mpc5xxx_can.c:376:2: error: call to undeclared
> function '_memcpy_fromio'; ISO C99 and later do not support implicit
> function declarations [-Wimplicit-function-declaration] 376 |
> _memcpy_fromio(&saved_regs, regs, sizeof(*regs)); | ^
> 
> needs more work.

Ah! I only compiled the objects but didn't link them and thus missed
this error. Well, this is what I get for answering the mailing list in
the middle of the night.

Regardless, for PPC, memcpy_toio() and _memcpy_toio() are the exact
same function and memcpy_fromio() is implemented as:

	#ifdef CONFIG_EEH
	#define __do_memcpy_fromio(dst, src, n)	\
					eeh_memcpy_fromio(dst, src, n)
	#else /* CONFIG_EEH */
	#define __do_memcpy_fromio(dst, src, n)	\
					_memcpy_fromio(dst, src, n)
	#endif /* !CONFIG_EEH */
	
	static inline void memcpy_fromio(void *d, const volatile void __iomem *s, unsigned long n)
	{
		__do_memcpy_fromio(d, s, n);
	}

So also the same as _memcpy_fromio() if CONFIG_EEH is not selected. And
if CONFIG_EEH is selected, using _memcpy_fromio() instead of
eeh_memcpy_fromio() seems incorrect.

I think that the final nail in the curtain is that mpc5xxx is the only
driver in the full tree still using _memcpy_fromio() and
_memcpy_toio().

After replacing both with their memcpy_fromio() and memcpy_toio()
equivalent, I can now build and link without any problem on non
PPC architectures.


>>>       tristate "Support for Freescale MSCAN based chips"
>>>       help
>>>         The Motorola Scalable Controller Area Network (MSCAN) definition

 
Yours sincerely,
Vincent Mailhol

