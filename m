Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3EA807C
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfIDKoH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDKoH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:07 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Sli-0003XS-CS; Wed, 04 Sep 2019 12:44:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
Subject: [PATCH v2 00/21] Add support for the J1939 Protocol
Date:   Wed,  4 Sep 2019 12:43:44 +0200
Message-Id: <20190904104405.21675-1-mkl@pengutronix.de>
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
sophisticated addressing scheme and extends the maximum packet size
above 8 bytes. Several derived specifications exist, which differ from
the original J1939 on the application level, like MilCAN A, NMEA2000 and
especially ISO-11783 (ISOBUS). This last one specifies the so-called ETP
(Extended Transport Protocol) which is has been included in this
implementation. This results in a maximum packet size of ((2 ^ 24) - 1)
* 7 bytes == 111 MiB. 

Please test and give feedback.

regards,
Marc

changes since v1:
- 11/21: fixed Oliver's email address.
- 13/21: included Oliver's changes, fixed License
- 18/21: renamed macro to CAN_REQUIRED_SIZE
- 21/21: fixed fall-through annotation


