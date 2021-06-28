Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AF93B6639
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhF1P5R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:57:17 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:24180 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhF1P4n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:56:43 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fuFq6; Mon, 28 Jun 2021 17:54:16 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:16 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/6] Miscellaneous small fix and improvements on driver etas_es58x
Date:   Tue, 29 Jun 2021 00:54:14 +0900
Message-Id: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series fixes some issues on etas_es58x and add a few improvement,
mostly on the code readability (i.e. no new features nor functional
changes in this series).

Vincent Mailhol (6):
  can: etas_es58x: fix three typos in author name and documentation
  can: etas_es58x: use error pointer during device probing
  can: etas_es58x: use devm_kzalloc() to allocate device resources
  can: etas_es58x: add es58x_free_netdevs() to factorize code
  can: etas_es58x: use sizeof and sizeof_field macros instead of
    constant values
  can: etas_es58x: rewrite the message cast in es58{1,_fd}_tx_can_msg to
    increase readability

 drivers/net/can/usb/etas_es58x/es581_4.c    |  5 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 82 ++++++++++-----------
 drivers/net/can/usb/etas_es58x/es58x_core.h |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c   | 19 +++--
 4 files changed, 51 insertions(+), 57 deletions(-)

-- 
2.31.1

