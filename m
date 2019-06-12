Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AF42BEF
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2019 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfFLQSw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 Jun 2019 12:18:52 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:50554 "EHLO
        whymenmadegod.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfFLQSw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2019 12:18:52 -0400
X-Greylist: delayed 1789 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jun 2019 12:18:51 EDT
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:48110 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1hb5Ui-0000eD-49; Wed, 12 Jun 2019 11:49:00 -0400
Date:   Wed, 12 Jun 2019 11:48:56 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     linux-can@vger.kernel.org
cc:     wg@grandegger.com, mkl@pengutronix.de
Subject: [PATCH] CAN: correct history of the CAN protocol
Message-ID: <alpine.LFD.2.21.1906121147020.8460@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Current history of CAN protocol is wrong, fix it in the Kconfig file.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/net/can/Kconfig b/net/can/Kconfig
index 0f9fe846ddef..d4319aa3e1b1 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -8,11 +8,12 @@ menuconfig CAN
 	tristate "CAN bus subsystem support"
 	---help---
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
-	  communications protocol which was developed by Bosch in
-	  1991, mainly for automotive, but now widely used in marine
-	  (NMEA2000), industrial, and medical applications.
-	  More information on the CAN network protocol family PF_CAN
-	  is contained in <Documentation/networking/can.rst>.
+	  communications protocol. Development of the CAN bus started in
+	  1983 at Robert Bosch GmbH, and the protocol was officially
+	  released in 1986. The CAN bus was originally mainly for automotive,
+	  but is now widely used in marine (NMEA2000), industrial, and medical
+	  applications. More information on the CAN network protocol family
+	  PF_CAN is contained in <Documentation/networking/can.rst>.

 	  If you want CAN support you should say Y here and also to the
 	  specific driver for your controller(s) below.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
