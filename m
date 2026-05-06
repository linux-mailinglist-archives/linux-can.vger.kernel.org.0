Return-Path: <linux-can+bounces-7529-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBccDoYW+2lGWgMAu9opvQ
	(envelope-from <linux-can+bounces-7529-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 12:23:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84C4D947A
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340E8300822E
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D061401A23;
	Wed,  6 May 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4iyOb4q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB553F9F59
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062978; cv=none; b=PKETLiCEvblM0SfoekWshv9m4fFMgsgLN0NszTzuu/QEEJ1092rbjBx6HIEYpfQ4j8xehWsiEJ71gA4SgoPJnFmYrTORa2NvNcy8o3pxAzf1iReVjM4wARMINmF828lDEI9QDMEoQmY0HoIPkaadzRc/nva1iBCvYcr+RQptodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062978; c=relaxed/simple;
	bh=jGO5LG8jtD9ahzZortuAJBczPrpCyltKq7G++mHRt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfnxgBxm3ZmPVXiloFu6/xtIKxCwMkuxQ4haxTokrY1QPoP5K3/Dn6y57h7ECbcuhNgjkV2hYLHPZ67CRPUm+W80IHUPeWRxvNPNOxSbIU0dHEvLe5swjh8snfgXGiLegWeUoa/LVhnMGk10o2H+Prn+v1r9oQpGKawc+83AblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4iyOb4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F534C4AF09
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778062977;
	bh=jGO5LG8jtD9ahzZortuAJBczPrpCyltKq7G++mHRt/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A4iyOb4qUYQZ1vXbLo3v6KnpuQrlUy4PKInxNqqeegcahAqLqJrTogbEASqJgJJ5v
	 3jpaOWhBot4DcEDVLG3HS2/fgObCd9zIN2xqmR9ALAL8OLUggt5BdS45jLo0OIO7/3
	 ksfNmgNNgs03q8H0TAgdlTI+MhjrG/67hBguoSNI++vAA5JSb99bZNwzH++wOSFamM
	 OHYH2Cefz/R32VsdTekyiQu5xzNvjFMJxAn11nj9R0LrwhVr9RmFQQg19D89iaV2eO
	 9nypnk1AqHGWwRn30V/Y89w6cKbYxma5jC7PSXBgNebSJ6MNA0ZN6lHNk8l1ksEjdb
	 9/+G29f5Cop1A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bad54961385so1013305166b.2
        for <linux-can@vger.kernel.org>; Wed, 06 May 2026 03:22:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvuhCTQ5fwUgKF1qL4a/WPOLJ3jc9JtNQQKNidd4Xxj4PQsWIe
	7Y3tjhoXOfB+ClQ23P7qEfibs9eoJj2PVnwAg04xuRTES/Y7Ue5AiRNbeqOkdckglvnN0sXA1M5
	zPNw6+6FuXYk4nfmRVvY0ncOW0RGMzio=
X-Received: by 2002:a17:907:a07:b0:ba4:f501:cb8b with SMTP id
 a640c23a62f3a-bc56b83947fmr140865766b.16.1778062976481; Wed, 06 May 2026
 03:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504111928.41856-1-socketcan@hartkopp.net>
In-Reply-To: <20260504111928.41856-1-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 6 May 2026 12:22:44 +0200
X-Gmail-Original-Message-ID: <CAMZ6RqJdF4xit5xvpGy6P9Nkenh6PT0meVpcL3UYZKx01yfQAg@mail.gmail.com>
X-Gm-Features: AVHnY4J-TVW5wurRomSEIx5jnWl0Wzwx6RThOMv-U4q4DyIjZ-AgPQnqILPc5es
Message-ID: <CAMZ6RqJdF4xit5xvpGy6P9Nkenh6PT0meVpcL3UYZKx01yfQAg@mail.gmail.com>
Subject: Re: [PATCH] can: raw: add locking for raw flags bitfield
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8C84C4D947A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-7529-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email]

On Mon. 4 May 2026 at 13:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
> struct raw_sock") the formerly separate integer values have been integrated
> into a single bitfield. This led to a read-modify-write operation when
> changing a flag in raw_setsockopt() which now needs a locking to prevent
> concurrent access.
>
> Instead of adding a lock/unlock hell in each of the flag manipulations this
> patch introduces a wrapper for a new raw_setsockopt_locked() function
> analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c
>
> Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct raw_sock")

Arg, that's my patch, sorry for that!

> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>

Maybe add a link to the report?

Link: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/

> Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I was able to trigger the bug locally using Eulgyu minimum reproducer
and I can confirm that the issue is correctly resolved by this patch.
I also think that globally holding the lock simplifies the logic. I
tried to think if there were any alternatives (like
READ_ONCE()/WRITE_ONCE() or atomic types) but none of these seem
applicable here.

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Tested-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

