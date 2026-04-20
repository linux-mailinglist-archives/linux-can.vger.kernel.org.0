Return-Path: <linux-can+bounces-7379-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCShHqZS5mkDuwEAu9opvQ
	(envelope-from <linux-can+bounces-7379-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 18:21:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3042F5FC
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 060F63229929
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380682D63E5;
	Mon, 20 Apr 2026 15:22:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727081FE471
	for <linux-can@vger.kernel.org>; Mon, 20 Apr 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698558; cv=none; b=pQzKw0tZYnVyvJz3vROrz7HQnXEmoxtPAOJd1HkDGjDNGao7ibc0FFYZi7jqwd1bw56Gs2a9yY3/by2yW5CCNCI/oVd/wwoNg3odmPKmdyMcVWujBe/H+pj4kRLLEWv9mjs9HXv3nORTvVKEtBrL+kyZ4MM2mV1HVgJX7MqtffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698558; c=relaxed/simple;
	bh=bKbUJziKMlCTqeI5iTH3mMY69zHWVi6WGpg51hCDuT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuCl6OfAvIZU8uuQusYrgCSkSbu9XQbunmfHAQ7vb06bsqVIC5ZuoI4YuzPK4TSSaXXe8fPnDUTUl4QZNiBv7mTW+DIEC/i2c4WuaRcCYvjPv85DLEf4s4rZjAGjTAAnvGf4UxpNhXOV27rQgWEdiBZq4F6iZkAiiswq2LLd1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-0000ba-7Q; Mon, 20 Apr 2026 17:22:30 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSD-006MEu-32;
	Mon, 20 Apr 2026 17:22:29 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSD-00000002RWm-3VZK;
	Mon, 20 Apr 2026 17:22:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] net: can: j1939: Add KUnit test infrastructure
Date: Mon, 20 Apr 2026 17:22:24 +0200
Message-ID: <20260420152228.581421-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7379-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: E7A3042F5FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

After getting one more fix for this stack, I decided to bootstrap a
KUnit test playground to allow anyone to extend it with minimal effort.

Currently it has minimal coverage and scratches on some of helper
functions. Better test coverage would be more intrusive - maybe I'll do
it in a different maintenance window.

The first two patches move some definitions to headers to make them
accessible for tests. The third patch adds the test infrastructure and
initial tests.

What's covered so far:
- Priority conversion between J1939 and sk_priority domains
- PGN validation and PDU format classification
- Socket address sanity checking
- Abort code to errno mapping
- Control message parsing for TP/ETP protocols
- Broadcast detection
- Session matching logic

Run with:
  ./tools/testing/kunit/kunit.py run --kunitconfig=net/can/j1939/tests

Oleksij Rempel (3):
  net: can: j1939: move j1939_xtp_abort enum to header
  net: can: j1939: move J1939_MIN_NAMELEN to shared header
  net: can: j1939: Add initial KUnit tests for socket and transport
    layers

 net/can/j1939/Kconfig                |  12 +
 net/can/j1939/Makefile               |   2 +
 net/can/j1939/j1939-priv.h           |  94 +++++
 net/can/j1939/j1939-test.h           |  69 ++++
 net/can/j1939/socket.c               |  43 ++-
 net/can/j1939/tests/.kunitconfig     |   5 +
 net/can/j1939/tests/Makefile         |   4 +
 net/can/j1939/tests/socket_test.c    | 301 +++++++++++++++
 net/can/j1939/tests/transport_test.c | 533 +++++++++++++++++++++++++++
 net/can/j1939/transport.c            | 142 +++----
 10 files changed, 1102 insertions(+), 103 deletions(-)
 create mode 100644 net/can/j1939/j1939-test.h
 create mode 100644 net/can/j1939/tests/.kunitconfig
 create mode 100644 net/can/j1939/tests/Makefile
 create mode 100644 net/can/j1939/tests/socket_test.c
 create mode 100644 net/can/j1939/tests/transport_test.c

--
2.47.3


