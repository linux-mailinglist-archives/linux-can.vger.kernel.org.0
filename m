Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302FF7B7BDE
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjJDJYS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjJDJYS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7949E
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny72-0005Lf-SA
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny72-00AzjB-8u
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EF75822EB39
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3FAA122EB2A;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d32296fc;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 00/27] can: at91: add can_state_get_by_berr_counter()
 helper, cleanup and convert to rx_offload
Date:   Wed, 04 Oct 2023 11:23:19 +0200
Message-Id: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgvHWUC/x3MTQqAIBBA4avErBN0jP6uEhFDjTUQGhoRRHdPW
 n6L9x5IHIUT9MUDkS9JEnyGKQuYN/IrK1myATVao3Wl6OzMNJNX8Z6Cc3ugRVmssaWm0uQQcnl
 EdnL/12F83w9Gn8DdZQAAAA==
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=AUvoggBDIWmGr8CY4Pdjxltd9LDGwt64yIoNVWoM2wQ=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8K+/BFC7buLRIdCGb58cY2r0rh7f91qh0WG
 KSA3tSx2OWJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vCgAKCRC+UBxKKooE
 6I8sB/4qhqsTgwYA3Jjv/CcSvWolJjRgAPkyRf4sBvI7C7XVFA2szBfKv8owVJKOdAbfSomtsxc
 lFfQTJKEmr4eIUWFi9835ou+1MAOVgFbxl1ZxkuYbhqDJtCmiTUOHoomZKgar6uWYx1hy8MFLQQ
 2Zyjgs494QRkvOpUf3w4lxwJLEzUzrb2QXa4TMq+8X53jhHwSrh10Du2B/Gg8N9crXGtWOZTHFi
 OaNivigJfkbp519sHnJHj+rAXHuhBB1pmbGZZ2gMk1eioAQus1u4lsmrPJiXpLQP2N5QHGcuE70
 J/ZFFv8PFD/ROgSRtjNQuYoHiFzUyIrAvk4ln4+QfT9DUJEV
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series first introduces the can_state_get_by_berr_counter()
helper function. It returns the current TX and RX state depending on
the provided CAN bit error counters. It will be later used by the
at91_can driver.

The remaining patches of this series first clean up the at91_can
driver, clean up the bus- and line error (including bus-off) handling,
and then convert it use the rx_offload helper. The driver works better
under high system load and the order of received CAN frames is better
maintained.

Due to a hardware limitation the converted driver could trigger a race
condition in the can_restart() CAN bus-off handler. The patch series
[1] fixes the issue.

[1] https://lore.kernel.org/all/20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (27):
      can: dev: add can_state_get_by_berr_counter() to return the CAN state based on the current error counters
      can: at91_can: use a consistent indention
      can: at91_can: at91_irq_tx(): remove one level of indention
      can: at91_can: BR register: convert to FIELD_PREP()
      can: at91_can: ECR register: convert to FIELD_GET()
      can: at91_can: MMR registers: convert to FIELD_PREP()
      can: at91_can: MID registers: convert access to FIELD_PREP(), FIELD_GET()
      can: at91_can: MSR Register: convert to FIELD_PREP()
      can: at91_can: MCR Register: convert to FIELD_PREP()
      can: at91_can: add more register definitions
      can: at91_can: at91_setup_mailboxes(): update comments
      can: at91_can: rename struct at91_priv::{tx_next,tx_echo} to {tx_head,tx_tail}
      can: at91_can: at91_set_bittiming(): demote register output to debug level
      can: at91_can: at91_chip_start(): don't disable IRQs twice
      can: at91_can: at91_open(): forward request_irq()'s return value in case or an error
      can: at91_can: add CAN transceiver support
      can: at91_can: at91_poll_err(): fold in at91_poll_err_frame()
      can: at91_can: at91_poll_err(): increase stats even if no quota left or OOM
      can: at91_can: at91_irq_err_frame(): call directly from IRQ handler
      can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
      can: at91_can: at91_irq_err(): rename to at91_irq_err_line()
      can: at91_can: at91_irq_err_line(): make use of can_state_get_by_berr_counter()
      can: at91_can: at91_irq_err_line(): take reg_sr into account for bus off
      can: at91_can: at91_irq_err_line(): make use of can_change_state() and can_bus_off()
      can: at91_can: at91_irq_err_line(): send error counters with state change
      can: at91_can: at91_alloc_can_err_skb() introduce new function
      can: at91_can: switch to rx-offload implementation

 drivers/net/can/Kconfig    |   1 +
 drivers/net/can/at91_can.c | 998 ++++++++++++++++++---------------------------
 drivers/net/can/dev/dev.c  |  22 +
 include/linux/can/dev.h    |   4 +
 4 files changed, 432 insertions(+), 593 deletions(-)
---
base-commit: 473267a4911f2469722c74ca58087d951072f72a
change-id: 20231004-at91_can-rx_offload-32628a740af2

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


