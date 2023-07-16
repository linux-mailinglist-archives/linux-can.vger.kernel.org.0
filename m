Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36CE75510B
	for <lists+linux-can@lfdr.de>; Sun, 16 Jul 2023 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGPTeK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Jul 2023 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGPTeK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 15:34:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F6F4
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 12:34:08 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qL7VO-0002th-Uz
        for linux-can@vger.kernel.org; Sun, 16 Jul 2023 21:34:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9C0CE1F1ED5
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 19:34:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A20E81F1EC9;
        Sun, 16 Jul 2023 19:34:04 +0000 (UTC)
Received: from [172.20.34.65] (ip6-loopback [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a1d06eab;
        Sun, 16 Jul 2023 19:34:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] can: gs_usb: fix time stamp counter initialization
Date:   Sun, 16 Jul 2023 21:33:48 +0200
Message-Id: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxGtGQC/x3MQQqAIBBA0avErBswC4quEhGmY80iC8ciiO6et
 Hzw+Q8IRSaBvngg0sXCe8ioygLsasJCyC4btNK1aiuNi0ynzOj5xsQboSSzHWj3MySK2MyuVtp
 2qjMe8uOIlMv/P4zv+wE3+4cubwAAAA==
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=qnMuwVN18fuJqaclW9A3XnpDbA78zoE3bCHB7HN1IMY=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktEYjNEnUxo7P9+EVm7xR9Bfe5aJj+G7WOPuEV
 RZReGD+b2yJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLRGIwAKCRC+UBxKKooE
 6MtGB/wKB9cBTSVhC5EgK0YjpcERasoKQhqwqoQ2AIGNtcBvTDDQcoXu465NOmxmPI4BjP9EFqZ
 KGtLlJ/+7Zk0WUAfcfR0QhFqz3FGsD9pFO3P/7RrrcR7NHlXvzi6lFd97v7274lJz98KDX+40j3
 DDfVr/ipgBoTHnPO3cQ3+3432ouiQo6gVwBX2eFvPAfX+EdiTj+nmEZEFlhkX7rYCnTE4CAh3hP
 p6zNOijJLxiHSF/hcUAYfiZUxHbG1ToKFnfiLwehVzh69MJ3gyy1oN8WdZS+MHU8XDoV46ftAU4
 gWG6rLDTSg59oPmmmdmyVNeVCrALBX+jYNoWDtAVje+Nhihp
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

During testing I noticed a crash if unloading/loading the gs_usb
driver during high CAN bus load.

The current version of the candlelight firmware doesn't flush the
queues of the received CAN frames during the reset command. This leads
to a crash if hardware timestamps are enabled, it a URB from the
device is received before the cycle counter/time counter
infrastructure has been setup.

First clean up then error handling in gs_can_open().

Then, fix the problem by converting the cycle counter/time counter
infrastructure from a per-channel to per-device and set it up before
submitting RX-URBs to the USB stack.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (2):
      can: gs_usb: gs_can_open(): improve error handling
      can: gs_usb: fix time stamp counter initialization

 drivers/net/can/usb/gs_usb.c | 130 ++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 56 deletions(-)
---
base-commit: 0dd1805fe498e0cf64f68e451a8baff7e64494ec
change-id: 20230712-gs_usb-fix-time-stamp-counter-4bd302c808af

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


