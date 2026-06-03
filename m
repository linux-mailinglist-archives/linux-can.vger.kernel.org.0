Return-Path: <linux-can+bounces-7735-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eYCzE1B1H2qDmAAAu9opvQ
	(envelope-from <linux-can+bounces-7735-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 02:29:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7DA63333C
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 02:29:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=odFnIU7g;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7735-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7735-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7032F3007ACB
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B31E3DDE;
	Wed,  3 Jun 2026 00:29:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B11D5160;
	Wed,  3 Jun 2026 00:29:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446541; cv=none; b=F7gR//Vk44lHDNDSkgTu28ktJwtzRjIsIEsbNQby4Fhj8/EpLSRv/2X1FLhQ76FK7g4Mh1uBlO+a+E0326vy9npUbrNE8fpKq8A+PQKaebThVsgQpb1vZ4hZcH/W/Am9parGELTL78qIZHqpu5l60ZtB3AP/PIAd7E7cAypL93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446541; c=relaxed/simple;
	bh=s7k18HCNb1SzeW0jlVdbHamyuWsjnLnSr8lN+pJEteE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3bOZxuZNYy/khgsTqtfxNqs5htS7J6ROvESzZcnO8/xB4xSydkIPgLNHknvEI58PfCyZgCN2CszM5lDIXFoU5+ThU1uVgTegr3dh2WfEe5A/UboxTjyNFcYhFCnV8Hhi5F9zNK6baSt2T70wyCE9FFxk1XzlQz+AC4EJsj3Krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odFnIU7g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6721F00893;
	Wed,  3 Jun 2026 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780446540;
	bh=H0y+5vAaeFG7HJkkRa/+gOH8L2qRh1pDKBog0V0UFL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=odFnIU7gUTgeJ5Ei4NX5j8jtDs79tZK1V293WV5pTeq6ye3o5AGc/6Zyk2SuoQkkM
	 4jhlNULYdwqB97sRwG/S1wdMBXoh+c9ZR3kE3MfWM+FM1uLopSObqIjuad+K03LSj+
	 h1x7+Of01q/Yxmap3htxfqngU/PolPZdPAkLZRcJBitET+gXyNqlbfEYgRAKK2HKob
	 SOHuBeRvUKl0TNhEgDDDRs4zyfzC7Y8cABeJZkZb6oXcF0JYhMqG5rKRIZRxpiJ+HJ
	 ovnZzOPETLOf377cWtjjs52dqucHQGfKn6yqkgjWeWse581dOXkhBmgWIRUP3LM0XJ
	 pV1wrepk3iwmQ==
Message-ID: <36da6192-a69e-4ab8-90f6-590f620ecc5f@kernel.org>
Date: Wed, 3 Jun 2026 02:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mscan: replace in_8/out_8 with ioread8/iowrite8
To: Rosen Penev <rosenp@gmail.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, chleroy@kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20260602223431.17672-1-rosenp@gmail.com>
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
In-Reply-To: <20260602223431.17672-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:chleroy@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7735-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA7DA63333C

On 03/06/2026 at 00:34, Rosen Penev wrote:
> Mechanical conversion of the ppc4xx-specific in_8/out_8 accessors and
> the setbits8/clrbits8 macros to the generic ioread8/iowrite8 helpers
> for portability.
> 
> Add HAS_IOMEM as these functions need it.
> 
> Add COMPILE_TEST as a result. This can be built anywhere now.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

I left a comment for a potential extension of the patch, but it is ok as-is.

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/net/can/mscan/Kconfig |   3 +-
>  drivers/net/can/mscan/mscan.c | 143 +++++++++++++++++-----------------
>  2 files changed, 73 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
> index dfe6bd9947bb..ef3a99b3d3db 100644
> --- a/drivers/net/can/mscan/Kconfig
> +++ b/drivers/net/can/mscan/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config CAN_MSCAN
> -	depends on PPC
> +	depends on PPC || COMPILE_TEST
> +	depends on HAS_IOMEM

It seems to me that following your changes, it should also now become
easy to add COMPILE_TEST to config CAN_MPC5XXX.

mpc5xxx_can.c has a couple of unused headers, after removing those, I
could compile test it!

These are my local changes:

----8<----
diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
index ef3a99b3d3db..9bffd91ea418 100644
--- a/drivers/net/can/mscan/Kconfig
+++ b/drivers/net/can/mscan/Kconfig
@@ -13,7 +13,7 @@ if CAN_MSCAN
 
 config CAN_MPC5XXX
        tristate "Freescale MPC5xxx onboard CAN controller"
-       depends on (PPC_MPC52xx || PPC_MPC512x)
+       depends on PPC_MPC52xx || PPC_MPC512x || COMPILE_TEST
        help
          If you say yes here you get support for Freescale's MPC5xxx
          onboard CAN controller. Currently, the MPC5200, MPC5200B and
diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 0080c39ee182..759efb71d843 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -9,8 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/netdevice.h>
@@ -18,11 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <sysdev/fsl_soc.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <asm/mpc52xx.h>
 
 #include "mscan.h"
----8<----

Et voilà ! Both CAN_MSCAN and CAN_MPC5XXX can now be compile tested!


>  	tristate "Support for Freescale MSCAN based chips"
>  	help
>  	  The Motorola Scalable Controller Area Network (MSCAN) definition



Yours sincerely,
Vincent Mailhol

