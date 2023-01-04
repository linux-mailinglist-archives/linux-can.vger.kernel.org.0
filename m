Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D565DD90
	for <lists+linux-can@lfdr.de>; Wed,  4 Jan 2023 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjADUTM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Jan 2023 15:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjADUTM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Jan 2023 15:19:12 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1310E
        for <linux-can@vger.kernel.org>; Wed,  4 Jan 2023 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672863547;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=roVfIsgUxzwEzrmqtgNBvnmqhhponpf5+vQrAI7fd0A=;
    b=D3k2leY6pTTYISz5tl2jWvk6USXcHhGpdOUY9DGDTjmeEBOy5puIZSW9+jx/hR57x9
    7wsYWugwkJ3NiktaKDRkmmnIZrd8vBovR3QCFW+7JS2HTuougcqn2QUI72iwZw1Nik2z
    o08MFrJspLJ8vz634LmhGvi8AuoXGW6Ii+07AorTrDHXybMDVrDtJACzH9xjrrEdM70e
    4/ibu0SkJ3tYzeeoWJsIbLFXvtRyuD5QRYlKFmsePpJRybFvo0FWuskqnpqET2hSYGPH
    ujiISy/xcsZVo89SOFwLBluuQvF74UlBtF1zk6+NrxrNJ0HmBsZJymqzF5VuJT7VfQu0
    31bA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJygjsS+Kjg=="
X-RZG-CLASS-ID: mo00
Received: from blue.lan
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id j06241z04KJ71H1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 4 Jan 2023 21:19:07 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+5aed6c3aaba661f5b917@syzkaller.appspotmail.com
Subject: [PATCH can-next] can: isotp: check CAN address family in isotp_bind()
Date:   Wed,  4 Jan 2023 21:18:44 +0100
Message-Id: <20230104201844.13168-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add missing check to block non-AF_CAN binds.

Syzbot created some code which matched the right sockaddr struct size
but used AF_XDP (0x2C) instead of AF_CAN (0x1D) in the address family
field:

bind$xdp(r2, &(0x7f0000000540)={0x2c, 0x0, r4, 0x0, r2}, 0x10)
                                ^^^^
This has no funtional impact but the userspace should be notified about
the wrong address family field content.

Link: https://syzkaller.appspot.com/text?tag=CrashLog&x=11ff9d8c480000
Reported-by: syzbot+5aed6c3aaba661f5b917@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index fc81d77724a1..9bc344851704 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1218,10 +1218,13 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	int notify_enetdown = 0;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
+	if (addr->can_family != AF_CAN)
+		return -EINVAL;
+
 	/* sanitize tx CAN identifier */
 	if (tx_id & CAN_EFF_FLAG)
 		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		tx_id &= CAN_SFF_MASK;
-- 
2.35.1

