Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFE6052CB
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 00:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJSWKY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiJSWKX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 18:10:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD11213E9
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 15:10:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olHGW-0001jK-Uq
        for linux-can@vger.kernel.org; Thu, 20 Oct 2022 00:10:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 61B221041F6
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 22:10:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E6CEA1041F5
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 22:10:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e96cd57d
        for <linux-can@vger.kernel.org>;
        Wed, 19 Oct 2022 22:10:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: [PATCH v3 0/7] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE, GS_CAN_FEATURE_BERR_REPORTING
Date:   Thu, 20 Oct 2022 00:10:09 +0200
Message-Id: <20221019221016.1659260-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
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

Hello,

this series targets the gs_us driver. First there are some cleanup
patches by me, followed by now 4 patches by Jeroen Hofstee's. These
patches are based on the venus-5.19.4-gsusb branch of his Linux
repository and add 2 new features (GS_CAN_FEATURE_GET_STATE,
GS_CAN_FEATURE_BERR_REPORTING) to the driver.

regards,
Marc

Changes since v2: https://lore.kernel.org/all/20221019213035.1607752-1-mkl@pengutronix.de
- 7/7: fix missing endianness conversion

Changes since v1: https://lore.kernel.org/all/20221006162452.200322-1-mkl@pengutronix.de
- added Jeroen's S-o-b to patches 4...7
- split former "[PATCH 4/6] can: gs_usb: add ability to enable / disable berr rerporting"
  into 2 patches, fix subject, update patch description

Changes since venus-5.19.4-gsusb: https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb
- fixed 2nd parameter of usb_control_msg_recv()
- rebased to current net-next/main
- renumbered the FEATURE, MODE and BREQ bits, as termination support
  landed mainline first
- split GS_CAN_FEATURE_GET_STATE patch into documentation and
  implementation part
- added Not-Signed-off-by: tag, as these patches are not Signed-off yet



