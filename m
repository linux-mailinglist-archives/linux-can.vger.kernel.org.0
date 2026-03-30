Return-Path: <linux-can+bounces-7297-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDyGCNhOymmb7QUAu9opvQ
	(envelope-from <linux-can+bounces-7297-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5B359190
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446EC3038F7C
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFC3BD625;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W80faabM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E93BADA0;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865903; cv=none; b=eexX2+nn/EtJX2UC7sMiRZzl5X6KVISIT+kpuImM1zWWZxU4GgXEE5J/C5FffX1z3htcZl6j/2RdATrecbH8rGSRMi4e9aahPvo+pclM1kQ6PkEunq8txXZkaW9YHvHG5FSuJxNkLpVheq/lg62ffyjVT0fmkwoMerxCXnf5Bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865903; c=relaxed/simple;
	bh=wZyJ06Y6S3EL/cP7SE/qvlcEeNLdJbOwV+7fSFN0RTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERBvKYzi5eqblwQWe5QCQFDio48pn6cpiji5DC24Cp8h5jF4zanodNhkNNSLrMdam/sfIYMcmskL214Gu5/X72O4S59D7lzwAi8qG2FrNDJv7oIP4rjTyJe9pbQBSQ4xJU/Tx6XB7QgkqlYM27kVcPHV/JXmVEUA8ECKnHyVA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W80faabM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EAEC2BC9E;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865903;
	bh=wZyJ06Y6S3EL/cP7SE/qvlcEeNLdJbOwV+7fSFN0RTY=;
	h=From:To:Cc:Subject:Date:From;
	b=W80faabMBd1fq0i+4GRIfcKbTCKlY1sP8whCF+LzMHod+vyF3muCxI//WMULotEr1
	 6Z4YU6iyPyQjD7zILpij9+UJ365XdLeBTw46AsUqe7IeBM/UjaRRH5FwohQDgLhGF8
	 gx9C/mBzpD70wmn2II4TgdA4/H1rW1fhUbRvYuH0GWaGk+PX4SIukmcdNgsAHjhoqq
	 +BvESSFtL+yA+iBCfdWSVba2VTYU9X4TAi0WyZQYRM4BWv8/cq8fg1Km7msT/K6eW6
	 rkvatM9WYr9yzUBKTAmqeA5ySxd+UMokSN0lgbFqtw0aUuUgrrKYzF6uKMiJ1CzJVN
	 xdJMm6+wa1rzg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79hM-00000006z5e-3mHa;
	Mon, 30 Mar 2026 12:18:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] can: refactor USB endpoint lookups
Date: Mon, 30 Mar 2026 12:18:15 +0200
Message-ID: <20260330101817.1664787-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7297-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78F5B359190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (2):
  can: kvaser_usb: leaf: refactor endpoint lookup
  can: ucan: refactor endpoint lookup

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 25 ++++--------
 drivers/net/can/usb/ucan.c                    | 40 +++++--------------
 2 files changed, 19 insertions(+), 46 deletions(-)

-- 
2.52.0


