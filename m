Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061F74812C
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGEJka (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGEJkX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 05:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1D1719
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 02:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D7E614D4
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A36DC433CC;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550020;
        bh=ThZ9FkfbWFwJDXJbUIQrf5bgI70h1HawvSLzUEKqquo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=gQWRnYzdqi9Q0JJpECrSR3pta9h3tpOak76p7hFc/fpqFQlBqT+4cdy86D+89XdXJ
         fzbeKch4i0PtajrsTEjbmKFXK6YAqVNgzvSGG+J318AGYfLMcxzQG1RxFyB/2mH+QO
         VBQKIyJErCrzxZRwvPycTlSRodDC0a23S8rB9BFcYYJTAI6Zj3OIOaXA/fNoU9jaFM
         4y7eQ7Uo7zp+r+qX226JJOVwtv0p+I8AHZLsZVKAzUIMdlWL++zeWO/Se7tUBemM/x
         hC+5DnAGNxbdoTiLo+1ytjQKXcLR6UhCe8qDuH36ZNC3jUHV3P045t5o+guTn/d1T+
         NIszHsdWMdw1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 7924DC001DF;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
From:   Marc Kleine-Budde via B4 Relay 
        <devnull+mkl.pengutronix.de@kernel.org>
Date:   Wed, 05 Jul 2023 11:39:55 +0200
Subject: [PATCH 4/6] can: gs_usb: gs_usb_receive_bulk_callback(): make use
 of netdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-gs_usb-rx-offload-v1-4-8e7e46e40137@pengutronix.de>
References: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
In-Reply-To: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zz+nwXmpKwhnMzawf01FuKz+6ARnpv+x4HcZTBNnWBg=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBkpTp5xh6MS+Vi5+6emmBSy+0xA5bo0XTWpnhLV
 T7sUsVKHkuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZKU6eQAKCRC+UBxKKooE
 6CMcCACKom74WEQ+ZPXd5GOnby36AODdI7XaV+NvXtCf6D0guHCaZ9ZQ0E3dCbbEx/jI+65Fstg
 TUfYKYfkFaNHhS5CS65x1a7xmcz40t44hyHy3B0oAuOGnqXrBalrLSzUcbuFUw9rAKvKa6tsdqB
 dULYSNN0LCkR8rlc1eiuSRqqfIkcFYi1nD41yyhdI6a10nridwgPHStsCv9hEPaZz1xAn/dKfsC
 T2ibdWmLVegpXNOChCcuXGEDCrBepME6NCcIya8NmsPuR0hkaUKj4kLPG+/6B2XFPHDH9RfmXRe
 LlBYnm9aB9Id9sbaltL0oR3XxwnSRI6GMJaWgf1/i/FYlxBe
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Endpoint-Received: by B4 Relay for mkl@pengutronix.de/default with auth_id=52
X-Original-From: Marc Kleine-Budde <mkl@pengutronix.de>
Reply-To: <mkl@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Make use the previously assigned variable netdev instead of using
dev->netdev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a60153f4cf1d..b66af9d0ce6a 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -562,7 +562,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	if (hf->echo_id == -1) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
-			skb = alloc_canfd_skb(dev->netdev, &cfd);
+			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
 
@@ -575,7 +575,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cfd->data, hf->canfd->data, cfd->len);
 		} else {
-			skb = alloc_can_skb(dev->netdev, &cf);
+			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
 				return;
 

-- 
2.40.1

