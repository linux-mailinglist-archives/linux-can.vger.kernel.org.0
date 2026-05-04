Return-Path: <linux-can+bounces-7482-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KcTG3Qb+Wng5gIAu9opvQ
	(envelope-from <linux-can+bounces-7482-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 00:19:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C90344C4577
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0717301842D
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3737FF72;
	Mon,  4 May 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="NBUzuJhw"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284B37F8D3;
	Mon,  4 May 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933168; cv=none; b=DwI78GGv7ltaKwkJaTlM4oEBpe0oVnzTQIxWUrHUzT7BKs9G3NwmspvRiS8nraM3VshunPM377IBA7ixNhhvRa9EZFbCNCmZyeiuxopx/TAT0Yb2DornFKR6ReqUz2qwYg1I4Zqc67KDDvRqKQwh+b+us0cgjg065ZgGj3xGAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933168; c=relaxed/simple;
	bh=VnDvR4OZVl04WiBU9HRYU1uBmbm5TYkO4rUIC7MmJmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CTiyElEAQlkAdM4GgiovJJskuiV9ULaHQMLzTv4LbkipfGmQGSoWPim0Pe1GSOa7+DM2oEB44yTq5pCGi+/V7Q60p3X3MPLmT0U+Ezme7wWHl1HdVpucDhxDTSt7O7PZhzYODMXmSu3aHOi7932waKJjGldYojaiFMC2T2nGdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=NBUzuJhw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1777933163; x=1778537963;
	i=alexander.hoelzl@gmx.net;
	bh=4Xn16crFXGFOsXHOuc9Y2ZlZldVBFDttOMPwOyJlmHs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NBUzuJhwFqvPsvA0h4vCrAU8BwxAJcUG0h+4OZ9eIC8k6HwNkrO6KjO7cDlQjpfR
	 bKuoTWoPCWfkk9As0AP31P76jJEQVoG2cXg6KnloLtZ1VSzOvWP/ZFxM8jiRnUtKz
	 gb29c99sQKtd1YJZdmggy+sPztZY2SQtPJZqkaZrUyxaAC8horE2mb1/dRgVlDxsF
	 BgJu9fchJ2/SoLEA+pgiyvfjODIbxt+KJ0wEEtfVwBKNGqGY5NE3ukIOTwojuQPYg
	 d6cyatoup2H6D+hF/MRBZCAY48NPTKMkUkq/1/hBZ0/WaBmx9wMW+wzFhnz6bAFtD
	 70KbnYzdntx7XKQveA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1vhNR01lOH-00jqRA; Tue, 05
 May 2026 00:19:23 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH] Fix J1939 implementation not handling holds correctly
Date: Tue,  5 May 2026 00:18:33 +0200
Message-ID: <20260504221833.53629-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jO5qDms1q26+8rhHck09A662cq8n/Ab+9MEhphdyoDxRIA89TUR
 ZzZlay/EVHv2Cm4Rwhfgx2gcrkvAyIc5QYb9RzucOqebrNAOYGyZ66jRlqAhyeeYwo4VRrl
 DsBQiYOhRwi05qXSgP/RyzJKtKrVTAhIggN8LDZ8ZHdUU/SnOwpJRXj/aJBk0GjBGpymJc7
 yUpvamofTa9HSwEOK9ytw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gu+0aGWq3TE=;5UR/O+EZiNXzEGep28C5HRXtFp+
 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
X-Rspamd-Queue-Id: C90344C4577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7482-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonic.nl,vger.kernel.org,pengutronix.de,gmx.net];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_raw_filter.sh:url]

The J1939 protocol allows the receiver of directed segemented messages
to hold the data transfer. The kernel implementation did not handle hold
messages correctly was not able to resume from a hold.
Additionally the incorrect timeout for a held open connection was
changed to 1050ms.
Some simple tests for the general protocol behavior have been added.

This is just an initial draft I'm just looking for some feedback
if the general setup is acceptable.

Also I still have some points I'm not sure about.
1. There is no check for the reception of a CTS during an ongoing data
   transfer. According to the standard it is illegal, but I dont think
   the implementation cares about it. J1939_XTP_ABORT_GENERIC is never
   referenced and the previous check I removed only really prevented
   consecutive CTS which are legal if they are holds. Should I add a
   check for this? This seems to be a slightly different problem so I
   did not address it.

2. Should userspace be notified about holds? I don't think the standard
   gives a maximum 'hold open time' so in theory it could be held
   indefinetly. This might be a situation a user could be intrested in
   even though it is rather theoretical.

Please tell me what you think.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/transport.c                     |  50 ++--
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   8 +-
 tools/testing/selftests/net/can/config        |   1 +
 .../testing/selftests/net/can/test_cts_hold.c | 269 ++++++++++++++++++
 .../selftests/net/can/test_cts_hold.sh        |  45 +++
 6 files changed, 355 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
 create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..e53a9fbe82a9 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1442,9 +1442,27 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
 struct sk_buff *skb)
=20
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
=20
-	if (session->last_cmd =3D=3D dat[0]) {
-		err =3D J1939_XTP_ABORT_DUP_SEQ;
-		goto out_session_cancel;
+	session->last_cmd =3D dat[0];
+
+	/* TODO
+	 *according to the standard it is illegal to send a CTS while data trans=
fer is ongoing.
+	 * If a CTS is sent while data transfer is ongoing an abort with code 4 =
should be sent.
+	 * The previous check I removed was simply (session->last_cmd =3D=3D dat=
[0]).
+	 * This did not check for a invalid CTS after some data frames had alrea=
dy been
+	 * sent but before all of them were sent.
+	 * So CTS(0), CTS(5) was illegal. CTS(5), DAT, CTS(5) was legal,
+	 * even though only one data frame has been sent instead of 5.
+	 * Should a check for this also be added?
+	 */
+	if (!dat[1]) {
+		/* CTS(0) */
+		if (session->transmission) {
+			/* TODO notify error queue about hold messages? */
+			j1939_session_txtimer_cancel(session);
+		}
+		j1939_tp_set_rxtimeout(session, 1050);
+		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __func_=
_, session);
+		return;
 	}
=20
 	if (session->skcb.addr.type =3D=3D J1939_ETP)
@@ -1457,7 +1475,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
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
@@ -1467,19 +1489,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
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
index 000000000000..a36efb099522
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_cts_hold.c
@@ -0,0 +1,269 @@
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
+	struct sockaddr_can addr;
+	struct ifreq ifr;
+	struct timeval raw_rcvtimeout =3D {.tv_sec =3D 0, .tv_usec =3D RAW_RCVTI=
MEOUT_US};
+	int s, ret;
+
+	s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to create CAN_RAW socket: %d", errno);
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret =3D ioctl(s, SIOCGIFINDEX, &ifr);
+	ASSERT_GE(ret, 0)
+		TH_LOG("failed SIOCGIFINDEX: %d", errno);
+
+
+	addr.can_family =3D AF_CAN;
+	addr.can_ifindex =3D ifr.ifr_ifindex;
+
+	ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_RAW socket: %d", errno);
+
+	self->raw_sock =3D s;
+
+	s =3D socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to create CAN_J1939 socket: %d", errno);
+
+
+	ret =3D setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &raw_rcvtimeout, sizeof(r=
aw_rcvtimeout));
+
+	addr.can_addr.j1939.addr =3D SENDER_ADDR;
+	addr.can_addr.j1939.name =3D J1939_NO_NAME;
+	addr.can_addr.j1939.pgn =3D J1939_NO_PGN;
+
+	ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_J1939 socket: %d", errno);
+
+	addr.can_addr.j1939.addr =3D RECEIVER_ADDR;
+	addr.can_addr.j1939.pgn =3D TEST_PGN;
+	ret =3D connect(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed connect CAN_J1939 socket: %d", errno);
+
+	self->j1939_sock =3D s;
+}
+
+FIXTURE_TEARDOWN(can_env)
+{
+	close(self->j1939_sock);
+	close(self->raw_sock);
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
+	memcpy(tx_frame.data, RESUME_PAYLOAD, sizeof(RESUME_IMMEDIATE_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
+
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
+	/* Wait for 1100ms before sending the resume */
+	usleep(1050);
+
+	res =3D recv_payload(self->raw_sock, ABORT_TIMEOUT_PAYLOAD, sizeof(ABORT=
_TIMEOUT_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive abort as expeceted");
+
+
+}
+
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


