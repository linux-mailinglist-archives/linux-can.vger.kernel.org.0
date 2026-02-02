Return-Path: <linux-can+bounces-6456-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMbmG61tgGl38AIAu9opvQ
	(envelope-from <linux-can+bounces-6456-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 10:26:05 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BFCA18B
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89A3301E23B
	for <lists+linux-can@lfdr.de>; Mon,  2 Feb 2026 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F42C08CB;
	Mon,  2 Feb 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="I+xwC574"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937611EFF8D;
	Mon,  2 Feb 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024180; cv=none; b=tf+sbv8LoqjFP0SP5PLwhOLfS/vrCtdr/gkbLZ8xLJiBNDHk6NKG/kpIo5BCLXqWUmMBVtmu2nefveQCV13kJQ4EBH4ZTXVhHD9mnyDg2BFnsHPXxfStl1Z02T/zDrOwopSJeMOl7Qjt4kb+NnJ8zY2i6P8uLEsUMveVctbYj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024180; c=relaxed/simple;
	bh=Nu/6ZeWOGIIlcXAjG0eXaNrM/XHgSycjB8FMPIxRAVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bOfyfyvUaYxWrYJFocYC/G4k4LPjnjKPokg/D4bVLkqKh2VD9v26Fce5c2JeSHCEwW8v4xX72GjzI6+3ZVLYhv3mw5bEjxdsy5+/Sa5eCOlRLrD5FG9InlnU+NQWEqdh18W+bv8lJag1/NkVe3FuhZsWDzbHpw/63Yr0M8FQyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=I+xwC574; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1770023841; bh=Nu/6ZeWOGIIlcXAjG0eXaNrM/XHgSycjB8FMPIxRAVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I+xwC574uumb9w+BNGhhcpV8QfsVJRhsBVECS+v1DVl8nlGMH/HdsyC+b/0kCCqyX
	 KAtNvjmRCIu8H7/JgUPPV23OH7YmGJq8CWyBRPAnc7xAidbTsEqfJ1g028MakxkQ5W
	 X5HVWeDuMexI4t44oCDvx7Y1d9th/gqkvcadfLtHqosv6rLMihoQEnYybaDMPjF6Rj
	 1iK4wg+XLuYJBUg9dqS2ouLgi82p6G+8ql0/NHdSy/OowaKwGF0nVdMO+PAqS9OYK6
	 CLyv9XVpKZYUnAnGbCPs4ovuUMByXjGPU/5zSYbN1SwFEp8QXEjVBy0lqOYpmhjCsu
	 /jKS8hWAy6/yA==
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Thomas =?utf-8?Q?M=C3=BChlbacher?=
 <tmuehlbacher@posteo.net>, Oliver
 Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
Date: Mon, 02 Feb 2026 10:17:19 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecn333og.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[toke.dk,reject];
	R_DKIM_ALLOW(-0.20)[toke.dk:s=20161023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6456-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,intel.com,realtek.com,posteo.net,hartkopp.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[toke.dk:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,toke.dk:dkim,toke.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 062BFCA18B
X-Rspamd-Action: no action

Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

For ath9k:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

