Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734756F8119
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEEK6Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjEEK6P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 06:58:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9318934
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 03:58:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1put8e-0003fn-On
        for linux-can@vger.kernel.org; Fri, 05 May 2023 12:58:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2EC621BE7E2
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 10:58:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F0ADD1BE7D6;
        Fri,  5 May 2023 10:58:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7dcd2f2e;
        Fri, 5 May 2023 10:58:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/2] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
Date:   Fri,  5 May 2023 12:58:08 +0200
Message-Id: <20230505-fox-endorphin-bec6e5aa71a1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505105809.76898-1-mkl@pengutronix.de>
References: <20230505105809.76898-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

The control message provided by isotp support MSG_CMSG_COMPAT but
blocked recvmsg() syscalls that have set this flag, i.e. on 32bit user
space on 64 bit kernels.

Link: https://github.com/hartkopp/can-isotp/issues/59
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index a750259cb79c..84f9aba02901 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1139,7 +1139,7 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	struct isotp_sock *so = isotp_sk(sk);
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (!so->bound)
-- 
2.39.2


