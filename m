Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C15757A2C
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGRLLl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGRLLf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3171BCC
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibj-0006ZF-HR
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6D3D21F40EC
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 540DD1F40CB;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 409f67bf;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:27 +0200
Subject: [PATCH 05/11] can: gs_usb: gs_usb_receive_bulk_callback(): make
 use of netdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-5-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3Fapc0dkuGeArLTGs8EknGJ71EiP3dp4rmo2rjVHPOA=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMvhaSH6DXnfdW4QjCZ8mcewptMp9tJHya23
 XNOvbe3YFOJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzLwAKCRC+UBxKKooE
 6EUVB/449XzJTcZxXfq4mzsc7VSmvBAl2lFSpb9xDW/bE+6kGRgbI6A9C9NRlRDy+bV8yluInwC
 oDAy9OCkRwRFYal+KEks/kFaQiBC83VAWPyv3lYtPXBbJNTFQ4EoCMP7LzxB14QoTjwfxiFjjxD
 LXrQEZbtcpNfokelOXKXBOPnT0fTKrTPmQgP/YT5NcqS1wQNYEJPm3D8VygfpfkPZzUzS7eTT+D
 8qhragOpJzC/w4632V5pJQmspkfN4mB6dGQsW8pg5UVROrK8KIWlCmk+eCpolhGmvQ6zGc3bzVi
 FC9FD4KjReWkx16quRzLLJdGwurtbr/BNAfcBKvp4z4Bi3e5
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Make use the previously assigned variable netdev instead of using
dev->netdev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 441143ad740b..04cbe949c290 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -565,7 +565,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	if (hf->echo_id == -1) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
-			skb = alloc_canfd_skb(dev->netdev, &cfd);
+			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
 
@@ -578,7 +578,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cfd->data, hf->canfd->data, cfd->len);
 		} else {
-			skb = alloc_can_skb(dev->netdev, &cf);
+			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
 				return;
 

-- 
2.40.1


