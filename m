Return-Path: <linux-can+bounces-7377-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJDRE9hG5mk+uAEAu9opvQ
	(envelope-from <linux-can+bounces-7377-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 17:31:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48242E416
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 304453003608
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549B26AA91;
	Mon, 20 Apr 2026 15:22:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A822475CF
	for <linux-can@vger.kernel.org>; Mon, 20 Apr 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698557; cv=none; b=OuWJSeZVxNU4N9BmWzt5+5lGdt3JZdQxLNIrRsGgwKeYEUCcjIQY1OgddUBrbN74xSErKINRNM0HG2tdxX/3TlST9KkmWrFCrOWmDh3dgmB8+oaevTyLFEui+z8Hijvry59CSg1VXwwIz6FleA5MXDhvwMNOLpeMs5wacsUWxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698557; c=relaxed/simple;
	bh=0KaerXIyJN3eXCD1YIorjpzmF1dKF4uSJl0beyOMDpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlmT8QLijxv7ovhPt9yJpXZFH+SsyQdycRkpqwb3Vy25xJVYbjwTWeDWjMnXHt3Gmtm19Fg/AxOI3/Qxt5JHCwU06pKTWQw4wYQy7QxaBNWOuZ7+JADpq7D73wf78Nf8Ehh0Vk2rJ4iiRk4v0+DU/zVISKzWnuV6EJN67CyGAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-0000bd-7P; Mon, 20 Apr 2026 17:22:30 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSD-006MEv-3D;
	Mon, 20 Apr 2026 17:22:30 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSD-00000002RXM-3o1c;
	Mon, 20 Apr 2026 17:22:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] net: can: j1939: move j1939_xtp_abort enum to header
Date: Mon, 20 Apr 2026 17:22:25 +0200
Message-ID: <20260420152228.581421-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420152228.581421-1-o.rempel@pengutronix.de>
References: <20260420152228.581421-1-o.rempel@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-7377-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DB48242E416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move j1939_xtp_abort to j1939-priv.h to allow KUnit tests to reference
transport abort codes.

No functional change.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 92 ++++++++++++++++++++++++++++++++++++++
 net/can/j1939/transport.c  | 91 -------------------------------------
 2 files changed, 92 insertions(+), 91 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 81f58924b4ac..b82706505103 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -28,6 +28,98 @@ enum j1939_sk_errqueue_type {
 	J1939_ERRQUEUE_RX_ABORT,
 };
 
+/* J1939 Transport Protocol Abort Codes */
+enum j1939_xtp_abort {
+	J1939_XTP_NO_ABORT = 0,
+	J1939_XTP_ABORT_BUSY = 1,
+	/* Already in one or more connection managed sessions and
+	 * cannot support another.
+	 *
+	 * EALREADY:
+	 * Operation already in progress
+	 */
+
+	J1939_XTP_ABORT_RESOURCE = 2,
+	/* System resources were needed for another task so this
+	 * connection managed session was terminated.
+	 *
+	 * EMSGSIZE:
+	 * The socket type requires that message be sent atomically,
+	 * and the size of the message to be sent made this
+	 * impossible.
+	 */
+
+	J1939_XTP_ABORT_TIMEOUT = 3,
+	/* A timeout occurred and this is the connection abort to
+	 * close the session.
+	 *
+	 * EHOSTUNREACH:
+	 * The destination host cannot be reached (probably because
+	 * the host is down or a remote router cannot reach it).
+	 */
+
+	J1939_XTP_ABORT_GENERIC = 4,
+	/* CTS messages received when data transfer is in progress
+	 *
+	 * EBADMSG:
+	 * Not a data message
+	 */
+
+	J1939_XTP_ABORT_FAULT = 5,
+	/* Maximal retransmit request limit reached
+	 *
+	 * ENOTRECOVERABLE:
+	 * State not recoverable
+	 */
+
+	J1939_XTP_ABORT_UNEXPECTED_DATA = 6,
+	/* Unexpected data transfer packet
+	 *
+	 * ENOTCONN:
+	 * Transport endpoint is not connected
+	 */
+
+	J1939_XTP_ABORT_BAD_SEQ = 7,
+	/* Bad sequence number (and software is not able to recover)
+	 *
+	 * EILSEQ:
+	 * Illegal byte sequence
+	 */
+
+	J1939_XTP_ABORT_DUP_SEQ = 8,
+	/* Duplicate sequence number (and software is not able to
+	 * recover)
+	 */
+
+	J1939_XTP_ABORT_EDPO_UNEXPECTED = 9,
+	/* Unexpected EDPO packet (ETP) or Message size > 1785 bytes
+	 * (TP)
+	 */
+
+	J1939_XTP_ABORT_BAD_EDPO_PGN = 10,
+	/* Unexpected EDPO PGN (PGN in EDPO is bad) */
+
+	J1939_XTP_ABORT_EDPO_OUTOF_CTS = 11,
+	/* EDPO number of packets is greater than CTS */
+
+	J1939_XTP_ABORT_BAD_EDPO_OFFSET = 12,
+	/* Bad EDPO offset */
+
+	J1939_XTP_ABORT_OTHER_DEPRECATED = 13,
+	/* Deprecated. Use 250 instead (Any other reason)  */
+
+	J1939_XTP_ABORT_ECTS_UNXPECTED_PGN = 14,
+	/* Unexpected ECTS PGN (PGN in ECTS is bad) */
+
+	J1939_XTP_ABORT_ECTS_TOO_BIG = 15,
+	/* ECTS requested packets exceeds message size */
+
+	J1939_XTP_ABORT_OTHER = 250,
+	/* Any other reason (if a Connection Abort reason is
+	 * identified that is not listed in the table use code 250)
+	 */
+};
+
 /* j1939 devices */
 struct j1939_ecu {
 	struct list_head list;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..46540da76ca9 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -32,97 +32,6 @@
 #define J1939_ETP_CMD_EOMA 0x17
 #define J1939_ETP_CMD_ABORT 0xff
 
-enum j1939_xtp_abort {
-	J1939_XTP_NO_ABORT = 0,
-	J1939_XTP_ABORT_BUSY = 1,
-	/* Already in one or more connection managed sessions and
-	 * cannot support another.
-	 *
-	 * EALREADY:
-	 * Operation already in progress
-	 */
-
-	J1939_XTP_ABORT_RESOURCE = 2,
-	/* System resources were needed for another task so this
-	 * connection managed session was terminated.
-	 *
-	 * EMSGSIZE:
-	 * The socket type requires that message be sent atomically,
-	 * and the size of the message to be sent made this
-	 * impossible.
-	 */
-
-	J1939_XTP_ABORT_TIMEOUT = 3,
-	/* A timeout occurred and this is the connection abort to
-	 * close the session.
-	 *
-	 * EHOSTUNREACH:
-	 * The destination host cannot be reached (probably because
-	 * the host is down or a remote router cannot reach it).
-	 */
-
-	J1939_XTP_ABORT_GENERIC = 4,
-	/* CTS messages received when data transfer is in progress
-	 *
-	 * EBADMSG:
-	 * Not a data message
-	 */
-
-	J1939_XTP_ABORT_FAULT = 5,
-	/* Maximal retransmit request limit reached
-	 *
-	 * ENOTRECOVERABLE:
-	 * State not recoverable
-	 */
-
-	J1939_XTP_ABORT_UNEXPECTED_DATA = 6,
-	/* Unexpected data transfer packet
-	 *
-	 * ENOTCONN:
-	 * Transport endpoint is not connected
-	 */
-
-	J1939_XTP_ABORT_BAD_SEQ = 7,
-	/* Bad sequence number (and software is not able to recover)
-	 *
-	 * EILSEQ:
-	 * Illegal byte sequence
-	 */
-
-	J1939_XTP_ABORT_DUP_SEQ = 8,
-	/* Duplicate sequence number (and software is not able to
-	 * recover)
-	 */
-
-	J1939_XTP_ABORT_EDPO_UNEXPECTED = 9,
-	/* Unexpected EDPO packet (ETP) or Message size > 1785 bytes
-	 * (TP)
-	 */
-
-	J1939_XTP_ABORT_BAD_EDPO_PGN = 10,
-	/* Unexpected EDPO PGN (PGN in EDPO is bad) */
-
-	J1939_XTP_ABORT_EDPO_OUTOF_CTS = 11,
-	/* EDPO number of packets is greater than CTS */
-
-	J1939_XTP_ABORT_BAD_EDPO_OFFSET = 12,
-	/* Bad EDPO offset */
-
-	J1939_XTP_ABORT_OTHER_DEPRECATED = 13,
-	/* Deprecated. Use 250 instead (Any other reason)  */
-
-	J1939_XTP_ABORT_ECTS_UNXPECTED_PGN = 14,
-	/* Unexpected ECTS PGN (PGN in ECTS is bad) */
-
-	J1939_XTP_ABORT_ECTS_TOO_BIG = 15,
-	/* ECTS requested packets exceeds message size */
-
-	J1939_XTP_ABORT_OTHER = 250,
-	/* Any other reason (if a Connection Abort reason is
-	 * identified that is not listed in the table use code 250)
-	 */
-};
-
 static unsigned int j1939_tp_block = 255;
 static unsigned int j1939_tp_packet_delay;
 static unsigned int j1939_tp_padding = 1;
-- 
2.47.3


