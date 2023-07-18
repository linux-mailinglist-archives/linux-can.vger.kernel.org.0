Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D487758060
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGRPGG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjGRPGF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 11:06:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F27FC
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 08:06:04 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLmH5-0003Zm-7h
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 17:06:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7DA1E1F4364
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 15:06:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C47961F435A;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cd18b8d6;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/3] can: gs_usb: convert to NAPI
Date:   Tue, 18 Jul 2023 17:05:47 +0200
Message-Id: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEuqtmQC/32NWwqDMBBFtyLz3SlxfET65T6KFNuMOlASSVQsk
 r03dQH9PAfuuQcE9sIBbtkBnjcJ4mwCumTwmno7MopJDKSoUFpVOIbHGp7od3TD8Ha9QU1kiKp
 am7qBtJs9D7KfzXuXeJKwOP85L7b8Z//VthwVNqy5rLlUeaHbme24Lt5Z2a+GoYsxfgHYi3YAt
 wAAAA==
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uxRjZhCVnZQ3Hc3+z77ztlj39VkzpAFB57mN+NgkspY=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktqpPlvDQ/+tZJ4AWX1mOUFj4sCsFGSlwE7n8G
 MfdcYdNbj6JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLaqTwAKCRC+UBxKKooE
 6NbCB/9XkydiDr7/aFhz6d8OEV8XwOFoPLKtZ0SQRzE4jjwtad++ToQ3JEi226KqjGu9MiXGlof
 8JHV64PQ7EMFpJ+Y+2FA/JXnYEY6+rKwD2XVDi/zo2cyJReTSCGq/GtqBsM4byfSHuW/6LhuNpN
 drSQkNBwwLEt3CvHG/DHBShlYbLmPfjRRFbRjAht8jrYze/Z3Zm/0MMWCNDTIIwBQRiuGUqy3yd
 1S8OoVVju94PCw2xU0vhsVIUmsWXnP7MpsseikroPWvuRX3NNGI3emGhSmaaYhCwbfpJq+cbcH7
 ZCFUtStMEsiBE37DOBFIrIyk4FT85PkTMhK158lsGKVY6mjK
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

Traditionally USB drivers used netif_rx to pass the received CAN
frames/skbs to the network stack. In netif_rx() the skbs are queued to
the local CPU. If IRQs are handled in round robin, CAN frames may be
delivered out-of-order to user space.

To support devices without timestamping the TX path of the rx-offload
helper is cleaned up and extended:
- rename rx_offload_get_echo_skb() ->
  can_rx_offload_get_echo_skb_queue_timestamp()
- add can_rx_offload_get_echo_skb_queue_tail()

The last patch converts the gs_usb driver to NAPI with the rx-offload
helper.

This series depends on the gs_usb cleanup series:
https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de

Link: https://lore.kernel.org/all/559D628C.5020100@hartkopp.net
Link: https://github.com/candle-usb/candleLight_fw/issues/166
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- move cleanup patches into separate series:
  https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de
- use GS_NAPI_WEIGHT instead of hard coded 32
- move can_rx_offload_add_manual()/can_rx_offload_del() to
  gs_make_candev()/gs_destroy_candev()
- Link to v1: https://lore.kernel.org/all/20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de

---
Marc Kleine-Budde (3):
      can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
      can: rx-offload: add can_rx_offload_get_echo_skb_queue_tail()
      can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception

 drivers/net/can/dev/rx-offload.c              | 36 ++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        |  4 +-
 drivers/net/can/m_can/m_can.c                 |  8 +--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |  6 +-
 drivers/net/can/ti_hecc.c                     |  4 +-
 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/gs_usb.c                  | 85 +++++++++++++++++++++------
 include/linux/can/rx-offload.h                | 11 ++--
 8 files changed, 116 insertions(+), 39 deletions(-)
---
base-commit: 59062ea9b7dc0bc8d6f0bb03283d8c6fb170f6da
change-id: 20230705-gs_usb-rx-offload-722d22567d68

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


