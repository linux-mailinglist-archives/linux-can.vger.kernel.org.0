Return-Path: <linux-can+bounces-8012-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ds4NHzUwTGoChgEAu9opvQ
	(envelope-from <linux-can+bounces-8012-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8371621F
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=eRkZN9do;
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8012-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8012-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77ECA3005164
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F72F7EF5;
	Mon,  6 Jul 2026 22:46:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241B1C84AB;
	Mon,  6 Jul 2026 22:46:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377968; cv=none; b=UkOIFh6+/fJ3zZJJyS+zbHyIjT1RPqoFF6W7i55xlOOD1GECSxlI0WdW3ODtoj085J7zFp1AakmzWCJnCnCGPhmLe/9LSsHBNa7cVO413ZuALMDBUdD+t2ah3NXcsf/qFfaCAfDTa4vwnzosFlQMF9RAJI9SAwP1krpZ3UeoB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377968; c=relaxed/simple;
	bh=P5VX72JfhNyXyN1aJzEHw3bYsH5xUjM/meb/7OlsvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LcB/wPFtc9jtgi7tJTOaKXNMZrllnxHy74YIhrYbwvVH5faZSC+/QQYnmQV9b5JgnRhSyw/b2fmrcD1nkk3HXS1NocbMLcprJ8eSaYAqYsJ+W73tHHpdjqNkoVGKPktHDGS6TWPJJ0nRe2+Ab2m25PkQK+tzFB3YWabMgWnc2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=eRkZN9do; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783377964; x=1783982764;
	i=alexander.hoelzl@gmx.net;
	bh=j47bK5IsKZZUVnHiuuPCe9ziawchsYZLoICkUe8L68o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eRkZN9doGLQH5rrocvGVR89vae5vLDIM9/CWO/PYrd08650PFT41RX8GViFZDlWo
	 +E1/gNqNZGjhjBpbFCymYCLJ12q1qj5ZI2dS2RpGpLbSGltZXTX58E4vEVlwUSj9s
	 HutkaYGrNGi4e8BY5KqcgHfrMUawjnvGALaWiSUZUXbfYkcp3HpuQShZJOaglc3L5
	 DqpPRQ0BIWH4UrIBWip783pOkr6mjRYEbACFwn6O4A9Ic9krwtc4Cd39jUF9pUBOH
	 W+u7WupiH2cSbtFpi5bkEIe6K1qX6ZWVOWkU91nab6+rPMX4VtOzcv6iTvBuh5upq
	 7+jXc7SGla/mAWlSMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1wb7rD0pqN-00VGj1; Tue, 07
 Jul 2026 00:46:04 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v4 1/3] j1939: restrict amount of consecutive retransmission requests
Date: Tue,  7 Jul 2026 00:41:05 +0200
Message-ID: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8cfDkrAUHuHEKxHAOtIuR042e4jsEFxTrMErv8wMCPs31ykUku/
 ev5SNBhCF0q2FueJDy5vOKXbUUhlLXyI4P8hKuSBjUljy6675kkIkNzEUCWrH6YGHM36w47
 kuh9V9+8hq9vAULnGMyYwCm/VPRwsQ8sEfjm+XL+ZCgZoaEfaW3hfEfgrJtn9IFpOUDyRgh
 lq/yhCndQQYnl7U6Kfjlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hKpRV5WLjYM=;iT4pYHR/PGoTzyr28PJXNtTfYzu
 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
 NkiRAsVTmOe9Ldjij2iPbPEVmA/XcDYNjnXvlUe
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-8012-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DA8371621F

In J1939 segmented messages the receiver of a segmented message
can request the retranmission of sent data frames. In the current
implementation there was no limit on the amount of consecutive
retransmission requests which were allowed. The standard states
that after two retransmission requests (so three transmissions
in total) the connection should be aborted with reason 5,
'maximum retransmit request limit reached'.
See SAE J1939-22 2025: 5.10.3.2 Connection Mode Clear to Send
and 5.12.3 Device Response Time and Timeout Defaults.

This commit introduces a retransmit counter and aborts the segmented
data transfer if the retransmit limit is reached.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
Hello,
sorry I was also a bit slow, I survived the heatwave now I can do
something again :)

I've added an additional commit to introduce the retransmit counting
as discussed in the previous review. I've added additional tests to
test the retransmit abort as well as the abort on requesting an=20
already acked frame.
I've also renamed the tests from cts_hold to=20
rx_cts as they now also test other parts of the rx_cts path so I though
they should have a more generic name.

I've added the comments and fixed the spelling mistakes, I hope I did
not add any new ones.

 net/can/j1939/j1939-priv.h |  2 ++
 net/can/j1939/transport.c  | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 81f58924b4ac..16867d803092 100644
=2D-- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -285,6 +285,8 @@ struct j1939_session {
 		unsigned int block;
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
 		unsigned int dpo;
+		/* retransmits - amount of received retransmit requests (including hold=
s) */
+		unsigned int retransmits;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
 };
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..6f999b18bbca 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -32,6 +32,14 @@
 #define J1939_ETP_CMD_EOMA 0x17
 #define J1939_ETP_CMD_ABORT 0xff
=20
+/* Maximum amount of transmission attempts for a given packet number to
+ * be sent. According to SAE J1939-21 2022 - 5.12.3 Device Response Time =
and
+ * Timeout Defaults there should be no more than 2 retries (3 requests in=
 total)
+ * before the connection is aborted with reason 5 which corresponds to
+ * J1939_XTP_ABORT_FAULT in this implementation.
+ */
+#define J1939_CTS_MAX_NUM_TRANSMITS 3
+
 enum j1939_xtp_abort {
 	J1939_XTP_NO_ABORT =3D 0,
 	J1939_XTP_ABORT_BUSY =3D 1,
@@ -1457,6 +1465,19 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
 struct sk_buff *skb)
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
=20
+	/* If the 'next packet number to be sent' in the CTS is smaller or
+	 * equal to an already sent packet it is a retransmit request.
+	 */
+	if (session->pkt.tx >=3D pkt) {
+		session->pkt.retransmits++;
+		if (session->pkt.retransmits >=3D J1939_CTS_MAX_NUM_TRANSMITS) {
+			err =3D J1939_XTP_ABORT_FAULT;
+			goto out_session_cancel;
+		}
+	} else {
+		session->pkt.retransmits =3D 0;
+	}
+
 	/* set packet counters only when not CTS(0) */
 	session->pkt.tx_acked =3D pkt - 1;
 	j1939_session_skb_drop_old(session);
@@ -1669,6 +1690,7 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j=
1939_priv *priv,
=20
 	session->pkt.rx =3D 0;
 	session->pkt.tx =3D 0;
+	session->pkt.retransmits =3D 0;
=20
 	session->tskey =3D priv->rx_tskey++;
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);
=2D-=20
2.55.0


