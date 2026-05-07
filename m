Return-Path: <linux-can+bounces-7543-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pEN0GP3b+2k9FwAAu9opvQ
	(envelope-from <linux-can+bounces-7543-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 02:25:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E14724E1AF5
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 02:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADFB3300A319
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588C85C4A;
	Thu,  7 May 2026 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGP1OeeB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112A4A07;
	Thu,  7 May 2026 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113528; cv=none; b=B0kTPmSZY81y6p8rNkMVXvPJmqBvU6VM31izrFH7zyvHcgfxz5dYt8aAVnLV2KNycPtvIu4vYnWJNcC536ovLkqzUxU2pe48rChMxoxn8eF1nA694H4io/DMPgvrhtamqeIRlexoR/aKz5pqdYZWaqk/yFI3qt6hKlEc9b6r5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113528; c=relaxed/simple;
	bh=RtSJVkZEpOYr4SVwJMf3beHk57TF98Ft48y2/lsGKDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYI50ZRXVAwkMV+h5DIm2hQCjyrUT7Jlf/WrRYpM+LW7PWXEGgQ/dp94p2giUnyujiYQpn1o+jekfyuprCwcNRPWjhZfpuhLNi/A3Er4I+2V2WuJ4BqN4bF0+XdxPTzDpzrOFZdiMbRH8u6ILNqQpU28V3oBkZcn6SLBD1YxOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGP1OeeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB8C2BCB0;
	Thu,  7 May 2026 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778113527;
	bh=RtSJVkZEpOYr4SVwJMf3beHk57TF98Ft48y2/lsGKDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LGP1OeeBT3ZaDJOe0c+cTtwSfJG01Hg7QOiJluZ04pLuAuY9n1647Hgr/gdizAjt8
	 vaPwBh+pXrE7F+8cUxkrlzaaeVEaM8wokIYCEAg9fxWbV0VPFDGCvUmlxQWtA/vOx2
	 p5pfsONac2yx6WijCbIODX0Z90UCl8hgd6Q7uXrbIhgohqXMsLi9RPJXl95KY5z59v
	 BQuMv6li3xF0enJaNFtn9dwnII7cvjPpMYw5LMjGhBB8cRSBbTWdZxJAV/qd1+VhZk
	 AytNMczcqLsGILEJhitcvnh/4qjmtbB1MhnIr+5ZfN8TWBORO6djXxKX3auMwu1jua
	 5G2iZB0gyGELQ==
Date: Wed, 6 May 2026 17:25:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, Oleksij
 Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 4/5] llc: convert to getsockopt_iter
Message-ID: <20260506172525.27323c23@kernel.org>
In-Reply-To: <20260505-getsock_two-v1-4-4cb0738950e0@debian.org>
References: <20260505-getsock_two-v1-0-4cb0738950e0@debian.org>
	<20260505-getsock_two-v1-4-4cb0738950e0@debian.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E14724E1AF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7543-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 05 May 2026 04:12:41 -0700 Breno Leitao wrote:
> Convert LLC socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> - Add linux/uio.h for copy_to_iter()

kdoc needs to be adjusted here.

When you repost could you split the CAN stuff out and send it 
to Marc and co. ? We don't normally take CAN patches directly.
-- 
pw-bot: cr

