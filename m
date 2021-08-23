Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32233F49F5
	for <lists+linux-can@lfdr.de>; Mon, 23 Aug 2021 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhHWLnC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Aug 2021 07:43:02 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:41418 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhHWLnB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Aug 2021 07:43:01 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2021 07:43:00 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee761238769d2e-049b0; Mon, 23 Aug 2021 19:32:59 +0800 (CST)
X-RM-TRANSID: 2ee761238769d2e-049b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee261238767421-c70bb;
        Mon, 23 Aug 2021 19:32:58 +0800 (CST)
X-RM-TRANSID: 2ee261238767421-c70bb
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     davem@davemloft.net, wg@grandegger.com, mkl@pengutronix.de,
        kuba@kernel.org, kevinbrace@bracecomputerlab.com,
        romieu@fr.zoreil.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 0/3] net: Use of_device_get_match_data to simplify code
Date:   Mon, 23 Aug 2021 19:33:35 +0800
Message-Id: <20210823113338.3568-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all:

This patch series replace 'of_match_device' with
'of_device_get_match_data', to make code cleaner and better.

Thanks

Tang Bin (3):
  via-rhine: Use of_device_get_match_data to simplify code
  via-velocity: Use of_device_get_match_data to simplify code
  can: mscan: mpc5xxx_can: Use of_device_get_match_data to simplify code

 drivers/net/can/mscan/mpc5xxx_can.c     | 6 ++----
 drivers/net/ethernet/via/via-rhine.c    | 9 ++-------
 drivers/net/ethernet/via/via-velocity.c | 6 ++----
 3 files changed, 6 insertions(+), 15 deletions(-)

-- 
2.20.1.windows.1



