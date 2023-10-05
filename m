Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D877BA02F
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjJEOfL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjJEOdw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:33:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C67E7EC3
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:48:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ5z-0000ZJ-TM
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:31 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ5z-00BDIj-G2
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 37E7022F75D
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:48:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6577022F74E;
        Thu,  5 Oct 2023 07:48:30 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ee22b864;
        Thu, 5 Oct 2023 07:48:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/5] can: dev: fix can_restart() and replace BUG_ON() by
 error handling
Date:   Thu, 05 Oct 2023 09:48:17 +0200
Message-Id: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJqHmUC/4WNTQ6CMBCFr2Jm7ZhSxIAr72FYVHjAbAqZ1gZDu
 LuVC7h738v72ShABYHup40USYLMPoM9n6ibnB/B0mcma2xZGHPlznnukXiQ9dCKEJ1GBob65Up
 UuIFye1HkyLH8bDNPEuKsn+MoFT/3/2Yq2LBFZeumgXND9Vjgx3fU2ct66UHtvu9fs1r31cMAA
 AA=
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=N4EVa4edcOEn7DA9EVzG3jC6ZX1ud0WXtk2qTMbRaiE=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmpE6X278U5Q5pAtkiYqcOMLlhD/a7iH1xAc3
 EsacIDzLAqJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qRAAKCRC+UBxKKooE
 6OOjB/9Vbcn6JB7bi0VmZvSj54w06Q2U/nHmrsbTF3fmM1qv3iflVg+dW5AO2OCzDqCA931GgAq
 /dM0JDpCqnO4w/uSHLTaUOpMAqVu70TDYuMBG6Vvt7gu1v663Urfz+WboAq/jtquQM7o1uW7V5G
 /59k4wsz6K0ehEzHrF0Uhbj4ydJsVkELPttNW2JJK4CCBjt8xN1YPEWs+0ksEtQcSnXHFyafHAQ
 xJS/eU5OIX13fGggmpPcpe4fPm3PmxRMHJ6LhNepfAjvs5F/dP/KEQeWpgze1W2XPF9narCFA0x
 6R7vLZqu0W8PQrFCH0Tr1awkXaho0Tqb9qcqexE3zaQIt1TI
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

There are 2 BUG_ON() in the CAN dev helpers. During the update/test of
the at91_can driver to rx-offload the one in can_restart() was
triggered, due to a race condition in can_restart() and a hardware
limitation of the at91_can IP core.

This series fixes the race condition, replaces BUG_ON() with an error
message, and does some cleanup. Finally, the BUG_ON() in
can_put_echo_skb() is also replaced with error handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- 4/5: move "Restarted" debug message and stats after successful restart (Thanks Vincent)
- Link to v1: https://lore.kernel.org/all/20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de

---
Marc Kleine-Budde (5):
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): update debug and error messages
      can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds

 drivers/net/can/dev/dev.c | 29 ++++++++++++++---------------
 drivers/net/can/dev/skb.c |  6 +++++-
 2 files changed, 19 insertions(+), 16 deletions(-)
---
base-commit: 93e7eca853ca0087b129433630ddd89288d2b8b4
change-id: 20231004-can-dev-fix-can-restart-eef8ba3e5e6e

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


