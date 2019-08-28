Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0B9FAD0
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfH1Gw3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfH1Gw2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:28 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2roh-0002oO-O6; Wed, 28 Aug 2019 08:52:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
Subject: [PATCH 00/21] Add support for the J1939 Protocol
Date:   Wed, 28 Aug 2019 08:52:05 +0200
Message-Id: <20190828065226.23604-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
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

Hello,

this series add support for the J1939 protocol to the kernel.

SAE J1939 defines a higher layer protocol on CAN. It implements a more
sophisticated addressing scheme and extends the maximum packet size above 8
bytes. Several derived specifications exist, which differ from the original
J1939 on the application level, like MilCAN A, NMEA2000 and especially
ISO-11783 (ISOBUS). This last one specifies the so-called ETP (Extended
Transport Protocol) which is has been included in this implementation. This
results in a maximum packet size of ((2 ^ 24) - 1) * 7 bytes == 111 MiB. 

Please test and give feedback.

regards,
Marc


