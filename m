Return-Path: <linux-can+bounces-7807-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id phHwCWMtKWoSSAMAu9opvQ
	(envelope-from <linux-can+bounces-7807-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:24:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76488667CE3
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:24:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=OJX9qY8+;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7807-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7807-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF12327BC86
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB03B71D0;
	Wed, 10 Jun 2026 09:06:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A23B42FB;
	Wed, 10 Jun 2026 09:06:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082387; cv=none; b=enoPpN76JaXK6uyp6UDtJ/zQfqiI0TaXlJSzQfH1tv3BbZDfn7y/Iu+EQ6e2o6i5jsIKQTa3nIyojx/aURg6lGjhRGzJvBTsDaul2IPa1QfpQFueYXUCtlCTZmut/7NG9QUpgs1BOzrQPL1SYNg8eGHQHrcm6sd4b3zEAI5BSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082387; c=relaxed/simple;
	bh=oDEK3g1uiLe9D3ho3wPuEwG5SbZHBZ8gtOjHLsjSnQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmL/T+BV11ePlQLC6DYImq/ic32+QrJL209AxSQaV2ZnnSAT2feDfk67+JKpCExLRILu9/Mb+/sMxRH0KhfNFWvYORB5RPnTP5AYMB8bqgStzop5B3Nd43inVyWeC7iDzMkS7OS0o4EQvaw7NNAOXblvGk5kMTY1mZyIXpvXeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=OJX9qY8+; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1781082382; x=1781687182;
	i=alexander.hoelzl@gmx.net;
	bh=L8C77VU0ER9OXmYMQEKDRz6Xpcv2acU1zJVAgy28Rig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OJX9qY8+vs2JtUsHDlsamuMUq1pIeb3jL/SPl0Iw7Vzv2zkHNv99c3Egp0LEWr0m
	 +oV70VUplZaw6ea68JlvL2hcYvUdu4xg/IF08IDgkY1F2Rz92Qh6l11HXzkUMPYFh
	 nkx0AQhicZffLRajx5b2U0O8O16S/kZEAbioaKUK1D2NBBLmmjIc93hILt+JKPAGT
	 MD1pSNCQPLyGMBvVCKRn6+Mn10tzHTFlDow7TW730wBWuH5z4F1WW1sQ5SoScwnqu
	 EUqPR+Ti53nP0ISdantmC/iIcUTs2/o4g65HBtcSnNHz8C41N51pwVMZxxTUFLwCK
	 RqAz3wOuWEspMw1BPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1wzOi80KYQ-00kqro; Wed, 10
 Jun 2026 11:06:22 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH] can: j1939: fix potential race condition in BAM segmentation
Date: Wed, 10 Jun 2026 11:06:19 +0200
Message-ID: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3BATeaAz5MVVgryh01yMa9bzKyZl1zgujgr0rzU6Jeoc15NlWJ
 FNix+MM53/iVkAbLJgc8GJNilX1dFb0nnVNzo5Bx5pQr01/WEWjPgjLRDIK1ExQWv1FUnKq
 S7VeSJFjZfNgysO7XuYCKqfsrv2DdXRnl8PrKHt2Gx3YLUBdNqSR+Qgsmy8n6r7fvYEuprw
 G08UVEgwaA2hWfAUZuF/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ft+xZtgRlY=;GVgvcCrdC6w5uZSNx3Wb9Keo7a8
 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
 sRUwl2BdTZ5jkU05HgIFqUouBTqBsFFGewEmVuy
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
	TAGGED_FROM(0.00)[bounces-7807-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76488667CE3

There is a potential race condition in segmented messages using
the BAM protocol. When initiating a tx BAM session, first
the BAM itself is sent and then the txtimer is scheduled.
The tx timeout for BAM is currently hardcoded to 50ms.
As soon as the loopbacked BAM frame, acting as a tx
acknowledgment is received, the session->last_cmd field
is set to J1939_TP_CMD_BAM.

When the txtimer elapses the function j1939_xtp_txnext_transmiter
is called, which checks session->last_cmd and continues with
sending a data frame only if session->last_cmd is set to J1939_TP_CMD_BAM.

If there is a high busload and the BAM frame is stuck in the controller
for some time, the txtimer might elapse before the looped back frame is
received and the session will stall.
This problem becomes very obvious when changing the tx timeout
for BAMs to the lowest value allowed by the specification of 10ms.

This patch fixes the problem by moving the tx timer scheduling for
BAM transmissions such that the timer is scheduled when the tx ack
is received. This also fixes the problem that when consecutive
data frames are stuck in the controller they will be sent
without any delay.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/transport.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..d00f0c158bb8 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -7,7 +7,6 @@
 //                         Marc Kleine-Budde <kernel@pengutronix.de>
 // Copyright (c) 2017-2019 Pengutronix,
 //                         Oleksij Rempel <kernel@pengutronix.de>
-
 #include <linux/can/skb.h>
 #include <net/can.h>
=20
@@ -26,6 +25,9 @@
 #define J1939_TP_CMD_BAM 0x20
 #define J1939_TP_CMD_ABORT 0xff
=20
+#define J1939_TP_BAM_FRAME_SPACING_MS 50
+#define J1939_TP_BAM_ECHO_TIMEOUT_MS 250
+
 #define J1939_ETP_CMD_RTS 0x14
 #define J1939_ETP_CMD_CTS 0x15
 #define J1939_ETP_CMD_DPO 0x16
@@ -754,7 +756,6 @@ static int j1939_session_tx_rts(struct j1939_session *=
session)
=20
 	session->last_txcmd =3D dat[0];
 	if (dat[0] =3D=3D J1939_TP_CMD_BAM) {
-		j1939_tp_schedule_txtimer(session, 50);
 		j1939_tp_set_rxtimeout(session, 250);
 	} else {
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -854,12 +855,19 @@ static int j1939_session_tx_dat(struct j1939_session=
 *session)
 		session->last_txcmd =3D 0xff;
 		pkt_done++;
 		session->pkt.tx++;
-		pdelay =3D j1939_cb_is_broadcast(&session->skcb) ? 50 :
-			j1939_tp_packet_delay;
=20
-		if (session->pkt.tx < session->pkt.total && pdelay) {
-			j1939_tp_schedule_txtimer(session, pdelay);
+		/* For BAM transfer the tx timer is scheduled after receiving
+		 * the looped back frame as a tx ack. This means that here the
+		 * timer is only scheduled for directed transfers.
+		 */
+		pdelay =3D j1939_tp_packet_delay;
+		if (j1939_cb_is_broadcast(&session->skcb)) {
 			break;
+		} else {
+			if (session->pkt.tx < session->pkt.total && pdelay) {
+				j1939_tp_schedule_txtimer(session, j1939_tp_packet_delay);
+				break;
+			}
 		}
 	}
=20
@@ -1793,8 +1801,12 @@ static void j1939_xtp_rx_rts(struct j1939_priv *pri=
v, struct sk_buff *skb,
 	session->last_cmd =3D cmd;
=20
 	if (cmd =3D=3D J1939_TP_CMD_BAM) {
-		if (!session->transmission)
+		if (!session->transmission) {
 			j1939_tp_set_rxtimeout(session, 750);
+		} else {
+			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
+			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
+		}
 	} else {
 		if (!session->transmission) {
 			j1939_session_txtimer_cancel(session);
@@ -1948,6 +1960,10 @@ static void j1939_xtp_rx_dat_one(struct j1939_sessi=
on *session,
 	} else if (remain) {
 		if (!session->transmission)
 			j1939_tp_set_rxtimeout(session, 750);
+		else if (j1939_cb_is_broadcast(&session->skcb)) {
+			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
+			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
+		}
 	} else if (do_cts_eoma) {
 		j1939_tp_set_rxtimeout(session, 1250);
 		if (!session->transmission)
=2D-=20
2.43.0


