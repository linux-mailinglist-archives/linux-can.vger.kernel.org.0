Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7969AD64
	for <lists+linux-can@lfdr.de>; Fri, 17 Feb 2023 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBQOKh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Feb 2023 09:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBQOKg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2023 09:10:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C2B6747B
        for <linux-can@vger.kernel.org>; Fri, 17 Feb 2023 06:10:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pT1RZ-0002xA-Fx
        for linux-can@vger.kernel.org; Fri, 17 Feb 2023 15:10:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2FB2D17C151
        for <linux-can@vger.kernel.org>; Fri, 17 Feb 2023 14:10:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5300217C13D;
        Fri, 17 Feb 2023 14:10:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d2fd3040;
        Fri, 17 Feb 2023 14:10:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net-next 0/4] pull-request: can-next 2023-02-17 - fixed
Date:   Fri, 17 Feb 2023 15:10:25 +0100
Message-Id: <20230217141029.3734802-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 4 patches for net-next/master.

The first patch is by Yang Li and converts the ctucanfd driver to
devm_platform_ioremap_resource().

The last 3 patches are by Frank Jungclaus, target the esd_usb driver
and contains preparations for the upcoming support of the esd
CAN-USB/3 hardware.

regards,
Marc

---

The following changes since commit 40967f77dfa9fa728b7f36a5d2eb432f39de185c:

  Merge branch 'seg6-add-psp-flavor-support-for-srv6-end-behavior' (2023-02-16 13:30:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.3-20230217

for you to fetch changes up to 6ad172748db49deef0da9038d29019aedf991a7e:

  Merge patch series "can: esd_usb: Some more preparation for supporting esd CAN-USB/3" (2023-02-16 20:59:53 +0100)

----------------------------------------------------------------
linux-can-next-for-6.3-20230217

----------------------------------------------------------------
Frank Jungclaus (3):
      can: esd_usb: Move mislocated storage of SJA1000_ECC_SEG bits in case of a bus error
      can: esd_usb: Make use of can_change_state() and relocate checking skb for NULL
      can: esd_usb: Improve readability on decoding ESD_EV_CAN_ERROR_EXT messages

Marc Kleine-Budde (1):
      Merge patch series "can: esd_usb: Some more preparation for supporting esd CAN-USB/3"

Yang Li (1):
      can: ctucanfd: ctucan_platform_probe(): use devm_platform_ioremap_resource()

 drivers/net/can/ctucanfd/ctucanfd_platform.c |  4 +-
 drivers/net/can/usb/esd_usb.c                | 70 ++++++++++++++++------------
 2 files changed, 41 insertions(+), 33 deletions(-)


