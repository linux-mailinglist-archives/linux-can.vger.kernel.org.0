Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280823BE5E4
	for <lists+linux-can@lfdr.de>; Wed,  7 Jul 2021 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhGGJvj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Jul 2021 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhGGJvj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Jul 2021 05:51:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B83C06175F
        for <linux-can@vger.kernel.org>; Wed,  7 Jul 2021 02:48:59 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m14Aq-0008Fw-6T; Wed, 07 Jul 2021 11:48:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m14Ap-00081T-LG; Wed, 07 Jul 2021 11:48:55 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        David Jander <david@protonic.nl>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH v2 0/2] net: j1939: extend UAPI for RX notifications
Date:   Wed,  7 Jul 2021 11:48:52 +0200
Message-Id: <20210707094854.30781-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

changes v2:
- fix size calculation for the addresses
- make sure all J1939_NLA* have same order

Oleksij Rempel (2):
  net: j1939: rename J1939_ERRQUEUE_* to J1939_ERRQUEUE_TX_*
  net: j1939: extend UAPI to notify about RX status

 include/uapi/linux/can/j1939.h |   9 +++
 net/can/j1939/j1939-priv.h     |  10 ++-
 net/can/j1939/socket.c         | 141 +++++++++++++++++++++++++--------
 net/can/j1939/transport.c      |  26 ++++--
 4 files changed, 144 insertions(+), 42 deletions(-)

-- 
2.30.2

