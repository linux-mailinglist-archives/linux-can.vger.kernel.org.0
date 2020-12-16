Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB02DC5BE
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 18:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgLPRxe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 12:53:34 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:36681 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLPRxe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Dec 2020 12:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608140981;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=hn4hYD6FTELXNsFaccHJAHanh1B+Iiie+vBhA89lKZA=;
        b=n2hlzVdY/dCBJrAEC6RKBMB848DMIBzbuveKH4zsjguuJgncEkxg7PhQF5gBRzAGYj
        iQ4TX7ieSxz8eokou/WSmWzRsKPriDE+TViPd+RYqZ6/kr5EJI4WqKM3OKyo1FNYt9w5
        Vv8WZx4z1jHJpXBoHh/e4kfOgaFfRM+J2B26up5TNcvULTJ0GzdVVrEItkEdvgMlFT+B
        Ijx5X6PWifUxPuoZa7zP8rVELocTNC2hXHy2KI8BnzZfFi1vTxLsfwbsHuxn3G5vomeh
        P2lgrD/BnJHzMmQ+l9TR/cCN/265p9rO8Tcyue1CLCsIuzh1uOSwMmepQyEORsuY7zxH
        UbOA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lu8GW276Zq6FBnY="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.8.6 DYNA|AUTH)
        with ESMTPSA id h04d32wBGHne14h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 16 Dec 2020 18:49:40 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Phillip Schichtel <phillip@schich.tel>
Subject: [RFC PATCH can-next] can: raw: return -ERANGE when filterset does not fit into user space buffer
Date:   Wed, 16 Dec 2020 18:49:28 +0100
Message-Id: <20201216174928.21663-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Multiple filters (struct can_filter) can be set with the setsockopt()
function, which was originally intended as a write-only operation.

As getsockopt() also provides a CAN_RAW_FILTER option to read back the
given filters, the caller has to provide an appropriate user space buffer.
In the case this buffer is too small the getsockopt() silently truncates
the filter information and gives no information about the needed space.
This is safe but not convenient for the programmer.

In net/core/sock.c the SO_PEERGROUPS sockopt had a similar requirement
and solved it by returning -ERANGE in the case that the provided data
does not fit into the given user space buffer and fills the required size
into optlen, so that the caller can retry with a matching buffer length.

This patch adopts this approach for CAN_RAW_FILTER getsockopt().

Reported-by: Phillip Schichtel <phillip@schich.tel>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 6ec8aa1d0da4..37b47a39a3ed 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -663,14 +663,22 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	case CAN_RAW_FILTER:
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
 
-			if (len > fsize)
-				len = fsize;
-			if (copy_to_user(optval, ro->filter, len))
-				err = -EFAULT;
+			/* user space buffer to small for filter list? */
+			if (len < fsize) {
+				/* return -ERANGE and needed space in optlen */
+				err = -ERANGE;
+				if (put_user(fsize, optlen))
+					err = -EFAULT;
+			} else {
+				if (len > fsize)
+					len = fsize;
+				if (copy_to_user(optval, ro->filter, len))
+					err = -EFAULT;
+			}
 		} else {
 			len = 0;
 		}
 		release_sock(sk);
 
-- 
2.29.2

