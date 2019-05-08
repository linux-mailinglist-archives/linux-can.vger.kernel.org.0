Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15617AED
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfEHNoX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfEHNoX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:23 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMrt-0007vK-Sb; Wed, 08 May 2019 15:44:21 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Subject: [PATCH 1/6] can: mcp25xxfd: fix sparse warnings and typos
Date:   Wed,  8 May 2019 15:44:14 +0200
Message-Id: <20190508134420.29982-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Martin,

while integrating the patches sparse complained about several things.
I've fixed most of them with these patches. Feel free to squash then.

Can you please fix the following warning, too:

| cp25xxfd_can_rx.c:162:18: warning: cast to restricted __le32                                                                                     
| cp25xxfd_can_rx.c:163:21: warning: cast to restricted __le32                                                                                     
| cp25xxfd_can_rx.c:164:18: warning: cast to restricted __le32 

You get these, if you compile the kernel with the option "C=1". You need to
have "sparse" installed for this.

regards,
Marc


