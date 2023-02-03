Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E2689329
	for <lists+linux-can@lfdr.de>; Fri,  3 Feb 2023 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBCJIZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Feb 2023 04:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjBCJIW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2023 04:08:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB0298E3
        for <linux-can@vger.kernel.org>; Fri,  3 Feb 2023 01:08:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675415297; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zj7qnxGaYWQynn+2tidBnjytzfMqd/az4iEoEzw4QJRMol7R2M/vb6SYj12cDzI0cU
    m1dVVQUEZst+b9q6S7DQXae8Zb6gB/V6FYW1rh5K2+BHSSe531JaHXrPwkcusnjxLVx/
    WMxapmbtUj00VdIDR8ZfYwCF1c/exM+8KyRX7lYUy7e4CoRgCOMb1ktNI+46g/XK0cYx
    wWK2uKQ1mDat0tJdJlkQSjc2+EqACFzngtPOx4WHZqObJT0/Q4GzVNRcnB17VZVO7K7O
    Lce1O2YtZsIFyY2LmulrkfLGJw7RAI5nYtCxyuwK3Fr4dnkCtRat+0EGZeBurHMbSKyD
    oHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675415297;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=732n/VjfELq1nbsMWMBwOfUg0ntThAcZEBmqKGrVwfY=;
    b=pxGSUtkX21eYaqzF6UXfiXPqfqCiJiE6jP32TA12qi1boG4xWru+Q/ir0M2XOQTNMi
    8z3cR7+KbsGfO2gL0WaDYjIs31cEMsAM/KkVrI18PM8QupRCsPahp4zm31JvQKxG+20P
    KT6Huta4k6KDMBkm72Am+Y+uugBhNtAMpJsyK1LwFkAxPRRG8veJixGYms9DiLIn3E3j
    RjecbgJffEM8EtEBt1rm39sNLgWVFwUAp/BAkNkZ+EIF7bjRBCTf4dNKJByltyAOw51p
    17+7WMZ2vmuDpzM9H2O+J6mufTaq8TROKO5oOG4h4Lr1dKTd59hsmAXk65/ZylEK0KJS
    vmKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675415297;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=732n/VjfELq1nbsMWMBwOfUg0ntThAcZEBmqKGrVwfY=;
    b=UGT7QYHXfI+r+QNW/i6ECLW8ixxXqMymG+UYC/fTJmfpVM65qkwMCzNF0R9uMtJLAG
    j4tUiSLf3/jAVfy79m9JhqGGE/bkKj49OYdQEKLvwu6JHsEe2RtwaGpCWdCYI3jGcZhX
    s+ELB3I+mw17RvHsGzLRMqNF1Wvc35kPwYh0RjYBK+rhkITGw/yjAOqFP/x6Iak+wuld
    EY/2T4NaCQr4n4LLmDsUk3SE9Ae0xsiF4hE2osLW62flE/43KmzDyrbFK4pTKOwDGZiM
    PAcL/9ufesVhXf0bGqzvLDhw8mN1hmVENlgSfKJNs/dgU4kGlyHIrvQd4aPYFDjqirRV
    r3zQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcehrrd"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z1398GUBK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Feb 2023 10:08:16 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next] can: raw: use temp variable instead of rolling back config
Date:   Fri,  3 Feb 2023 10:08:07 +0100
Message-Id: <20230203090807.97100-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce a temporary variable to check for an invalid configuration
attempt from user space. Before this patch the value was copied to
the real config variable and rolled back in the case of an error.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index ba86782ba8bb..f64469b98260 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -521,10 +521,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
 	can_err_mask_t err_mask = 0;
+	int fd_frames;
 	int count = 0;
 	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -662,21 +663,21 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			return -EFAULT;
 
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(ro->fd_frames))
+		if (optlen != sizeof(fd_frames))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
+		if (copy_from_sockptr(&fd_frames, optval, optlen))
 			return -EFAULT;
 
 		/* Enabling CAN XL includes CAN FD */
-		if (ro->xl_frames && !ro->fd_frames) {
-			ro->fd_frames = ro->xl_frames;
+		if (ro->xl_frames && !fd_frames)
 			return -EINVAL;
-		}
+
+		ro->fd_frames = fd_frames;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
 		if (optlen != sizeof(ro->xl_frames))
 			return -EINVAL;
-- 
2.39.0

