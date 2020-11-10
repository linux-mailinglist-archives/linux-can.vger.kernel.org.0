Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D13F2ADAC7
	for <lists+linux-can@lfdr.de>; Tue, 10 Nov 2020 16:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgKJPtQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Nov 2020 10:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbgKJPtQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Nov 2020 10:49:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7FC0613CF
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2020 07:49:16 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcVtS-0005w8-QT; Tue, 10 Nov 2020 16:49:14 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr
Subject: Introduce optional DLC element for Classic CAN helpers
Date:   Tue, 10 Nov 2020 16:49:11 +0100
Message-Id: <20201110154913.1404582-1-mkl@pengutronix.de>
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

Hello,

just picking up the helper functions and the len8_dlc driver support, which are
patches 7 and 8 of Oliver's series.

Changes since v7:
- add prose to commit message
- change arguments of can_get_cc_dlc()
- converted can_get_cc_len() -> can_frame_set_cc_len()

can_frame_set_cc_len()...maybe call it can_frame_set_len

regards,
Marc


