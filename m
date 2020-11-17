Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED9C2B67F5
	for <lists+linux-can@lfdr.de>; Tue, 17 Nov 2020 15:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgKQOyz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Nov 2020 09:54:55 -0500
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:59550 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727422AbgKQOyz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Nov 2020 09:54:55 -0500
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 09:54:53 EST
Received: from de-out1.bosch-org.com (snat-lb41g3-dmz-psi-sl1-maildeferred.fe.ssn.bosch.com [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 4Cb7ym21m4z1BB
        for <linux-can@vger.kernel.org>; Tue, 17 Nov 2020 15:45:20 +0100 (CET)
Received: from fe0vm1649.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 4Cb7yk5bXnz4f3lwv;
        Tue, 17 Nov 2020 15:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1605624318;
        bh=rNreBz9tcS3Q2kVTNLarcOTT5RXq5VFV0bGKMsjq8CU=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=CxZoE6B02KOFYLKuxx207aN5hUBf4WNo2qmTRuASHxEUeuYKhU+1FKHiiSfuoBt5m
         Ov5hVa2DisGQPElyV4wSKNmRToMete3xj5T5AnFXyP57Q5POAR3jIBaqw+VRZagT40
         V2pLxsbz9Dwxik2mWNw/ByeS1ayI8nsWsiYjcEY8=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 4Cb7yk5M4Jz3xQ;
        Tue, 17 Nov 2020 15:45:18 +0100 (CET)
X-AuditID: 0a3aad15-fb3ff700000022e8-d2-5fb3e1fe96f7
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 95.06.08936.EF1E3BF5; Tue, 17 Nov 2020 15:45:18 +0100 (CET)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 4Cb7yk3p3SzW7Z;
        Tue, 17 Nov 2020 15:45:18 +0100 (CET)
Received: from ninja.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2106.2; Tue, 17 Nov 2020 15:45:18 +0100
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, Wang Xin <xin.wang7@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] Fix attribute list size in do_get_nl_link()
Date:   Tue, 17 Nov 2020 15:42:22 +0100
Message-ID: <20201117144222.7809-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsXCZbVWVvffw83xBlP+qlms+j6V2WL9oiks
        Dkwe/X8NPD5vkgtgiuKySUnNySxLLdK3S+DKeH19B3vBc66Ki6cnMTUwfuXoYuTkkBAwkbiz
        7QZjFyMXh5DAdCaJvU3dTBDObkaJy/efsYNUCQlsZZRYtccMxGYT0JK4eWIHcxcjB4eIgITE
        9n5rkDCzQJbE2z+dYOXCAjYSlzduAbNZBFQluqctYASxeQWsJbZ0PmaGWCwvsXrDAWaIuKDE
        yZlPWCDmSEgcfPGCeQIj7ywkqVlIUgsYmVYxiqalGpTlGpqbGOoVJaUWVxkY6iXn525ihISM
        6A7GO90f9A4xMnEwHmKU4GBWEuF1MdkYL8SbklhZlVqUH19UmpNafIhRmoNFSZxXhWdjnJBA
        emJJanZqakFqEUyWiYNTqoHJ4f10Dq0+CaEQWa7+4vNzS63l4w2upT7WuCC67smSV3u58lR9
        Hxk0lLrrtjbsrDu3bMq1Z7UneQtPmz8IqnyyLYTl4zXbIwrHy7tW3K/OtJi3KXvHk5tdWyY0
        /l11+fLkPpOX8q1y1UULAyRfbNDQ2ztxvuShkkmnHMSY3HL/W6rYpPzi2nZc4aZFxAINhXPH
        p7fvYHrk1865ZMIxBcntzaxzO4xl2c3vfBdyeOe+Oems7s2G3V87j8u/LXx4uLo7sIcz+IzP
        ItZ9rA6yYgEzL18+4FbxcAbv/SBzrRjJ1kdh3w5tn2icdvD13sQ3GfOUTSoX35iUMzVWZdHu
        dJbfM+u/mHXYGTLEKJi3bAlUYinOSDTUYi4qTgQAnGw6V4gCAAA=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Wang Xin <xin.wang7@cn.bosch.com>

The function do_get_nl_link() retrieves attributes from the response
RTM_NEWLINK. But it calculates the attribute list size with the wrong
structure struct ifaddrmsg. According to man 7 rtnetlink, RTM_NEWLINK
message uses struct ifinfomsg instead of struct ifaddrmsg.  This causes
that additional 8 bytes are parsed and garbage attributes might be
retrieved. One of consequences is that the message will be dropped if
the garbage attribute is IFLA_IFNAME and contains an invalid interface
name.

To fix this issue, use struct ifinfomsg to calculate the size of
attribute list for RTM_NEWLINK.

Signed-off-by: Wang Xin <xin.wang7@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 src/libsocketcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index c802849..60142cc 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -411,7 +411,7 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 			struct rtattr *tb[IFLA_MAX + 1];
 
 			len =
-				nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
+				nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifinfomsg));
 			parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
 
 			/* Finish process if the reply message is matched */
-- 
2.17.1

