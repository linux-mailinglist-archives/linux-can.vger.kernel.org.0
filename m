Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34577748129
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGEJk3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGEJkW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 05:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB78E54
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 02:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E415C614C1
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53028C433C7;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550020;
        bh=BL615b5IF7/nLs4QiWPSb9Zd2CYKJy7kdWODpiawfo0=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=j04+tBw2IC6ccMmlSOCNBdpS+86fKOb6tJErmpCXUnMZ6jhNjRJqeF8y4i02RlcM1
         LdXVHk3/YJTMFFcx6puW45x7vOUR6r0rR+EavCAPPq5ovBglT5m2OD9GxdP9moFRqU
         hOr/iqbLUjOSe4t+drEQbS874YnyxXvaz+P4A5fbLXHWyNm5QiOR42jhUQcCZXixwk
         Fo7R91hCGvmohmRbcInLuy9FI5PcwxfSB6LxoZQLn0eGkvqnkpnf72ijWEBdi0KC86
         gCvMymly8Qi/Og6wBzK7lgNmaDVFFytWHa6DqmqV0SY2E3nw/HgI871TzhDVAbLUw9
         5naM+GFLUeiFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC7C001B0;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
From:   Marc Kleine-Budde via B4 Relay 
        <devnull+mkl.pengutronix.de@kernel.org>
Subject: [PATCH 0/6] can: gs_usb: convert to NAPI
Date:   Wed, 05 Jul 2023 11:39:51 +0200
Message-Id: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGc6pWQC/x3M0QpAQBBA0V/RPJtaI1Z+RRJ2lilZ7URK/t3m8
 Tzc+4ByFFZoswciX6IS9oQiz2Bex31hFJcMZKg01lS46HDqhPHG4P0WRoeWyBFVtXV1A6k7Inu
 5/2fXv+8HE0MgymMAAAA=
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BL615b5IF7/nLs4QiWPSb9Zd2CYKJy7kdWODpiawfo0=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBkpTpvDCVuXvyUP1TBGBN0tPlqc3OXqxMsDpJSz
 b9tVyfJMFuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZKU6bwAKCRC+UBxKKooE
 6AxNB/466dNgyz7YolWbxqWRjzcre1JDzHREaWprwL7y+CUMJSsfaXKMvAiVynXNdOYsqCHambL
 BEkXyZkqMpb55lw/9qqfdU5Zkmb6+vO40YxP5NtQKzA1G7z/tR/f+KfL75GiuqYv16hh2cPK75y
 clgSGH+WRiflMKm7G4LmSY0rXNCeBh/KsRLXIrU6ZM5USuIMBGKH6GFd/tgbZvhaii23Pjmcwcp
 2DxGgMYMdBuwGyCVN0c1iKhM+GJ3skBEG36VSMznbSB/jeP8mHAKnGdJWTCQKR3Hh5WR+fIK41q
 My9wdsdhI2IJpgP4w9rHqRB7VX94fBEDfLnPPwMgE6K9kO9M
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

Traditionally USB drivers used to pass the received CAN frames/skbs to
the network stack with netif_rx(). In netif_rx() the skbs are queued
to the local CPU. If IRQs are handled in round robin, OoO packets may
occur.

To support devices without timestamping the TX path of the rx-offload
helper is cleaned up and extended:
- rename rx_offload_get_echo_skb() ->
  can_rx_offload_get_echo_skb_queue_timestamp()
- add can_rx_offload_get_echo_skb_queue_tail()

The remaining 4 patches first add some cleanups to the gs_usb driver
and the last one converts it to NAPI with the rx-offload helper.

Link: https://lore.kernel.org/all/559D628C.5020100@hartkopp.net
Link: https://github.com/candle-usb/candleLight_fw/issues/166
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (6):
      can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
      can: rx-offload: add can_rx_offload_get_echo_skb_queue_tail()
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of netdev
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
      can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception

 drivers/net/can/dev/rx-offload.c              | 36 +++++++++--
 drivers/net/can/flexcan/flexcan-core.c        |  4 +-
 drivers/net/can/m_can/m_can.c                 |  8 +--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |  6 +-
 drivers/net/can/ti_hecc.c                     |  4 +-
 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/gs_usb.c                  | 90 ++++++++++++++++++++-------
 include/linux/can/rx-offload.h                | 11 ++--
 8 files changed, 116 insertions(+), 44 deletions(-)
---
base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
change-id: 20230705-gs_usb-rx-offload-722d22567d68

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>

