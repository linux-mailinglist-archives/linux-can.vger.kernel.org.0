Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35C2FB9DD
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbhASOiD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 09:38:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:48668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbhASJeA (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 04:34:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611048789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Gs8OrqNIg23F6h+Tgi8l2QM19tsafIuNjPaR1oJmc9E=;
        b=tLfuGN4pJWULG0N6Tdu1wof5tkI0AtEjl0C4W2b3SlKQj++mni8Gf5/+CZs5rRoWkZ9FfP
        UNFKv/wTG8GZ15TJLKu4ho+dl/Yc12zMdP3bTjmpmQPA9RtkJXLs3lu7jz/AFrwDWQpQ8w
        UG7yEEG3kNgY0QgqhErqFrJ5EpaHfV4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D8C8AB9F;
        Tue, 19 Jan 2021 09:33:09 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v2 0/6] Convert CAN tests to new LTP API
Date:   Tue, 19 Jan 2021 09:31:37 +0000
Message-Id: <20210119093143.17222-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.29.2
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

Richard Palethorpe (6):
  API: Add FILE_SCANF to new lib
  can: Add can_common.h for vcan device setup
  can_filter: Convert to new library
  can_recv_own_msgs: Convert to new library
  can: Remove obsolete test wrapper script
  can: Update contact details

 include/tst_safe_file_ops.h                   |   3 +
 testcases/network/can/Makefile                |   2 -
 .../can/filter-tests/00_Descriptions.txt      |   6 +-
 testcases/network/can/filter-tests/INSTALL    |   3 +-
 testcases/network/can/filter-tests/Makefile   |   4 -
 .../network/can/filter-tests/can_common.h     |  70 ++++
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
 .../network/can/filter-tests/can_run_tests.sh | 106 ------
 9 files changed, 291 insertions(+), 493 deletions(-)
 create mode 100644 testcases/network/can/filter-tests/can_common.h
 delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh

-- 
2.29.2

