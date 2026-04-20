Return-Path: <linux-can+bounces-7375-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBHrFfEZ5mkprgEAu9opvQ
	(envelope-from <linux-can+bounces-7375-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 14:20:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A204342A968
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A663003EB9
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DD374E64;
	Mon, 20 Apr 2026 12:18:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC7175A5
	for <linux-can@vger.kernel.org>; Mon, 20 Apr 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687516; cv=none; b=BLKJ0IMyrztyBtDiuFQgFh2kdcVomNffPGNDpqLSjaJ1IjXynrr5tL1wDyzBfUk8jpK1XVV2G1m37qWjhf/ZwrvnaqXwYP7Wh5RPmqKeCIcjGKAhhHtYT7kkx/WwporOlmAG7OcS6wETiqTrvRZyJmOARZKIXGEu1FaYGe/Qu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687516; c=relaxed/simple;
	bh=iKdh0huWgoYjFm0DOT34aRCgqoK921FtqaFHufRQvDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXvuOy98Y/ZVxSTYNogcwYk1rs4FrDBViRGI3bvT9mlcxEmX7lGxPXQVKkSC6u4FbBgZH8MNlpOJriNJe5DrxliunbvshazBg8oXLBXGeFMjniIFCzljgxG+oW4i3d07cy7B4vggYjAzpbLwMVYNrPMOhdj9TYrjOedUaoGXYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wEna1-0004pw-Hl; Mon, 20 Apr 2026 14:18:21 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wEnZz-006Kk1-2U;
	Mon, 20 Apr 2026 14:18:19 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wEnZz-00000004GUf-2lGs;
	Mon, 20 Apr 2026 14:18:19 +0200
Date: Mon, 20 Apr 2026 14:18:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Robin van der Gracht <robin@protonic.nl>, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: j1939: fix lockless local-destination check
Message-ID: <aeYZi44QfQhRu4C2@pengutronix.de>
References: <20260419140614.GA4041240@chcpu16>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419140614.GA4041240@chcpu16>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7375-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: A204342A968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sun, Apr 19, 2026 at 10:06:14PM +0800, Shuhao Fu wrote:
> j1939_priv.ents[].nusers is documented as protected by priv->lock, and
> its updates already happen under that lock. j1939_can_recv() also reads
> it under read_lock_bh(). However, j1939_session_skb_queue() and
> j1939_tp_send() still read priv->ents[da].nusers without taking the
> lock.
> 
> Those transport-side checks decide whether to set J1939_ECU_LOCAL_DST, so
> they can race with j1939_local_ecu_get() and j1939_local_ecu_put() while
> userspace is binding or releasing sockets concurrently with TP traffic.
> This can misclassify TP/ETP sessions as local or remote and take the wrong
> transport path.
> 
> Fix both transport paths by routing the destination-locality check through
> a helper that reads ents[].nusers under read_lock_bh(&priv->lock).
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>

Thank you for your work. LGTM.
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

