Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16222287E
	for <lists+linux-can@lfdr.de>; Thu, 16 Jul 2020 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPQqe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 16 Jul 2020 12:46:34 -0400
Received: from smtp.HS-Karlsruhe.DE ([193.196.64.25]:47721 "EHLO
        smtp.hs-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQqe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 12:46:34 -0400
Received: from iz-ad-x01.ads.hs-karlsruhe.de ([10.65.65.201] helo=smtp2.hs-karlsruhe.de)
        by smtp.hs-karlsruhe.de with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.80.1)
        (envelope-from <leph1016@hs-karlsruhe.de>)
        id 1jw71i-008Jlo-P8; Thu, 16 Jul 2020 18:46:30 +0200
From:   Philipp Lehmann <leph1016@hs-karlsruhe.de>
To:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "christian.sauer.w@sew-eurodrive.de" 
        <christian.sauer.w@sew-eurodrive.de>
Subject: [Bug] Kernel Panic on Deletion of the network-namespace containing
 the SocketCAN interface
Thread-Topic: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
Thread-Index: AQHWW493uXW0NDKXQkWfuvBe3q5jjQ==
Date:   Thu, 16 Jul 2020 16:46:30 +0000
Message-ID: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.65.65.181]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If a SocketCAN Interface (Tested with a PCAN-USB adapter) is moved into a network-namespace and the network namespace is deleted afterwards, without moving the device out of the namespace prior to the deletion. The device could not be found in any of the network namespaces afterwards, only a reboot of the system fixes this. If the device is instead removed from the USB-Bus without a restart, a kernel panic is the result.


Output of uname -r [Linux cpc4x 5.4.0-40-generic #44-Ubuntu SMP Tue Jun 23 00:01:04 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux]


The bug could be reproduced with the following steps:


1. Connect the (USB)-SocketCAN device to the host

2. Add a new network namespace [sudo ip netns add test]
3. Move the CAN-interface to the network name-space [sudo ip link set dev can0 netns test]
4. Delete the namespace [sudo ip netns delete test]
5. Remove the adapter from the USB-Bus. In most cases this should result in a kernel panic

