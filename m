Return-Path: <linux-can+bounces-7794-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I1bxL2FsKGqNEAMAu9opvQ
	(envelope-from <linux-can+bounces-7794-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:41:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE1663D61
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gd9LpgA1;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7794-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7794-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B92FD3067074
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037043749FE;
	Tue,  9 Jun 2026 19:35:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2B3749FC;
	Tue,  9 Jun 2026 19:35:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033724; cv=none; b=Z6h7/m2RLiS7VtCQBiBkkQ86CEDhnIOiZCScmHjxR71g5JO9q2PPVjoHvDKcZfs5Lkszi/l2WwBWYtqa7R9VQmnrLpJ6YC9j5PVkEs7qyR6E/reDa5NwmbucGg5z1QNxZKyicasxN5wxmjfS7BArM2l24UeZTErywuprh/15HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033724; c=relaxed/simple;
	bh=nRFmzcUaiHWslIfHZ8lZBNxlTfe/5tE9TQXUEp8ZrBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/jMwaDhDifH2pvFZmDNqAKK7cq87EnGz8M0/TV9BRcclWRiBfkjpDvgvfxTN3mbPT82jG3ErGW/vLT+mYo3gnxPBLLOoMBgYwJ89iWxf2lOCM6c4KkwRTdW72Qk27VDPK0JgS7NdVbAyHnPckoDF/3UIxYcGm8sdVH4vdhrzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd9LpgA1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43171F00893;
	Tue,  9 Jun 2026 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033722;
	bh=zlJ1izUT3b9sB+0io6mLoy0ZthPU0QciI8/lQC0mX9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gd9LpgA160cfB/pEN+PDzhkZ7LFCleunnU1M3IKf0IBlUIXaY9QDopSebbZwf7Qag
	 zmI6cLLBqG85XVBYEbj7bjBLOMVvrqsLXzqWMj61mrO1T1VsR8piS+6wF0FnWWPVhF
	 TDx/+A6liba/InHQbSj4owgez1kYEOio+3iYbeOnFQfQz4uyp30QI0I2IJf7txJ1OD
	 oDe61jjzYrLbpC7JlmU+jsvoS0KqTN32C7spSsDS7CDiYjnnHO8FpYuvheF3CHDeG4
	 CE5LRVhcsNTfVnjbCmIaGxlomAlGWu/7bN1PtYx30agk21czw/andOX84PRjlDvvUI
	 Mtd64NkMtPrfA==
Message-ID: <e2dc8425-fdcd-4a3d-9d00-1416395aea82@kernel.org>
Date: Tue, 9 Jun 2026 21:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-2-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260609142954.1807421-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7794-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FBE1663D61

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
> registered to the same flexcan_irq() handler. Since these are distinct IRQ
> numbers, they can be dispatched concurrently on different CPUs. Both
> instances then read the same iflag and ESR registers unconditionally,
> leading to duplicate frame processing.
> 
> Fix this by splitting the monolithic handler into focused parts:
> - flexcan_do_mb(): processes mailbox events
> - flexcan_do_state(): processes device state change events
> - flexcan_do_berr(): processes bus error events
> 
> Introduce dedicated IRQ handlers for multi-IRQ platforms:
> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
> 
> The combined flexcan_irq() handler is preserved for single-IRQ
> platforms with no functional change.
> 
> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


