Return-Path: <linux-can+bounces-8013-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I5RzFUYwTGoJhgEAu9opvQ
	(envelope-from <linux-can+bounces-8013-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDBC71623B
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=FARxVpXt;
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8013-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8013-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B42303CE86
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C938B7BD;
	Mon,  6 Jul 2026 22:46:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01141CAA6C;
	Mon,  6 Jul 2026 22:46:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377969; cv=none; b=b5tgozLigkn1MzB92ajHgoTcWuI1l8FqPTMvn/nWYRoR0seSDeRjXaMUpKgAl+AXqPYYVpiFAY+6rdR/RBHPHdhB7EiWwoTBF2nCrVq20QlCD0EWOtyDORHgoj7LddjQts8/XpXnKebj4o/nVnDyitOv5a2OhLS6QUF8TEzocJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377969; c=relaxed/simple;
	bh=FSBYK1ubk4SuBGiaHNM6OZkUIHkOZBAmJh/i7K1n+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGpj2dF3WU6bmWVScY1uf4G2zwXbZAZ2DbbgtgdR8AwXk1xo6SrcMQC1DSUR5XeH0hPOUO1HwudCDSAAGQVdaqU0xDd6HENNTNmOR47So0MdHAH1VhtA4TbpJ4WJQUQj9du73NqMHXeonioiYBgs5UdSOnWEyX2N1nItgH2V71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=FARxVpXt; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783377966; x=1783982766;
	i=alexander.hoelzl@gmx.net;
	bh=JkhQ2CHsKjObK2ZcnUPh5Y8I4xsXnmeLeZhhaa8+J3k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FARxVpXt3/QDjT4qisNrqHKlh3YzyiFCu4U52uDkyFc6654p5ImoERzDN9g4t2cm
	 xvpdqzB35/DlPCFShI7Hl/0bG3AP8OvIpqAra4akNlRoiVkmuwlQT1G/2tCW5CVHH
	 mFy+dayzZtKo8qgyGVRdAns8VRM8RLLrr4wJQqwZBpCc5MlnLhGU/Fez1jVbRoXxC
	 d50SVcDk7g8Me6Nf41D/NhH+JsVz4aGsoJT9D/ueERogIDOq7EdYSIA/MsdWOzpbR
	 31w0/02/zvlBjdEjb6y2HXhxt2WxuVvkVmpZRtNofcnqgvBNT89zyP6BtO3HhOGNx
	 EUoaBquJDrTQWH/gKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1wRoCV0N45-00Myz7; Tue, 07
 Jul 2026 00:46:06 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v4 2/3] j1939: fix implementation not handling holds correctly
Date: Tue,  7 Jul 2026 00:41:06 +0200
Message-ID: <20260706224548.100451-2-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kxQqd97lVd3M5C2UQIGcDWun4r6MxDpFK1gUzXJPT/7l7weyJA6
 5w/NDAziaxq2c0gAMcNJ/mv8g0y5RfzN9g8MH3LDoIDNp++ieoc/to5RR7zoz7gxu8zEYuh
 wRA4J09mhoqL+yb3nM8uDDEDLpjvGj5M/+oE2+qOnk7Ez21f8Y0zfGsxl9zZSTUCVrpIGgs
 oy+7YeBEibUcfmLicZjxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b60M9sFRI6Q=;Kxiso5rlvQJjWaX78z6g/3B2/x5
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:robin@protonic.nl,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8013-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonic.nl,vger.kernel.org,pengutronix.de,gmx.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FDBC71623B

The J1939 protocol allows the receiver of directed segemented messages
to hold the data transfer. The kernel implementation did not handle hold
messages correctly was not able to resume from a hold.

To do so the behavior of j1939_xtp_rx_cts_one was modified to allow the
handling of a hold. The previous sanity check was removed as it only
guarded against a flood of consecutive CTS, but prevented the hold
from working correctly. This patch changes this behavior to allow
for consectuive CTS to enable holds. An additional sanity check
has been added which prevents requsts of already transferred and
acked packets. In this case the kernel will abort immediately
instead of going into a timeout.

Fix J1939 RTS/CTS session not being able to resume from hold.
Replace hardcoded timeout with define.
Add CTS hold behavior tests.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/transport.c | 70 +++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 6f999b18bbca..ae0dc0a0168a 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -39,6 +39,12 @@
  * J1939_XTP_ABORT_FAULT in this implementation.
  */
 #define J1939_CTS_MAX_NUM_TRANSMITS 3
+/* Time until session invalidation upon reception of a hold message.
+ * Corresponds to T4 in the specification.
+ * See ISO 11783-3 2018 - 5.10.3.5 Connection closure
+ * and SAE J1939-21 2022 - 5.10.2.4 Connection Closure
+ */
+#define J1939_CTS_HOLD_TIMEOUT_MS 1050
=20
 enum j1939_xtp_abort {
 	J1939_XTP_NO_ABORT =3D 0,
@@ -1436,6 +1442,16 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struct s=
k_buff *skb,
 	j1939_session_put(session);
 }
=20
+/* See:
+ * SAE J1939-21 2022 - 5.10.2.3 Data Transfer
+ * ISO 11783-3 2018 - 5.11.5.4 Extended Connection Mode Clear To Send (ET=
P.CM_CTS)
+ * The number of packets to send can be set to 0 to hold the connection
+ */
+static inline bool j1939_cts_is_hold(const struct sk_buff *skb)
+{
+	return (!skb->data[1]);
+}
+
 static void
 j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 {
@@ -1450,9 +1466,27 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
 struct sk_buff *skb)
=20
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
=20
-	if (session->last_cmd =3D=3D dat[0]) {
-		err =3D J1939_XTP_ABORT_DUP_SEQ;
-		goto out_session_cancel;
+	session->last_cmd =3D dat[0];
+
+	if (j1939_cts_is_hold(skb)) {
+		/* The originator should abort the session after T4 (=3D< 1050ms):
+		 *   SAE J1939-21 2022 - 5.10.2.4 Connection Closure
+		 *   a lack of a CTS for more than (T4) seconds after a CTS (0) message=
 to
+		 *   hold the connection open" will all cause a connection closure to o=
ccur.
+		 *
+		 * The receiver should send followup CTS not later then Th (=3D< 500ms)=
:
+		 *   SAE J1939-21 2001 - C.1 Connection Mode Data Transfer
+		 *   The responder station then issues a TP.CM_CTS indicating that it w=
ants
+		 *   to hold the connection open but cannot receive any packets right n=
ow. A
+		 *   maximum of 500 ms later it must send another TP.CM_CTS message to =
hold
+		 *   the connection.
+		 */
+		if (session->transmission)
+			j1939_session_txtimer_cancel(session);
+
+		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);
+		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __func_=
_, session);
+		return;
 	}
=20
 	if (session->skcb.addr.type =3D=3D J1939_ETP)
@@ -1465,10 +1499,18 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
, struct sk_buff *skb)
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
=20
+	/* According to J1939-82 table A7 row 6 the connection should be aborted
+	 * if the 'next packet number to be sent' in the CTS message is less tha=
n
+	 * the 'next packet number to be sent' in the previous message.
+	 */
+	if (session->pkt.tx_acked >=3D pkt) {
+		err =3D J1939_XTP_ABORT_DUP_SEQ;
+		goto out_session_cancel;
+	}
 	/* If the 'next packet number to be sent' in the CTS is smaller or
 	 * equal to an already sent packet it is a retransmit request.
 	 */
-	if (session->pkt.tx >=3D pkt) {
+	else if (session->pkt.tx >=3D pkt) {
 		session->pkt.retransmits++;
 		if (session->pkt.retransmits >=3D J1939_CTS_MAX_NUM_TRANSMITS) {
 			err =3D J1939_XTP_ABORT_FAULT;
@@ -1488,19 +1530,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
, struct sk_buff *skb)
 	/* TODO: do not set tx here, do it in txtimer */
 	session->pkt.tx =3D session->pkt.tx_acked;
=20
-	session->last_cmd =3D dat[0];
-	if (dat[1]) {
-		j1939_tp_set_rxtimeout(session, 1250);
-		if (session->transmission) {
-			if (session->pkt.tx_acked)
-				j1939_sk_errqueue(session,
-						  J1939_ERRQUEUE_TX_SCHED);
-			j1939_session_txtimer_cancel(session);
-			j1939_tp_schedule_txtimer(session, 0);
-		}
-	} else {
-		/* CTS(0) */
-		j1939_tp_set_rxtimeout(session, 550);
+	j1939_tp_set_rxtimeout(session, 1250);
+	if (session->transmission) {
+		if (session->pkt.tx_acked)
+			j1939_sk_errqueue(session,
+						J1939_ERRQUEUE_TX_SCHED);
+		j1939_session_txtimer_cancel(session);
+		j1939_tp_schedule_txtimer(session, 0);
 	}
 	return;
=20
=2D-=20
2.55.0


