Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169C23324EB
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCIMKr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:10:47 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:55242 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCIMKV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:10:21 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d34 with ME
        id eC9p240093PnFJp03CAG04; Tue, 09 Mar 2021 13:10:19 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Mar 2021 13:10:19 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-kernel@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND v12 0/1] Introducing ETAS ES58X CAN USB interfaces
Date:   Tue,  9 Mar 2021 21:09:45 +0900
Message-Id: <20210309120946.1640-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

*Reason for resend:* the patch does not reach the linux-can mailing
list because it is over the 100000 characters limit. Adding
linux-kernel@vger.kernel.org in CC so that people who are not in CC
can get it from the general mailing list instead.

Here comes the twelfth iteration of the ETAS es58x usb driver. The
major difference from previous version is the total removal of
spinlocks. Aside of that, I also implemented the TDC accordingly to
the patch series which I submitted here two weeks ago.

This patch series is based on linux-can-next/testing. It requires the
latest patches in that branch to compile.

Crossing fingers, hoping that we are now close to a release.

Thank you in advance for your review and for your time!


Yours sincerely,
Vincent

Vincent Mailhol (1):
  can: usb: etas_es58X: add support for ETAS ES58X CAN USB interfaces

 drivers/net/can/usb/Kconfig                 |   10 +
 drivers/net/can/usb/Makefile                |    1 +
 drivers/net/can/usb/etas_es58x/Makefile     |    3 +
 drivers/net/can/usb/etas_es58x/es581_4.c    |  525 ++++
 drivers/net/can/usb/etas_es58x/es581_4.h    |  208 ++
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2404 +++++++++++++++++++
 drivers/net/can/usb/etas_es58x/es58x_core.h |  690 ++++++
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  600 +++++
 drivers/net/can/usb/etas_es58x/es58x_fd.h   |  243 ++
 9 files changed, 4684 insertions(+)
 create mode 100644 drivers/net/can/usb/etas_es58x/Makefile
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.h
-- 
2.26.2

