Return-Path: <linux-can+bounces-7638-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ0ZNCeBCGo/sgMAu9opvQ
	(envelope-from <linux-can+bounces-7638-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 16:37:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302E55C1CF
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8BA3001AD6
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C8380FF2;
	Sat, 16 May 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="B8J3xhIK"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59A26CE2C;
	Sat, 16 May 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942243; cv=none; b=KafD4V7M4h+TQ4b/ig1R9auP64AIByA/r9uCZo1FR87TJJn4q8TiIY1skEJSwIqfjUhUyXsD7whyzrzD2ciVnxmiDVpmWbLgLCuKJFMwbyPyIXueUH/G7bvQwdI2pgMaMP61qGtv+FsTms/u13q3SnJ1vfUnT9PNp/vWfqATAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942243; c=relaxed/simple;
	bh=8EYda6jzaTc0SFUIOFrt6GLIanke9Dn1gegLLWdQxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Erqp9M5SjipmUqfSXTbuPU+lHJzJLxp8lHrzRWHs8NsSPyZd5vhBW3/UagSh1esWGT09jyFvDmAHwcgt7neAemcwdXZ6McELfCJMmt4ZhMNAD7QJBbsHiX1oALK6a0B13ng7t7Dr91cveaqx994A8QvlFU+rHQ2QRQ2xqAkofvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=B8J3xhIK; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778942236; x=1779547036;
	i=alexander.hoelzl@gmx.net;
	bh=sIjE6sYIskPIn0PtrDtqlK66IE/c1L9YPsfNfr1q28A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B8J3xhIKe6Q4OdEfPjK2Gl5dVoZVl6D5ZhyME1zmjmmLdC2xk8pjpwU9KUteYrzT
	 Na0sNyvpX4TyXS5hF0Mzl41XmZlITaKj6a5oZ8LS3Tw8QjETTBfpANYoyuI9P0Smh
	 YGNWf5bv2A5C7MibJFR8eTVgY1+c9zhOKYMJ0K5JOJwePshfEiQV8IbkLmv7tr0VK
	 KMBlIP89hpXmXwWnrT+ch03SHT5IsJbnV4Ky6xhPjKLvmyQWBQ7m7/PJDSdKrEKyh
	 pMSumeA8Uad5mGUB9WdGpuEC7eN/tHgJwiD025W68J5AfTPYx7vlByKBArkOOvmqN
	 GAwjj7CAbmlEzN+pAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1wyybK1xVW-00ip8j; Sat, 16
 May 2026 16:37:16 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v2] Fix J1939 implementation not handling holds correctly
Date: Sat, 16 May 2026 16:35:25 +0200
Message-ID: <20260516143644.139561-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lnrafVFYY8Q6JunL7m5Bt30jHLRzkWqFNKEYvjo73rExXLcubyy
 85+sJY94vZ9trkdKj4UrZZLfAqsvaAhaLVadamA/4gUYOMXT0D/td7rQNB3J6I5/fX4xcrH
 2V7ipfgFPN8jj0+YCiCuYayOblUDHzWBXhK8A948tp22vqXVytnS8PeFkD/lKoeuWbQwxrs
 yi1XWENGNi9kDE9UibEow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:euBEy34jRFY=;stiTfr/vz85kuLTaSUF3Cu55Gm2
 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
 7+t1YAPLmt+TxP5zxaEZaQ+Pg5s=
X-Rspamd-Queue-Id: 4302E55C1CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7638-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_cts_hold.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The J1939 protocol allows the receiver of directed segemented messages
to hold the data transfer. The kernel implementation did not handle hold
messages correctly was not able to resume from a hold.

Fix J1939 RTS/CTS session not being able to resume from hold.
Replace hardcoded timeout with define.
Add CTS hold behavior tests.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
Compared to the last patch I removed all of the todo comments I had
still had in the code. I will implement hold notification in the error
queue in different patch.

I replaced the hardcoded hold timeout with a define. I can replace the
other hardcoded timeouts in a different patch if you want me to, but
for now I only touched code related to the holds.
I also added a helper function to check if a CTS is a hold.

I also added a baseline test case as you wanted. Altough in the future
it should probably moved to another file which specfically tests normal
RTS/CTS behavior.

Also addressed all the comments Sashiko had on the test file and I'm
also now sending an EOMA in the test as without it between every test
there was a 1250ms wait until the session timed out...

 net/can/j1939/transport.c                     |  48 ++-
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   8 +-
 tools/testing/selftests/net/can/config        |   1 +
 .../testing/selftests/net/can/test_cts_hold.c | 322 ++++++++++++++++++
 .../selftests/net/can/test_cts_hold.sh        |  45 +++
 6 files changed, 406 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
 create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..a959272f32b2 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -32,6 +32,11 @@
 #define J1939_ETP_CMD_EOMA 0x17
 #define J1939_ETP_CMD_ABORT 0xff
=20
+/* Time until session invalidation upon reception of a hold message.
+ * Corresponds to T4 in the specification.
+ */
+#define J1939_CTS_HOLD_TIMEOUT_MS 1050
+
 enum j1939_xtp_abort {
 	J1939_XTP_NO_ABORT =3D 0,
 	J1939_XTP_ABORT_BUSY =3D 1,
@@ -1428,6 +1433,11 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struct s=
k_buff *skb,
 	j1939_session_put(session);
 }
=20
+static inline bool j1939_cts_is_hold(const struct sk_buff *skb)
+{
+	return (!skb->data[1]);
+}
+
 static void
 j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 {
@@ -1442,9 +1452,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
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
@@ -1457,7 +1473,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
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
@@ -1467,19 +1487,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
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
diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/se=
lftests/net/can/.gitignore
index 764a53fc837f..96ef18ae986d 100644
=2D-- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_cts_hold
\ No newline at end of file
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/self=
tests/net/can/Makefile
index 5b82e60a03e7..182346682bce 100644
=2D-- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,8 +4,12 @@ top_srcdir =3D ../../../../..
=20
 CFLAGS +=3D -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $=
(KHDR_INCLUDES)
=20
-TEST_PROGS :=3D test_raw_filter.sh
+TEST_PROGS :=3D \
+	test_raw_filter.sh \
+	test_cts_hold.sh \
=20
-TEST_GEN_FILES :=3D test_raw_filter
+TEST_GEN_FILES :=3D \
+	test_raw_filter \
+	test_cts_hold \
=20
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selfte=
sts/net/can/config
index 188f79796670..cb538ed93ae4 100644
=2D-- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,4 @@
 CONFIG_CAN=3Dm
 CONFIG_CAN_DEV=3Dm
 CONFIG_CAN_VCAN=3Dm
+CONFIG_CAN_J1939=3Dm
\ No newline at end of file
diff --git a/tools/testing/selftests/net/can/test_cts_hold.c b/tools/testi=
ng/selftests/net/can/test_cts_hold.c
new file mode 100644
index 000000000000..2b2dffd5d5ef
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_cts_hold.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <net/if.h>
+#include <linux/if.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+#include <linux/can/j1939.h>
+
+#include "kselftest_harness.h"
+
+
+#define SENDER_ADDR		0x10
+#define RECEIVER_ADDR	0x20
+
+#define TEST_PGN 0xAB00
+#define SENDER_TP_CM_ID		(0x18EC2010 | CAN_EFF_FLAG)
+#define RECEIVER_TP_CM_ID	(0x18EC1020 | CAN_EFF_FLAG)
+
+//10 millisecond timeout for raw socket
+#define RAW_RCVTIMEOUT_US 10000
+
+/* Segemented payload sent by the J1939 socket*/
+const uint8_t J1939_PAYLOAD[]	=3D {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x=
06, 0x07, 0x08, 0x09};
+
+/* Expected RTS payload */
+const uint8_t RTS_PAYLOAD[]					=3D {0x10, 0x0A, 0x00, 0x02, 0x02, 0x00, =
0xAB, 0x00};
+/* Hold payload to be sent by raw socket */
+const uint8_t HOLD_PAYLOAD[]				=3D {0x11, 0x00, 0xFF, 0xFF, 0xFF, 0x00, =
0xAB, 0x00};
+/* CTS to send to only allow for the transmission of one data frame */
+const uint8_t CTS_1_FRAME_PAYLOAD[]			=3D {0x11, 0x01, 0x01, 0xFF, 0xFF, =
0x00, 0xAB, 0x00};
+/* Resume payload to resume from connection which has been held directly =
after RTS*/
+const uint8_t RESUME_IMMEDIATE_PAYLOAD[]	=3D {0x11, 0x02, 0x01, 0xFF, 0xF=
F, 0x00, 0xAB, 0x00};
+/* Resume payload to resume session which has been held after first data =
frame */
+const uint8_t RESUME_PAYLOAD[]				=3D {0x11, 0x01, 0x02, 0xFF, 0xFF, 0x00=
, 0xAB, 0x00};
+/* Data payloads */
+const uint8_t DATA_1_PAYLOAD[]				=3D {0x01, 0x00, 0x01, 0x02, 0x03, 0x04=
, 0x05, 0x06};
+const uint8_t DATA_2_PAYLOAD[]				=3D {0x02, 0x07, 0x08, 0x09, 0xFF, 0xFF=
, 0xFF, 0xFF};
+
+/* EOMA payload to cleanup session */
+const uint8_t EOMA_PAYLOAD[]				=3D {0x13, 0x0A, 0x00, 0x02, 0xFF, 0x00, =
0xAB, 0x00};
+
+/* Timeout payload sent on connection timeout */
+const uint8_t ABORT_TIMEOUT_PAYLOAD[]		=3D {0xFF, 0x03, 0xFF, 0xFF, 0xFF,=
 0x00, 0xAB, 0x00};
+char CANIF[IFNAMSIZ];
+
+static int recv_payload(int sock, const uint8_t *payload, size_t len)
+{
+	struct can_frame rx_frame =3D {};
+
+	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {
+		perror("failed to recv can raw frame");
+		return 1;
+	}
+
+	if (rx_frame.len !=3D len) {
+		printf("received data length does not match expected value\n");
+		return 1;
+	}
+
+	if (memcmp(rx_frame.data, payload, len)) {
+		printf("received data does not match expected value\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+
+FIXTURE(can_env)
+{
+	int j1939_sock;
+	int raw_sock;
+};
+
+FIXTURE_SETUP(can_env)
+{
+	struct sockaddr_can addr =3D {};
+	struct ifreq ifr =3D {};
+	struct timeval raw_rcvtimeout =3D {.tv_sec =3D 0, .tv_usec =3D RAW_RCVTI=
MEOUT_US};
+	int ret;
+
+	self->raw_sock =3D -1;
+	self->j1939_sock =3D -1;
+
+	self->raw_sock =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	ASSERT_GE(self->raw_sock, 0)
+		TH_LOG("failed to create CAN_RAW socket: %d", errno);
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret =3D ioctl(self->raw_sock, SIOCGIFINDEX, &ifr);
+	ASSERT_GE(ret, 0)
+		TH_LOG("failed SIOCGIFINDEX: %d", errno);
+
+
+	addr.can_family =3D AF_CAN;
+	addr.can_ifindex =3D ifr.ifr_ifindex;
+
+	ret =3D bind(self->raw_sock, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_RAW socket: %d", errno);
+
+	ret =3D setsockopt(self->raw_sock, SOL_SOCKET, SO_RCVTIMEO, &raw_rcvtime=
out, sizeof(raw_rcvtimeout));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed setting SO_RCVTIMEO on CAN_RAW socket: %d", errno);
+
+	self->j1939_sock =3D socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	ASSERT_GE(self->j1939_sock, 0)
+		TH_LOG("failed to create CAN_J1939 socket: %d", errno);
+
+	addr.can_addr.j1939.addr =3D SENDER_ADDR;
+	addr.can_addr.j1939.name =3D J1939_NO_NAME;
+	addr.can_addr.j1939.pgn =3D J1939_NO_PGN;
+
+	ret =3D bind(self->j1939_sock, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_J1939 socket: %d", errno);
+
+	addr.can_addr.j1939.addr =3D RECEIVER_ADDR;
+	addr.can_addr.j1939.pgn =3D TEST_PGN;
+	ret =3D connect(self->j1939_sock, (struct sockaddr *)&addr, sizeof(addr)=
);
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed connect CAN_J1939 socket: %d", errno);
+}
+
+FIXTURE_TEARDOWN(can_env)
+{
+	if (self->j1939_sock !=3D -1)
+		close(self->j1939_sock);
+
+	if (self->raw_sock !=3D -1)
+		close(self->raw_sock);
+}
+
+/* Test RTS/CTS transport without hold as baseline */
+TEST_F(can_env, test_no_hold)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, RESUME_IMMEDIATE_PAYLOAD, sizeof(RESUME_IMMEDIATE_=
PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expeceted");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test holding RTS/CTS transport on first frame and resuming immediatley=
 */
+TEST_F(can_env, test_hold_resume_immediate)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Wait for 300ms before sending the resume */
+	usleep(300000);
+
+	memcpy(tx_frame.data, RESUME_IMMEDIATE_PAYLOAD, sizeof(RESUME_IMMEDIATE_=
PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expeceted");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test send hold in transport session and resuming */
+TEST_F(can_env, test_hold_resume)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Wait for 300ms before sending the resume */
+	usleep(300000);
+
+	memcpy(tx_frame.data, RESUME_PAYLOAD, sizeof(RESUME_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test timeout after not resuming hold */
+TEST_F(can_env, test_hold_timeout)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Wait for 1100 ms and receive the abort due to CTS hold timeout.
+	 * The actual timeout is 1050ms but with this test setup there is no poi=
nt
+	 * in trying to be this exact.
+	 */
+	usleep(1100 * 1000);
+
+	res =3D recv_payload(self->raw_sock, ABORT_TIMEOUT_PAYLOAD, sizeof(ABORT=
_TIMEOUT_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive abort as expeceted");
+}
+
+int main(int argc, char **argv)
+{
+	char *ifname =3D getenv("CANIF");
+
+	if (!ifname) {
+		printf("CANIF environment variable must contain the test interface\n");
+		return KSFT_FAIL;
+	}
+
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_cts_hold.sh b/tools/test=
ing/selftests/net/can/test_cts_hold.sh
new file mode 100755
index 000000000000..e69e9109245c
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_cts_hold.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS=3D"
+	test_cts_hold
+"
+
+net_dir=3D$(dirname $0)/..
+source $net_dir/lib.sh
+
+export CANIF=3D${CANIF:-"vcan0"}
+BITRATE=3D${BITRATE:-500000}
+
+setup()
+{
+	if [[ $CANIF =3D=3D vcan* ]]; then
+		ip link add name $CANIF type vcan || exit $ksft_skip
+	else
+		ip link set dev $CANIF type can bitrate $BITRATE || exit $ksft_skip
+	fi
+	ip link set dev $CANIF up
+	pwd
+}
+
+cleanup()
+{
+	ip link set dev $CANIF down
+	if [[ $CANIF =3D=3D vcan* ]]; then
+		ip link delete $CANIF
+	fi
+}
+
+test_cts_hold()
+{
+	./test_cts_hold
+	check_err $?
+	log_test "test_cts_hold"
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS
=2D-=20
2.54.0


