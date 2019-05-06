Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2085147D3
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2019 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEFJv0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 May 2019 05:51:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFJv0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 May 2019 05:51:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHK-0002NG-Rd; Mon, 06 May 2019 11:51:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHJ-0006w1-Ir; Mon, 06 May 2019 11:51:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 0/2] fix error handling on double CTS 
Date:   Mon,  6 May 2019 11:51:16 +0200
Message-Id: <20190506095118.22805-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

After creating setup with conflicting addresses I discovered
some kernel crashes. This patches fix some of error handling
issues and make j1939 stack more robust.

Oleksij Rempel (2):
  j1939: transport: abort the session if we get double CTS
  j1939: transport: don't put session in j1939_xtp_rx_cts

 net/can/j1939/transport.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.20.1

