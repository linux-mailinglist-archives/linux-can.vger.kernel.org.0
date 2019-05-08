Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0768179D7
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfEHNFV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:05:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60811 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHNFV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:05:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG7-0005R7-BG; Wed, 08 May 2019 15:05:19 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG6-0004ph-5e; Wed, 08 May 2019 15:05:18 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v3 0/2] provide status handlers for (E)TP
Date:   Wed,  8 May 2019 15:05:13 +0200
Message-Id: <20190508130516.3954-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

2019.05.08 v3:
- reuse existing infrastructure as much as possible  
- remove j1939_pktinfo and cmsg support for sendmsg

With this version we started to use skb->tskey as send() counter.
No more cookies is needed. So, we can get proper session ID even with
write()/send() and sendto(). The errorqueue will return empty skb with
multiple attached optional CMSG. Here is an example of parsing attached
CMSGs:
ret = recvmsg(priv->sock, &msg, MSG_ERRQUEUE);
...

for (cm = CMSG_FIRSTHDR(&msg);
     cm && cm->cmsg_len;
     cm = CMSG_NXTHDR(&msg, cm)) {
	if (cm->cmsg_level == SOL_SOCKET &&
	    cm->cmsg_type == SCM_TIMESTAMPING) {
		tss = (void *)CMSG_DATA(cm);
	} else if (cm->cmsg_level == SOL_SOCKET && cm->cmsg_type == SCM_TIMESTAMPING_OPT_STATS) {
		void *jstats = (void *)CMSG_DATA(cm);
		jcat_scm_opt_stats(priv, jstats, cm->cmsg_len - hdr_len, &send);
	} else if (cm->cmsg_level == SOL_CAN_J1939 && cm->cmsg_type == SCM_J1939_ERRQUEUE) {
		serr = (void *)CMSG_DATA(cm);
	} else
		warnx("serr: not supported type: %d.%d",
		      cm->cmsg_level, cm->cmsg_type);

	if (serr && tss) {
		if (serr->ee_origin == SO_EE_ORIGIN_TIMESTAMPING) { // für den ACK
			if (serr->ee_errno != ENOMSG)
				warnx("serr: tx error: %i, %s", serr->ee_errno,
				      strerror(serr->ee_errno));

			print_timestamp(tss, serr->ee_info,
					serr->ee_data, send);
			return serr->ee_info == SCM_TSTAMP_SCHED ? -EINTR : 0;
		} else if (serr->ee_origin == SO_EE_ORIGIN_LOCAL) { // für err
			if (serr->ee_info != J1939_EE_INFO_TX_ABORT)
				warnx("serr: unknown ee_info: %i", serr->ee_info);


			__print_timestamp("  ABORT", &tss->ts[0], serr->ee_data, send);
			warnx("serr: tx error: %i, %s", serr->ee_errno,
			      strerror(serr->ee_errno));

			return serr->ee_errno;
		} else
			error(1, 0, "serr: wrong origin: %u", serr->ee_origin);

	}

Here is an example output of jcat command:
root@DistroKit:~  jcat -i /test_100k  can0:0x80 :0x90,0x12300
    ENQ: 1551398572 s 888773 us (seq=0, send=1764)
    ENQ: 1551398573 s 353498 us (seq=0, send=3549)
    ENQ: 1551398573 s 818241 us (seq=0, send=5334)
    ENQ: 1551398574 s 282923 us (seq=0, send=7119)
    ENQ: 1551398574 s 793238 us (seq=0, send=8904)
    ENQ: 1551398575 s 353244 us (seq=0, send=10689)
    ENQ: 1551398575 s 817879 us (seq=0, send=12474)
    ENQ: 1551398576 s 313210 us (seq=0, send=14259)
    ENQ: 1551398576 s 777841 us (seq=0, send=16044)
    ENQ: 1551398577 s 242604 us (seq=0, send=17829)
    ENQ: 1551398577 s 707297 us (seq=0, send=19614)
    ENQ: 1551398578 s 172032 us (seq=0, send=21399)
    ENQ: 1551398578 s 636739 us (seq=0, send=23184)
    ENQ: 1551398579 s 193257 us (seq=0, send=24969)
    ENQ: 1551398579 s 657871 us (seq=0, send=26754)
    ENQ: 1551398580 s 540311 us (seq=0, send=28539)
    ENQ: 1551398581 s 4942 us (seq=0, send=30324)
.....
    ENQ: 1551398599 s 193025 us (seq=0, send=89229)
    ENQ: 1551398599 s 673031 us (seq=0, send=91014)
    ENQ: 1551398600 s 137643 us (seq=0, send=92799)
    ENQ: 1551398600 s 602364 us (seq=0, send=94584)
    ENQ: 1551398601 s 66971 us (seq=0, send=96369)
    ENQ: 1551398601 s 531581 us (seq=0, send=98154)
    ENQ: 1551398601 s 996315 us (seq=0, send=99939)
    ENQ: 1551398602 s 460958 us (seq=0, send=101724)
    ENQ: 1551398602 s 624222 us (seq=0, send=102354)
    ACK: 1551398602 s 628892 us (seq=0, send=102400)

ENQ - means, some or all packets was queued and the stack is
waiting until the queue have more space or we get an ACK.
ACK - (E)TP the session was completed without any error.
amount of send bytes is attached in to netlink compatible CMSG and
can be extended without braking compatibility..

2019.04.27 v2:
- make MSG_ERRQUEUE optional and disabled by default
- init info struct in sendmsg
- add verbose TX status support.

2019.04.25 v1:
deprecated description was removed.

Oleksij Rempel (3):
  j1939: transport: store error in to session
  j1939: add MSG_ERRQUEUE support
  j1939: check supported  recv*() flags

 include/uapi/linux/can/j1939.h |  12 ++++
 net/can/j1939/j1939-priv.h     |  12 ++++
 net/can/j1939/socket.c         | 103 ++++++++++++++++++++++++++++++++-
 net/can/j1939/transport.c      |  14 ++++-
 4 files changed, 137 insertions(+), 4 deletions(-)

-- 
2.20.1

