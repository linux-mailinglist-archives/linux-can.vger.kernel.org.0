Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6B6331E
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGII7U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfGII7T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085N-H2; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000bB-57; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 06/34] j1939: transport: split j1939_tp_txnext()
Date:   Tue,  9 Jul 2019 10:58:41 +0200
Message-Id: <20190709085909.1413-6-o.rempel@pengutronix.de>
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

j1939_tp_txnext() was covering transmitter and receiver part.
Split it to make code more readable.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 187 +++++++++++++++++++++++---------------
 1 file changed, 112 insertions(+), 75 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8b15c5d529a1..37f7ae6bd5eb 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -630,8 +630,9 @@ static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
 }
 
 /* transmit function */
-static int j1939_tp_txnext(struct j1939_session *session)
+static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 {
+	struct j1939_priv *priv = session->priv;
 	u8 dat[8];
 	const u8 *tpdat;
 	int ret, offset, pkt_done, pkt_end;
@@ -641,10 +642,14 @@ static int j1939_tp_txnext(struct j1939_session *session)
 
 	memset(dat, 0xff, sizeof(dat));
 
+	if (!j1939_tp_im_transmitter(&session->skcb)) {
+		netdev_alert(priv->ndev, "%s: called by not transmitter!\n",
+			     __func__);
+		return -EINVAL;
+	}
+
 	switch (session->last_cmd) {
 	case 0:
-		if (!j1939_tp_im_transmitter(&session->skcb))
-			break;
 		dat[1] = (session->total_message_size >> 0);
 		dat[2] = (session->total_message_size >> 8);
 		dat[3] = session->pkt.total;
@@ -674,41 +679,8 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			j1939_tp_schedule_txtimer(session, 50);
 		j1939_tp_set_rxtimeout(session, 1250);
 		break;
-	case J1939_TP_CMD_RTS:
-	case J1939_ETP_CMD_RTS: /* fallthrough */
-		if (!j1939_tp_im_receiver(&session->skcb))
-			break;
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
-		break;
 	case J1939_ETP_CMD_CTS:
-		if (j1939_tp_im_transmitter(&session->skcb) &&
-		    session->skcb.addr.type == J1939_ETP &&
+		if (session->skcb.addr.type == J1939_ETP &&
 		    session->last_txcmd != J1939_ETP_CMD_DPO) {
 			/* do dpo */
 			dat[0] = J1939_ETP_CMD_DPO;
@@ -729,41 +701,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 	case J1939_TP_CMD_CTS: /* fallthrough */
 	case 0xff: /* did some data */
 	case J1939_ETP_CMD_DPO: /* fallthrough */
-		if ((session->skcb.addr.type == J1939_ETP ||
-		     !j1939_cb_is_broadcast(&session->skcb)) &&
-		    j1939_tp_im_receiver(&session->skcb)) {
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
-		}
 	case J1939_TP_CMD_BAM: /* fallthrough */
-		if (!j1939_tp_im_transmitter(&session->skcb))
-			break;
-
 		se_skb = j1939_session_skb_find(session);
 		if (!se_skb)
 			return -EPIPE;
@@ -779,7 +717,6 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			pkt_end = session->pkt.last;
 
 		while (session->pkt.tx < pkt_end) {
-			struct j1939_priv *priv = session->priv;
 			dat[0] = session->pkt.tx - session->pkt.dpo + 1;
 			offset = (session->pkt.tx * 7) - skcb->offset;
 			len =  se_skb->len - offset;
@@ -796,8 +733,8 @@ static int j1939_tp_txnext(struct j1939_session *session)
 				break;
 			}
 			session->last_txcmd = 0xff;
-			++pkt_done;
-			++session->pkt.tx;
+			pkt_done++;
+			session->pkt.tx++;
 			pdelay = j1939_cb_is_broadcast(&session->skcb) ? 50 :
 				j1939_tp_packet_delay;
 			if (session->pkt.tx < session->pkt.total && pdelay) {
@@ -811,6 +748,103 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			goto failed;
 
 		break;
+	default:
+		netdev_alert(priv->ndev, "%s: unexpected last_cmd: %x\n",
+			     __func__, session->last_cmd);
+
+	}
+
+	return 0;
+
+ failed:
+	return ret;
+}
+
+static int j1939_xtp_txnext_receiver(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	unsigned int pkt, len;
+	u8 dat[8];
+	int ret;
+
+	if (!j1939_tp_im_receiver(&session->skcb)) {
+		netdev_alert(priv->ndev, "%s: called by not receiver!\n",
+			     __func__);
+		return -EINVAL;
+	}
+
+	memset(dat, 0xff, sizeof(dat));
+
+	switch (session->last_cmd) {
+	case J1939_TP_CMD_RTS:
+	case J1939_ETP_CMD_RTS: /* fallthrough */
+ tx_cts:
+		ret = 0;
+		len = session->pkt.total - session->pkt.rx;
+		len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
+
+		if (session->skcb.addr.type == J1939_ETP) {
+			pkt = session->pkt.rx + 1;
+			dat[0] = J1939_ETP_CMD_CTS;
+			dat[1] = len;
+			dat[2] = (pkt >> 0);
+			dat[3] = (pkt >> 8);
+			dat[4] = (pkt >> 16);
+		} else {
+			dat[0] = J1939_TP_CMD_CTS;
+			dat[1] = len;
+			dat[2] = session->pkt.rx + 1;
+		}
+		if (dat[0] == session->last_txcmd)
+			/* done already */
+			break;
+		ret = j1939_tp_tx_ctl(session, true, dat);
+		if (ret < 0)
+			goto failed;
+		if (len)
+			/* only mark cts done when len is set */
+			session->last_txcmd = dat[0];
+		j1939_tp_set_rxtimeout(session, 1250);
+		break;
+	case J1939_ETP_CMD_CTS:
+		/* fallthrough */
+	case J1939_TP_CMD_CTS: /* fallthrough */
+	case 0xff: /* did some data */
+	case J1939_ETP_CMD_DPO: /* fallthrough */
+		if ((session->skcb.addr.type == J1939_ETP ||
+		     !j1939_cb_is_broadcast(&session->skcb))) {
+			if (session->pkt.rx >= session->pkt.total) {
+				if (session->skcb.addr.type == J1939_ETP) {
+					dat[0] = J1939_ETP_CMD_EOMA;
+					dat[1] = session->total_message_size >> 0;
+					dat[2] = session->total_message_size >> 8;
+					dat[3] = session->total_message_size >> 16;
+					dat[4] = session->total_message_size >> 24;
+				} else {
+					dat[0] = J1939_TP_CMD_EOMA;
+					dat[1] = session->total_message_size;
+					dat[2] = session->total_message_size >> 8;
+					dat[3] = session->pkt.total;
+				}
+				if (dat[0] == session->last_txcmd)
+					/* done already */
+					break;
+				ret = j1939_tp_tx_ctl(session, true, dat);
+				if (ret < 0)
+					goto failed;
+				session->last_txcmd = dat[0];
+				j1939_tp_set_rxtimeout(session, 1250);
+				/* wait for the EOMA packet to come in */
+				break;
+			} else if (session->pkt.rx >= session->pkt.last) {
+				session->last_txcmd = 0;
+				goto tx_cts;
+			}
+		}
+		break;
+	default:
+		netdev_alert(priv->ndev, "%s: unexpected last_cmd: %x\n",
+			     __func__, session->last_cmd);
 	}
 
 	return 0;
@@ -886,7 +920,10 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			}
 		}
 	} else {
-		ret = j1939_tp_txnext(session);
+		if (session->transmission)
+			ret = j1939_xtp_txnext_transmiter(session);
+		else
+			ret = j1939_xtp_txnext_receiver(session);
 	}
 
 	if (ret == -ENOBUFS) {
-- 
2.20.1

