Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72CF63336
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGII74 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37961 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGII7z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085O-H7; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000bZ-6H; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 07/34] j1939: transport: smpilt j1939_xtp_txnext_* to separate functions
Date:   Tue,  9 Jul 2019 10:58:42 +0200
Message-Id: <20190709085909.1413-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709085909.1413-1-o.rempel@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 400 ++++++++++++++++++++++----------------
 1 file changed, 231 insertions(+), 169 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 37f7ae6bd5eb..30d3e60c0e23 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -629,19 +629,142 @@ static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-/* transmit function */
-static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
+static int j1939_session_tx_rts(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
 	u8 dat[8];
-	const u8 *tpdat;
-	int ret, offset, pkt_done, pkt_end;
-	unsigned int pkt, len, pdelay;
-	struct sk_buff *se_skb;
-	struct j1939_sk_buff_cb *skcb;
+	int ret;
 
 	memset(dat, 0xff, sizeof(dat));
 
+	dat[1] = (session->total_message_size >> 0);
+	dat[2] = (session->total_message_size >> 8);
+	dat[3] = session->pkt.total;
+
+	if (session->skcb.addr.type == J1939_ETP) {
+		dat[0] = J1939_ETP_CMD_RTS;
+		dat[1] = (session->total_message_size >> 0);
+		dat[2] = (session->total_message_size >> 8);
+		dat[3] = (session->total_message_size >> 16);
+		dat[4] = (session->total_message_size >> 24);
+	} else if (j1939_cb_is_broadcast(&session->skcb)) {
+		dat[0] = J1939_TP_CMD_BAM;
+		/* fake cts for broadcast */
+		session->pkt.tx = 0;
+	} else {
+		dat[0] = J1939_TP_CMD_RTS;
+		dat[4] = dat[3];
+	}
+
+	if (dat[0] == session->last_txcmd)
+		/* done already */
+		return 0;
+
+	ret = j1939_tp_tx_ctl(session, false, dat);
+	if (ret < 0)
+		return ret;
+
+	session->last_txcmd = dat[0];
+	if (dat[0] == J1939_TP_CMD_BAM)
+		j1939_tp_schedule_txtimer(session, 50);
+
+	j1939_tp_set_rxtimeout(session, 1250);
+
+	return 0;
+}
+
+static int j1939_session_tx_dpo(struct j1939_session *session)
+{
+	unsigned int pkt;
+	u8 dat[8];
+	int ret;
+
+	memset(dat, 0xff, sizeof(dat));
+
+	dat[0] = J1939_ETP_CMD_DPO;
+	session->pkt.dpo = session->pkt.tx_acked;
+	pkt = session->pkt.dpo;
+	dat[1] = session->pkt.last - session->pkt.tx_acked;
+	dat[2] = (pkt >> 0);
+	dat[3] = (pkt >> 8);
+	dat[4] = (pkt >> 16);
+
+	ret = j1939_tp_tx_ctl(session, false, dat);
+	if (ret < 0)
+		return ret;
+
+	session->last_txcmd = dat[0];
+	j1939_tp_set_rxtimeout(session, 1250);
+	session->pkt.tx = session->pkt.tx_acked;
+
+	return 0;
+}
+
+static int j1939_session_tx_dat(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	struct j1939_sk_buff_cb *skcb;
+	int offset, pkt_done, pkt_end;
+	unsigned int len, pdelay;
+	struct sk_buff *se_skb;
+	const u8 *tpdat;
+	int ret = 0;
+	u8 dat[8];
+
+	se_skb = j1939_session_skb_find(session);
+	if (!se_skb)
+		return -EPIPE;
+
+	skcb = j1939_skb_to_cb(se_skb);
+	tpdat = se_skb->data;
+	ret = 0;
+	pkt_done = 0;
+	if (session->skcb.addr.type != J1939_ETP &&
+	    j1939_cb_is_broadcast(&session->skcb))
+		pkt_end = session->pkt.total;
+	else
+		pkt_end = session->pkt.last;
+
+	while (session->pkt.tx < pkt_end) {
+		dat[0] = session->pkt.tx - session->pkt.dpo + 1;
+		offset = (session->pkt.tx * 7) - skcb->offset;
+		len =  se_skb->len - offset;
+		if (len > 7)
+			len = 7;
+
+		memcpy(&dat[1], &tpdat[offset], len);
+		ret = j1939_tp_tx_dat(session, dat, len + 1);
+		if (ret < 0) {
+			/* ENOBUS == CAN interface TX queue is full */
+			if (ret != -ENOBUFS)
+				netdev_alert(priv->ndev,
+					     "%s: queue data error: %i\n",
+					     __func__, ret);
+			break;
+		}
+
+		session->last_txcmd = 0xff;
+		pkt_done++;
+		session->pkt.tx++;
+		pdelay = j1939_cb_is_broadcast(&session->skcb) ? 50 :
+			j1939_tp_packet_delay;
+
+		if (session->pkt.tx < session->pkt.total && pdelay) {
+			j1939_tp_schedule_txtimer(session, pdelay);
+			break;
+		}
+	}
+
+	if (pkt_done)
+		j1939_tp_set_rxtimeout(session, 250);
+
+	return ret;
+}
+
+static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	int ret = 0;
+
 	if (!j1939_tp_im_transmitter(&session->skcb)) {
 		netdev_alert(priv->ndev, "%s: called by not transmitter!\n",
 			     __func__);
@@ -650,102 +773,22 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 	switch (session->last_cmd) {
 	case 0:
-		dat[1] = (session->total_message_size >> 0);
-		dat[2] = (session->total_message_size >> 8);
-		dat[3] = session->pkt.total;
-		if (session->skcb.addr.type == J1939_ETP) {
-			dat[0] = J1939_ETP_CMD_RTS;
-			dat[1] = (session->total_message_size >> 0);
-			dat[2] = (session->total_message_size >> 8);
-			dat[3] = (session->total_message_size >> 16);
-			dat[4] = (session->total_message_size >> 24);
-		} else if (j1939_cb_is_broadcast(&session->skcb)) {
-			dat[0] = J1939_TP_CMD_BAM;
-			/* fake cts for broadcast */
-			session->pkt.tx = 0;
-		} else {
-			dat[0] = J1939_TP_CMD_RTS;
-			dat[4] = dat[3];
-		}
-		if (dat[0] == session->last_txcmd)
-			/* done already */
-			break;
-		ret = j1939_tp_tx_ctl(session, false, dat);
-		if (ret < 0)
-			goto failed;
-		session->last_txcmd = dat[0];
-		/* must lock? */
-		if (dat[0] == J1939_TP_CMD_BAM)
-			j1939_tp_schedule_txtimer(session, 50);
-		j1939_tp_set_rxtimeout(session, 1250);
+		ret = j1939_session_tx_rts(session);
 		break;
+
 	case J1939_ETP_CMD_CTS:
-		if (session->skcb.addr.type == J1939_ETP &&
-		    session->last_txcmd != J1939_ETP_CMD_DPO) {
-			/* do dpo */
-			dat[0] = J1939_ETP_CMD_DPO;
-			session->pkt.dpo = session->pkt.tx_acked;
-			pkt = session->pkt.dpo;
-			dat[1] = session->pkt.last - session->pkt.tx_acked;
-			dat[2] = (pkt >> 0);
-			dat[3] = (pkt >> 8);
-			dat[4] = (pkt >> 16);
-			ret = j1939_tp_tx_ctl(session, false, dat);
-			if (ret < 0)
-				goto failed;
-			session->last_txcmd = dat[0];
-			j1939_tp_set_rxtimeout(session, 1250);
-			session->pkt.tx = session->pkt.tx_acked;
+		if (session->last_txcmd != J1939_ETP_CMD_DPO) {
+			ret = j1939_session_tx_dpo(session);
+			if (ret)
+				return ret;
 		}
+
 		/* fallthrough */
-	case J1939_TP_CMD_CTS: /* fallthrough */
+	case J1939_TP_CMD_CTS:
 	case 0xff: /* did some data */
-	case J1939_ETP_CMD_DPO: /* fallthrough */
-	case J1939_TP_CMD_BAM: /* fallthrough */
-		se_skb = j1939_session_skb_find(session);
-		if (!se_skb)
-			return -EPIPE;
-
-		skcb = j1939_skb_to_cb(se_skb);
-		tpdat = se_skb->data;
-		ret = 0;
-		pkt_done = 0;
-		if (session->skcb.addr.type != J1939_ETP &&
-		    j1939_cb_is_broadcast(&session->skcb))
-			pkt_end = session->pkt.total;
-		else
-			pkt_end = session->pkt.last;
-
-		while (session->pkt.tx < pkt_end) {
-			dat[0] = session->pkt.tx - session->pkt.dpo + 1;
-			offset = (session->pkt.tx * 7) - skcb->offset;
-			len =  se_skb->len - offset;
-			if (len > 7)
-				len = 7;
-			memcpy(&dat[1], &tpdat[offset], len);
-			ret = j1939_tp_tx_dat(session, dat, len + 1);
-			if (ret < 0) {
-				/* ENOBUS == CAN interface TX queue is full */
-				if (ret != -ENOBUFS)
-					netdev_alert(priv->ndev,
-						     "%s: queue data error: %i\n",
-						     __func__, ret);
-				break;
-			}
-			session->last_txcmd = 0xff;
-			pkt_done++;
-			session->pkt.tx++;
-			pdelay = j1939_cb_is_broadcast(&session->skcb) ? 50 :
-				j1939_tp_packet_delay;
-			if (session->pkt.tx < session->pkt.total && pdelay) {
-				j1939_tp_schedule_txtimer(session, pdelay);
-				break;
-			}
-		}
-		if (pkt_done)
-			j1939_tp_set_rxtimeout(session, 250);
-		if (ret)
-			goto failed;
+	case J1939_ETP_CMD_DPO:
+	case J1939_TP_CMD_BAM:
+		ret = j1939_session_tx_dat(session);
 
 		break;
 	default:
@@ -754,92 +797,114 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 	}
 
-	return 0;
-
- failed:
 	return ret;
 }
 
-static int j1939_xtp_txnext_receiver(struct j1939_session *session)
+static int j1939_session_tx_cts(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
 	unsigned int pkt, len;
+	int ret;
+	u8 dat[8];
+
+	len = session->pkt.total - session->pkt.rx;
+	len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
+	memset(dat, 0xff, sizeof(dat));
+
+	if (session->skcb.addr.type == J1939_ETP) {
+		pkt = session->pkt.rx + 1;
+		dat[0] = J1939_ETP_CMD_CTS;
+		dat[1] = len;
+		dat[2] = (pkt >> 0);
+		dat[3] = (pkt >> 8);
+		dat[4] = (pkt >> 16);
+	} else {
+		dat[0] = J1939_TP_CMD_CTS;
+		dat[1] = len;
+		dat[2] = session->pkt.rx + 1;
+	}
+
+	if (dat[0] == session->last_txcmd)
+		/* done already */
+		return 0;
+
+	ret = j1939_tp_tx_ctl(session, true, dat);
+	if (ret < 0)
+		return ret;
+
+	if (len)
+		/* only mark cts done when len is set */
+		session->last_txcmd = dat[0];
+	j1939_tp_set_rxtimeout(session, 1250);
+
+	return 0;
+}
+
+static int j1939_session_tx_eoma(struct j1939_session *session)
+{
 	u8 dat[8];
 	int ret;
 
+	memset(dat, 0xff, sizeof(dat));
+
+	if (session->skcb.addr.type == J1939_ETP) {
+		dat[0] = J1939_ETP_CMD_EOMA;
+		dat[1] = session->total_message_size >> 0;
+		dat[2] = session->total_message_size >> 8;
+		dat[3] = session->total_message_size >> 16;
+		dat[4] = session->total_message_size >> 24;
+	} else {
+		dat[0] = J1939_TP_CMD_EOMA;
+		dat[1] = session->total_message_size;
+		dat[2] = session->total_message_size >> 8;
+		dat[3] = session->pkt.total;
+	}
+
+	if (dat[0] == session->last_txcmd)
+		/* done already */
+		return 0;
+
+	ret = j1939_tp_tx_ctl(session, true, dat);
+	if (ret < 0)
+		return ret;
+
+	session->last_txcmd = dat[0];
+
+	/* wait for the EOMA packet to come in */
+	j1939_tp_set_rxtimeout(session, 1250);
+
+	return 0;
+}
+
+static int j1939_xtp_txnext_receiver(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	int ret = 0;
+
 	if (!j1939_tp_im_receiver(&session->skcb)) {
 		netdev_alert(priv->ndev, "%s: called by not receiver!\n",
 			     __func__);
 		return -EINVAL;
 	}
 
-	memset(dat, 0xff, sizeof(dat));
-
 	switch (session->last_cmd) {
 	case J1939_TP_CMD_RTS:
-	case J1939_ETP_CMD_RTS: /* fallthrough */
- tx_cts:
-		ret = 0;
-		len = session->pkt.total - session->pkt.rx;
-		len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
-
-		if (session->skcb.addr.type == J1939_ETP) {
-			pkt = session->pkt.rx + 1;
-			dat[0] = J1939_ETP_CMD_CTS;
-			dat[1] = len;
-			dat[2] = (pkt >> 0);
-			dat[3] = (pkt >> 8);
-			dat[4] = (pkt >> 16);
-		} else {
-			dat[0] = J1939_TP_CMD_CTS;
-			dat[1] = len;
-			dat[2] = session->pkt.rx + 1;
-		}
-		if (dat[0] == session->last_txcmd)
-			/* done already */
-			break;
-		ret = j1939_tp_tx_ctl(session, true, dat);
-		if (ret < 0)
-			goto failed;
-		if (len)
-			/* only mark cts done when len is set */
-			session->last_txcmd = dat[0];
-		j1939_tp_set_rxtimeout(session, 1250);
+	case J1939_ETP_CMD_RTS:
+		ret = j1939_session_tx_cts(session);
 		break;
+
 	case J1939_ETP_CMD_CTS:
-		/* fallthrough */
-	case J1939_TP_CMD_CTS: /* fallthrough */
+	case J1939_TP_CMD_CTS:
 	case 0xff: /* did some data */
-	case J1939_ETP_CMD_DPO: /* fallthrough */
-		if ((session->skcb.addr.type == J1939_ETP ||
-		     !j1939_cb_is_broadcast(&session->skcb))) {
-			if (session->pkt.rx >= session->pkt.total) {
-				if (session->skcb.addr.type == J1939_ETP) {
-					dat[0] = J1939_ETP_CMD_EOMA;
-					dat[1] = session->total_message_size >> 0;
-					dat[2] = session->total_message_size >> 8;
-					dat[3] = session->total_message_size >> 16;
-					dat[4] = session->total_message_size >> 24;
-				} else {
-					dat[0] = J1939_TP_CMD_EOMA;
-					dat[1] = session->total_message_size;
-					dat[2] = session->total_message_size >> 8;
-					dat[3] = session->pkt.total;
-				}
-				if (dat[0] == session->last_txcmd)
-					/* done already */
-					break;
-				ret = j1939_tp_tx_ctl(session, true, dat);
-				if (ret < 0)
-					goto failed;
-				session->last_txcmd = dat[0];
-				j1939_tp_set_rxtimeout(session, 1250);
-				/* wait for the EOMA packet to come in */
-				break;
-			} else if (session->pkt.rx >= session->pkt.last) {
-				session->last_txcmd = 0;
-				goto tx_cts;
-			}
+	case J1939_ETP_CMD_DPO:
+		if ((session->skcb.addr.type == J1939_TP &&
+		     j1939_cb_is_broadcast(&session->skcb)))
+			break;
+
+		if (session->pkt.rx >= session->pkt.total) {
+			ret = j1939_session_tx_eoma(session);
+		} else if (session->pkt.rx >= session->pkt.last) {
+			session->last_txcmd = 0;
+			ret = j1939_session_tx_cts(session);
 		}
 		break;
 	default:
@@ -847,9 +912,6 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 			     __func__, session->last_cmd);
 	}
 
-	return 0;
-
- failed:
 	return ret;
 }
 
-- 
2.20.1

