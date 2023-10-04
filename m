Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8E7B7BB0
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjJDJR4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJDJRz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:17:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B0AB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:17:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-0004AP-9I
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0s-00AzgF-Qi
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8812322EAE9
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C855B22EADB;
        Wed,  4 Oct 2023 09:17:49 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b14a213b;
        Wed, 4 Oct 2023 09:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/5] can: dev: fix can_restart() and replace BUG_ON() by
 error handling
Date:   Wed, 04 Oct 2023 11:17:27 +0200
Message-Id: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKctHWUC/x2MSQqAMBAEvyJzdiCuiF8RDzG2OpcoExEh5O8Gb
 1VQ3ZECVBBoLCIpHgly+ixVWZA7rN/Bsman2tRNZUzLznpe8fAm78+KcFu9GdiGxTbo0IPy+lL
 k5H+e5pQ+iwjj/mkAAAA=
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=iS6Uon0+YaIE+5iWad8m6114qUaH0YBb+xRu4PdKFnc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS2tbi/gDa/HXUo3r9EUT1IQk07G5QqarWrjL
 hfeEwR+jVGJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0trQAKCRC+UBxKKooE
 6GE1B/9ywdmU9zgCI+JTZm+AI3RGZdnF8fRFGWnGwe47Cai2VTP13rpmvA8CMNu0+qIKdNRTmaS
 xh4alGYjIY9Tg2zNTtVgeSlVGGWN1VnjKaUEN4B/tjCWNC17cjC3XWTeRv7x3BUmu0+lLFoT/21
 jEw0ctugHgp+MNrcvaTSHC/2IWZiFgs3mqNNsXzVSTKWBaMtDG3+drzPefY3XoCc9E2WWIwMhE9
 jClDEi9JGZp0sAEfonCZFeiJ3DAVGBKfdjYyRHXqO7YJ4O83F7h9HFTb6DAB7NVII0BPAB8z58T
 lg5sNiLc14Twak37ZOU8ZgvOumLA41i96EOArLQZosMPA0ls
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
Marc Kleine-Budde (5):
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): update debug and error messages
      can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds

 drivers/net/can/dev/dev.c | 25 ++++++++++++-------------
 drivers/net/can/dev/skb.c |  6 +++++-
 2 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 473267a4911f2469722c74ca58087d951072f72a
change-id: 20231004-can-dev-fix-can-restart-eef8ba3e5e6e

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


