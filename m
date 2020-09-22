Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35969274480
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVOof (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVOof (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02865C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:35 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjWz-0001FU-FD; Tue, 22 Sep 2020 16:44:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com
Subject: [RFC]: flexcan FD support - can-next 2020-09-22
Date:   Tue, 22 Sep 2020 16:44:09 +0200
Message-Id: <20200922144429.2613631-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello

here is my current flexcan FD support branch.

changes since last post:
- add ISO mode
- clear reg_fdcbt prior to assigning bit timing values
- use ctrlmode_supported instead of quirks to check for CAN-FD support
- fix check for activated CAN-FD mode using ctrlmode instead of ctrlmode_supported

regards,
Marc


