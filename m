Return-Path: <linux-can+bounces-7900-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykydJv9gPWrq2AgAu9opvQ
	(envelope-from <linux-can+bounces-7900-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 19:10:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0AC6C7B8C
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 19:10:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kw783CVm;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7900-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7900-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0777A3014291
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2F3AB273;
	Thu, 25 Jun 2026 17:07:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644621D5174;
	Thu, 25 Jun 2026 17:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407252; cv=none; b=opFNlM5jM1VCSrHmeRnZnuEChiwpn/AQISjF0Lkt0EgVr+fqdPSM6G0xW9om3+rmAO0euAPmtxtqZP6cV05vMsYqvr1WYfiDHMGkzrjID5R1Wa33I+bsdkE4Y+/GE40mATYIsKXJmiNkbk07YJ9sA5JL8Pnrf8K5Ssg/q7kWg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407252; c=relaxed/simple;
	bh=dC+JBzxebaOXyA9OOvT2b33Z9C9XGKYBYzH60DJgZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVzDo1xcyD0G1E1gBRwSfcWPE1rblISAf8PG0sdOcvb+mAtj0Dn/4HovDgEWjsmrA3nCEflSqQUojC+VxZwX97qdzhJcx/wwvrjVNt7WklfbEzOsOE79X7k+AqqWkcZSf3hN5Qh3z4K4lZy2D5jDt1l3r3Htay0FZVX84Jj+kQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw783CVm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14DC1F000E9;
	Thu, 25 Jun 2026 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782407251;
	bh=YxAQYhRsry2MpZzvQqF03q8jbMwMkEhXrYA2x4B6dp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kw783CVmu/bDPIDBgjXws/S8Ehevrn4DXVULURkR1+Zm3RvUzXOynx5v6vD9iRIA8
	 6ThIw4ygulv93EYm14Z5H60iW2t4gbFdK0NA+dDqMbNQ/tOLwsdzcw2jNHKh4XFLfn
	 Ol6iYqKSgblZ0ZBZaalcOzd7dKGSIg0fwz20EHesuL9Y1AlglTZWEGmD9QS4Xdekx/
	 MVdMgDFUpcjgm9Tg357+I0YB3lQwyELlReU7+8FXMyoh+pUjl66U7plyAS9ljQrxnH
	 IkmL3Z1OsNFOwL8lTCOvkx/ROwKcIyx7GS7BVtQnGNVUqXjKOpcazZOd+QyGQUu6b+
	 e0jySbZa7AbDw==
Message-ID: <126053be-ecdc-44fe-9242-d4267d332683@kernel.org>
Date: Thu, 25 Jun 2026 19:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
To: Biju <biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tu Nguyen <tu.nguyen.xg@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Duy Nguyen
 <duy.nguyen.rh@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:biju.das.jz@bp.renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,glider.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7900-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE0AC6C7B8C

On 25/06/2026 at 15:51, Biju wrote:
> From: Tu Nguyen <tu.nguyen.xg@renesas.com>
> 
> Testing CANFD on RZ/G3E shows that many registers do not reset to their
> initial values with the current flow of deasserting resets first and then
> enabling clocks.
> 
> Based on the HW manual, clocks should be supplied first and the
> resets deasserted afterward.
> 
>  section 7.4.3 Procedure for Activating Modules: RZ/G2L
>  section 4.4.9.3 Procedure for Starting up Units: RZ/G3E
> 
> So, update the order of the initializing flow for resets and clocks
> to match the hardware manual, resetting all CANFD registers to their
> initial values. Also update rcar_canfd_global_deinit() to assert
> resets before disabling clocks, so the teardown path mirrors the new
> init ordering.
> 
> Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


