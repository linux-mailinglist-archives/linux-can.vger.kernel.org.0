Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF042FD2E1
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbhATOih (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 09:38:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:60420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389175AbhATOiY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Jan 2021 09:38:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IjY/D1iXjKz54pM82wpuiKbmLEMaLpoadCsoWoh5Jog=;
        b=pVOso3GEue7YH2GAuPKkrbOTS3CfmWwpiTy8dfAgeu/OebjoVkWVRPLBizO0kUKvCzxU6h
        NBXx/IdPHyqyyBjkA6bKz8qkR9qQSFj6kdT7cWEB6zZprn7bfMgjsv2BKIuTH2qEOCHTJt
        QFDuK5vPTdvoMAfSAdg2h2+cGHXTx6g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9971AB9F;
        Wed, 20 Jan 2021 14:37:36 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 0/7] Convert CAN tests to new LTP API
Date:   Wed, 20 Jan 2021 14:37:16 +0000
Message-Id: <20210120143723.26483-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

This is an attempt to convert the CAN tests to the (modern) Linux Test
Project API and removes the wrapper script. To be clear, this is a
patch-set for the LTP *not* the kernel tree or can-utils.

I have tried to keep the core test behaviour the same, but (for
example) moving to the SAFE_ functions will naturally introduce some
changes in error checking. Deliberate behavioral changes have been
noted in the commit messages.

FYI, we appear to have 4 CAN tests in LTP including two tests for
SLCAN (pty03, pty04).

V2: Update e-mail addresses and resend
V3:
* Add COPYING and use dual license SPDX identifier
* Fix compilation issues with can_common.h

Richard Palethorpe (7):
  API: Add FILE_SCANF to new lib
  can: Add can_common.h for vcan device setup
  can: Add COPYING with dual license text
  can_filter: Convert to new library
  can_recv_own_msgs: Convert to new library
  can: Remove obsolete test wrapper script
  can: Update contact details

 include/tst_safe_file_ops.h                   |   3 +
 testcases/network/can/Makefile                |   2 -
 .../can/filter-tests/00_Descriptions.txt      |   6 +-
 testcases/network/can/filter-tests/COPYING    |  35 ++
 testcases/network/can/filter-tests/INSTALL    |   3 +-
 testcases/network/can/filter-tests/Makefile   |   4 -
 .../network/can/filter-tests/can_common.h     |  75 +++++
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
 .../network/can/filter-tests/can_run_tests.sh | 106 ------
 10 files changed, 331 insertions(+), 493 deletions(-)
 create mode 100644 testcases/network/can/filter-tests/COPYING
 create mode 100644 testcases/network/can/filter-tests/can_common.h
 delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh

-- 
2.30.0

