Return-Path: <linux-can+bounces-7701-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGfiJ82eFGoLPAcAu9opvQ
	(envelope-from <linux-can+bounces-7701-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 21:11:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD85CDF35
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469D2300E391
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271D385D79;
	Mon, 25 May 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="ZIJ8Witc"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598C37CD53;
	Mon, 25 May 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736233; cv=none; b=Ug2N3sTh7IlcPBs8HpmvUDXCSn/d33yMYkOG+UZb1nH516LaQ1ehxFaaz9vCdPM0ywTS7ZIilha+CwYCiLUki90NvTTzitd23C4Z6qElj1GIfStctAe230j6CCJgGc1DojVVxiC9tNlgjMaFyn0BXX+EHSX3SLuvdj6dLisI2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736233; c=relaxed/simple;
	bh=j6TtPZIwygCYSwj2hsswtI0LNcGQJtEimUrgu0y17GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnp4XU2/7C/lSe1mzIm43zn8HZV6wHc60dlUh+U7kjcxb1nUn0vPYg3BWC64w2+jIFHPY9jWQXomQh1aeyWjpkjnBMSHrj9mpFhWrEaUcP5YZCMIduFSE7YlqbPpJM3fTnV6vnmXeRhxt8I6KY39z4rGq29MEreJU/AK0FISabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=ZIJ8Witc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779736227; x=1780341027;
	i=alexander.hoelzl@gmx.net;
	bh=0Aa0Pc47Z3GORKsLW2I162WQpy+Pmhsa9vgIaYAuVvc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZIJ8WitcfWPe/tyb/hn/QQxg/PRGlj1GZw3bkdCn0+ImoptkiA6Dy1DuKJc+ORkT
	 9w2YiRWF0HqcmjqFIRUQoHT6N4u58716eP1B8yPt/ZLn/kvYtPMYHG3BBJl6oAyY/
	 yt/PJHhkaYfUAK5O14iaQeFtR2UlNssbRW1me0T0ZVqX3gLtv7Btaw39UoodOxiuK
	 /PLsp1nqLjFHRWfIDBK7AlzstQL/+gg9WMqKJAZUT+znlfDwPr+Go03426x23qEX2
	 DcN0NC86m63qn1tPmM5Lhj+BThmeLWgnJftwlPHc2TbrRYQ0/fVDpyXw5C5KGPbBd
	 nF3zPBHIaPKcjEWquQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1wmH2e2Gnz-00QFPt; Mon, 25
 May 2026 21:10:27 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v3 1/2] Fix J1939 implementation not handling holds correctly
Date: Mon, 25 May 2026 21:08:48 +0200
Message-ID: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+T6AeYbstrmFaM0PWt/FAliE5FJ0yttjffLUBh86a15w0Zo75ca
 vnsSx8SL7yumOqYaVjvf9WPqCM3GrBFVr0uKEEctnK8PTDKQFo3v5RWED4AvWNv8A2KU8mq
 X5llOKioxJMaJD4IYR4Ucr6lqv5Z8DVL9zJ8fOEmKo3uElsWCbGYBj2/qhSDGmYpbL0OBzT
 yWtpcGNnVMzjVjrUAoVjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MYR+90VdshQ=;wuVhpkZOExb5HKo7H6s44RCtNsl
 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
 sX5uVTD/Q=
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7701-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[protonic.nl,vger.kernel.org,pengutronix.de,gmx.net];
	DKIM_TRACE(0.00)[gmx.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05CD85CDF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
I've integrated the comments you've send. In one of the comments you've=20
referenced a wrong section of the J1939 standard. For the hold message
you've referenced SAE J1939-21 2001 - 5.10.2.4 Connection Closure,
but it should have been SAE 5.102.2.3 Data Transfer. That I have
changed. Otherwise everything should be according to your comments :)

 net/can/j1939/transport.c | 68 +++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..e2c79df7b04e 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -32,6 +32,13 @@
 #define J1939_ETP_CMD_EOMA 0x17
 #define J1939_ETP_CMD_ABORT 0xff
=20
+/* Time until session invalidation upon reception of a hold message.
+ * Corresponds to T4 in the specification.
+ * See ISO 11783-3 2018 - 5.10.3.5 Connection closure
+ * and SAE J1939-21 2022 - 5.10.2.4 Connection Closure
+ */
+#define J1939_CTS_HOLD_TIMEOUT_MS 1050
+
 enum j1939_xtp_abort {
 	J1939_XTP_NO_ABORT =3D 0,
 	J1939_XTP_ABORT_BUSY =3D 1,
@@ -1428,6 +1435,16 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struct s=
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
@@ -1442,9 +1459,28 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
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
+		 *
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
@@ -1457,7 +1493,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
 struct sk_buff *skb)
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
=20
-	/* set packet counters only when not CTS(0) */
+	if (session->pkt.tx_acked >=3D pkt) {
+		err =3D J1939_XTP_ABORT_DUP_SEQ;
+		goto out_session_cancel;
+	}
+
 	session->pkt.tx_acked =3D pkt - 1;
 	j1939_session_skb_drop_old(session);
 	session->pkt.last =3D session->pkt.tx_acked + dat[1];
@@ -1467,19 +1507,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
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
2.54.0


