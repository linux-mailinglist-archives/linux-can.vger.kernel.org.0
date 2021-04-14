Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076835FC40
	for <lists+linux-can@lfdr.de>; Wed, 14 Apr 2021 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353682AbhDNUEV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Apr 2021 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbhDNUEV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Apr 2021 16:04:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67839C061756
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 13:03:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lWljx-0006jz-VH
        for linux-can@vger.kernel.org; Wed, 14 Apr 2021 22:03:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6ACE960EC96
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 20:03:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CBFCF60EC8D;
        Wed, 14 Apr 2021 20:03:55 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 69d796ce;
        Wed, 14 Apr 2021 20:03:55 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can-next 2021-04-14
Date:   Wed, 14 Apr 2021 22:03:51 +0200
Message-Id: <20210414200352.2473363-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of a single patch for net-next/master.

Vincent Mailhol's patch fixes a NULL pointer dereference when handling
error frames in the etas_es58x driver, which has been added in the
previous PR.

regards,
Marc

---

The following changes since commit 5871d0c6b8ea805916c3135d0c53b095315bc674:

  ionic: return -EFAULT if copy_to_user() fails (2021-04-13 15:08:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-5.13-20210414

for you to fetch changes up to e2b1e4b532abdd39bfb7313146153815e370d60c:

  can: etas_es58x: fix null pointer dereference when handling error frames (2021-04-14 09:32:12 +0200)

----------------------------------------------------------------
linux-can-next-for-5.13-20210414

----------------------------------------------------------------
Vincent Mailhol (1):
      can: etas_es58x: fix null pointer dereference when handling error frames

 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


