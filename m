Return-Path: <linux-can+bounces-7659-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZEE6HEzFC2o9MwUAu9opvQ
	(envelope-from <linux-can+bounces-7659-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 04:05:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E7576421
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 04:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC04301A3B2
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 02:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39A2D3A6A;
	Tue, 19 May 2026 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN4nyV6c"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587F27A133;
	Tue, 19 May 2026 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156297; cv=none; b=BaSJverOXOfUTlUEuO9QFVRmZEd7J2ANX3hDQErEhlhErGIEV7os8M72f6lJkem/0doYfTgPd7xG27qeMo6UXbaZMECbyL+55vhnPaf6cB3VfGzrLa4fVzdtGlPw3FCLEvOkw7dBTI30DdlDw8J6yYGPOyJxYR67sSeCEWG6amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156297; c=relaxed/simple;
	bh=IYMSdZCPOhkL/oRraY0PxDjKFZ6j0v7UtJsihoXFffg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loYtr6iN+rKYU+IA0rTYIVwj401CE+QOvCDcOVw+Q/rIoHyN7UDwqNte5ZK9y51L12iGrWd9QyP4+mDLvYZv4NRFfKY1eeu8TAPJEHdjL6rKhC/Wrm5VOIgOGddyG3V0XT8a6ZjAazGvphPD8uBv3eTvOkq3oUbVcnbAI7sQ4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN4nyV6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57776C2BCB8;
	Tue, 19 May 2026 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156296;
	bh=IYMSdZCPOhkL/oRraY0PxDjKFZ6j0v7UtJsihoXFffg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PN4nyV6cQEqUzMEK9d9Tt1gL2Q8NFQA7f6nH4vUgaX88+8ZdqbPOWG2/T1Wh/Qj+i
	 Jc/PjH8zuPBylqptxQ+Bwih1rLSQgHUb6UcsnjP+qrGbtqvUmSEsiPF2+jEkiQt3iZ
	 VkvzsbKRiQPM3jnxNMFD6PpbFuPNGdywxPfxISP/DGZ3o4fYQSiTXRvmXc6FbfSG9D
	 uky+QSxx8yT23vLO21smpF5TA7ZDHtTnFnBUAskOct177ctDSCZc0ghXitK/KJCEaJ
	 ERwo9YU7NBjC94ahuWbIPiPzIKhmK0acIu5bF36Dmh3Y+Y9ipu+oY30S8ehO9/Fqpy
	 /qpugyI3Nv7qA==
Date: Mon, 18 May 2026 19:04:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel
 <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Message-ID: <20260518190455.7fe355b4@kernel.org>
In-Reply-To: <ef62371e-ddd5-4074-b554-410c708ca1cd@I-love.SAKURA.ne.jp>
References: <c109e9fc-3fb7-4a48-a0bd-a4d7663e7342@I-love.SAKURA.ne.jp>
	<ef62371e-ddd5-4074-b554-410c708ca1cd@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7659-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E27E7576421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 10:21:32 +0900 Tetsuo Handa wrote:
>  net/can/j1939/bus.c        | 2 ++
>  net/can/j1939/j1939-priv.h | 3 +++
>  net/can/j1939/main.c       | 8 ++++----
>  net/can/j1939/transport.c  | 2 ++

Please follow the address list that get_maintainer produces for you.
netdev@ is flooded by AI patches already we really don't need more.

