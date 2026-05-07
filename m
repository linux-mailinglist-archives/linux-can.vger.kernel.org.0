Return-Path: <linux-can+bounces-7545-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCcUGJJe/Gm7OwAAu9opvQ
	(envelope-from <linux-can+bounces-7545-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:42:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AA4E62C1
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1C830A2FEE
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675737EFF8;
	Thu,  7 May 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UEdAhLba"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4238E5C4;
	Thu,  7 May 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146509; cv=none; b=bnOUouL9C1iywY062/OY/fDpH5mnlHTs9Wr+fuAU+eJbaZypjAXAPe3PLSum5NiEvH2CMMcXrcFhteFI0toK86KVemheNlUuH33nizj5N6QYraS91PnaU8IW6CqJtMJLK/XmqrXvZ/Tk63utiXSawTdXJxKrTWcLLBEvjnkjoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146509; c=relaxed/simple;
	bh=aKxjIaUVYLeuZ9wZOqjFB8vbItWZowPYMT3xt9DWBQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QAU6XTCw5NM2n+tPlLFwZgJYL9KPTSaFlbxd19IkInPjqbYx5iRf4flREplFU0tvs3e1bLMhsWBkAHOR2+ql2rH0CvM25htUIhaXPTKhRb7A3qjKgFHE0HbEwcpnGFX5xB1XtqDYOOrpiBvgbpGPG6C8PAc0KpjRbLZLBYdXmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UEdAhLba; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=co++dwGpg1JLB5EFHVUYj+mdPBKnS9rmaq2w7Ak1J+o=; b=UEdAhLbappj+45Ce/7tEnsNdYI
	0eBXcmOI1e2Y013XAfJCDFjWNzWw+IV6s4QvApfebFMbj0fft9VCpUe8pAWczbooC5r/Hi73BwBLZ
	z0dfXnYaKwsp9TzeTbARRPvwg6eVdJBIRUgBk4eKkFZPu++DqJT7auURGEq2MsG6Ji7dKRYhbUAC4
	fG6aTRl676ZlgiPflXF1wgEyri8QGLzMXKSceGoRr8ORh2BrhqveUG3R1x5FnrM6gYNO/KAGmI/uu
	f4y8lsixGRRn6BA2NXr3WKQEuM5pGC0kDeWcJwkzHMQ6wEu/NMEylpDaRiNOS/rIYVtCJbvO0OME9
	DRjYZZgQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKv8J-004Gun-0p;
	Thu, 07 May 2026 09:35:03 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: convert remaining CAN protocols to
 getsockopt_iter
Date: Thu, 07 May 2026 02:34:46 -0700
Message-Id: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZc/GkC/yXM0QqCMBQG4Fc5/NcO5kqrvUqE6DzaKdhiO5Ugv
 ntU1x98Kwpn4QJPKzK/pEiK8FRXhHDt48xGRniCs661jT2YmbWkcO/0nbrQR9OMu9buh/p0dBM
 qwiPzJMtvPCOymsiL4vKX8hxuHPQbYts+Dy3wPn0AAAA=
X-Change-ID: 20260507-getsock_two_can-5d3604b1982f
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=leitao@debian.org;
 h=from:subject:message-id; bh=aKxjIaUVYLeuZ9wZOqjFB8vbItWZowPYMT3xt9DWBQg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/FzDN1dBkCnAgTzTadfb2z64AkRPQyHx7CMgE
 YopichySZyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxcwwAKCRA1o5Of/Hh3
 bZRkD/oDc4V19GzWxCz8XPpZeB1jsL+v/vy3IFam8MDnUKipYTzPdt4e1H9+/Siq+xNgXiQWKXT
 pUuXG1Zm3WtevginPGpABVb8opj6PgnKIYaqWBLCs7nCy34ivB6ubNkGIfhK4rvkxd8UxAYsaA2
 doZuRCBf43cI9Pix7WD+KzBVj7Jf6qVUgQDW8UEdGnUaYXj5LdmLch8GcmEgej4ADdfkmb4XPVW
 9+Gt6A8ig0q1loC7LeLJ5PxmlTYJeDpqVmNKW0+Lq4Yb25NG6nFUVBoYsqFnIWGhq0Ey/KknZTB
 X1TqaDy9a2U5T28nznU8Da/MNYyC/iI5TL1UiJPx1u/RZYbA+EusFT7jBGk7XcSvAzDIjfSMaDy
 wz+mJwvf57JxjQK5Pu8HLYRVyVBU7ZGqI8tOTlncC+eIMEjyZIW0qEhKkwwUpy7+v3iwZIu4hPD
 pTAC1X+w0CzFoDWrdQVGct3bjKxk+XdgiVDu3IETLbmZacit970VX55NbO16Mhj3N9ecB/T/49I
 +RxtMIIXaCkW+E7HJ/h1vzq/nun3vXPao5G69lAp4hheC2/9nq2fKd0iCT9FAaCFe8oGZukEBsP
 /eNJqsAbz9Cej5SQMnx/YUOHJNUvDnkGUVcVo2XMaGZzJRvTKj5jFLgGGH8AL1wIZ8XaZhwJGnY
 X9wwYfboyQPqXwQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: AE6AA4E62C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7545-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Continue the conversion of socket protocols to the new getsockopt_iter
API by covering the two remaining CAN implementations:

  - isotp (CAN ISO-TP)
  - j1939 (SAE J1939)

With these, all CAN protocols that expose a getsockopt callback (raw,
isotp, j1939) now use .getsockopt_iter; raw was converted as part of
an earlier series.

These are mechanical, ABI-preserving conversions following the same
pattern as previously converted protocols (af_packet, can/raw,
af_netlink, af_vsock):

  - The (char __user *optval, int __user *optlen) pair is replaced with
    a single sockopt_t *opt that carries the buffer length on input and
    the returned size on output, and exposes an iov_iter for the
    copy-out path.
  - put_user()/copy_to_user() pairs are replaced with a single
    copy_to_iter() per option.
  - The wrapper in do_sock_getsockopt() handles writing optlen back to
    userspace.

No functional or ABI change is intended.

For more context about the motivation for this change, please check
commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")

---
Breno Leitao (2):
      can: j1939: convert to getsockopt_iter
      can: isotp: convert to getsockopt_iter

 net/can/isotp.c        | 12 +++++-------
 net/can/j1939/socket.c | 21 +++++++++++++--------
 2 files changed, 18 insertions(+), 15 deletions(-)
---
base-commit: dacf281771a9aed1a723b196120a0de8637910b9
change-id: 20260507-getsock_two_can-5d3604b1982f

Best regards,
--  
Breno Leitao <leitao@debian.org>


