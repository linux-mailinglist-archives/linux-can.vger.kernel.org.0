Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408E15BC001
	for <lists+linux-can@lfdr.de>; Sun, 18 Sep 2022 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIRVSL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIRVSJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 17:18:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0B120A6
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 14:18:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oa1fy-0002MY-5L
        for linux-can@vger.kernel.org; Sun, 18 Sep 2022 23:18:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 865F3E5706
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 21:18:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 21227E56FE;
        Sun, 18 Sep 2022 21:18:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9fd7984a;
        Sun, 18 Sep 2022 21:18:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: [PATCH v2 0/3] can: gs_usb: cleanups and termination support
Date:   Sun, 18 Sep 2022 23:17:59 +0200
Message-Id: <20220918211802.692405-1-mkl@pengutronix.de>
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

this series first cleans up the driver a bit and then adds switchable
termination support.

regards,
Marc

changes since v1 https://lore.kernel.org/all/20220918202348.675850-1-mkl@pengutronix.de:
- add 1/3: "can: gs_usb: gs_make_candev(): convert from usb_control_msg() to usb_control_msg_recv()"
  to make error handling easier
- add 2/3: "can: gs_usb: gs_make_candev(): clean up error handling"
  which introduces a cleanup label
- move 1/3 to 3/3:
  - fix gs_usb_get_termination(), set term value
  - remove check of termination value from gs_usb_set_termination()
  - check for initial termination in gs_make_candev()



