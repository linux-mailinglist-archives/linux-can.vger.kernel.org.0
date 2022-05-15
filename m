Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E592527910
	for <lists+linux-can@lfdr.de>; Sun, 15 May 2022 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiEOSQu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 May 2022 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiEOSQt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 May 2022 14:16:49 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8A2BB03
        for <linux-can@vger.kernel.org>; Sun, 15 May 2022 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652638605;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=i26M/CXwj42jITr+yjCPegVkz+JLbilsJ/srXSz8W/k=;
    b=p26Sc3BGVxKAmWcmrhYd5VpY9A09yv+JSyTHOmZzBt2v4h5AF74M1HaIn68lmMhVEq
    Yfeoc4caejPya1h0SbeRoYp90tUUDvl2LjAk/9NseIcLoqlQXz8r9RDy+fCmJcSkeeQW
    UJYHIUuZzw3XRkwFZWxbqy0mnre7u6mOZh8Ad+s6gDp3Ijpbgyvqs0UOAZqoo9P6ZIoQ
    d7c+9dI1Xth4ZE23FvB53MU8OKtI3tmms93B3qTHgzhEmLAHTk7pmqG8ULcAzhYJvE4r
    OSU6AWHQHH2sVRTaWgLpv6bFSHS9FtjtS7hEjKEpTxsHJZm9IHoUcreTLpEvhawg55V0
    JUpw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWNaXpvraas"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4FIGj6vo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 15 May 2022 20:16:45 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH can-next] can: isotp: return -EINVAL on incorrect CAN ID formatting
Date:   Sun, 15 May 2022 20:16:33 +0200
Message-Id: <20220515181633.76671-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit 3ea566422cbd ("can: isotp: sanitize CAN ID checks in isotp_bind()")
checks the given CAN ID address information by sanitizing the input values.

This check (silently) removes obsolete bits by masking the given CAN IDs.

Derek Will suggested to give a feedback to the application programmer when
the 'sanitizing' was actually needed which means the programmer provided
CAN ID content in a wrong format (e.g. SFF CAN IDs with a CAN ID > 0x7FF).

Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 2caeeae8ec16..4a4007f10970 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1230,10 +1230,15 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (rx_id & CAN_EFF_FLAG)
 		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		rx_id &= CAN_SFF_MASK;
 
+	/* give feedback on wrong CAN-ID values */
+	if (tx_id != addr->can_addr.tp.tx_id ||
+	    rx_id != addr->can_addr.tp.rx_id)
+		return -EINVAL;
+
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
 
-- 
2.30.2

