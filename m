Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F9757A23
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGRLLe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGRLLd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B91738
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibh-0006Xq-Lm
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A29071F40D4
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CBF261F40C3;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c09c0d90;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 00/11] can: gs_usb-cleanups: various clenaups
Date:   Tue, 18 Jul 2023 13:10:22 +0200
Message-Id: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5ztmQC/x3MQQqAIBBA0avErBPUgoGuEhFWow2EhUMRiHdPW
 r7F/xmEEpPA0GRI9LDwGStM28C6uxhI8VYNVttOo0EVZL5lUetBLt6XKELvDSJ53Wuo1ZXI8/s
 fx6mUD3LSyP5hAAAA
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GIVERpizgfa5nDISqplPwc8thb+299TxoK9gP5usGm8=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMfyONeIwMXTbnc1KTtOLdfXojQ4HfROygSP
 SgwmA0NxO2JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzHwAKCRC+UBxKKooE
 6JdiB/0bfKL4OKbNEvXw3Am7V3cskJ0cZQTtuNSTa+Md+in6/VZBkvIYA4bOlwSqgULj005KfGs
 jQZOW4RGLaflGM+s+qwrfNoyvZbFWaL5XfOmI0eWgyNX9gG5c7oHPi74KvkNgrHQybOM4xOvL9v
 4NWPLEIKNa9BciRKLv6WXbaiMEQrWGcLfzzgJRLBWSXRsSEQriUVP4khZ8pKMECI7S7Yy4nqttz
 aPyR7PA5AMZ6uTF+/Oi3Gsj9qiHE0x8wh6d4XMbVCPL7qyd056BB6JjNQdcXDAnvXMc5ZAzyAEn
 9vEFcvM9KHR1YSGFMcwkAIcAn0V0X5ka4aBUV/391cFCgCok
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

This is a cleanup series of the gs_usb driver. Align the driver more
to the kernel coding style, make use of locally defined variables,
clean up printouts in various error paths, remove some not needed
usb_kill_anchored_urbs() from the shut down paths.

This series depends on the PR
https://lore.kernel.org/all/20230717180938.230816-1-mkl@pengutronix.de
and the patch
https://lore.kernel.org/all/20230718-gs_usb-fix-can-state-v1-1-f19738ae2c23@pengutronix.de

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (11):
      can: gs_usb: remove leading space from goto labels
      can: gs_usb: gs_usb_probe(): align block comment
      can: gs_usb: gs_usb_set_timestamp(): remove return statements form void function
      can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of netdev
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
      can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
      cam: gs_usb: gs_can_close(): don't complain about failed device reset during ndo_stop
      can: gs_usb: gs_destroy_candev(): remove not needed usb_kill_anchored_urbs()
      can: gs_usb: gs_usb_disconnect(): remove not needed usb_kill_anchored_urbs()

 drivers/net/can/usb/gs_usb.c | 112 ++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 60 deletions(-)
---
base-commit: 13561659276838b7f1ab7214b28fba51795bbdcd
change-id: 20230717-gs_usb-cleanups-e7ff177ef040

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


