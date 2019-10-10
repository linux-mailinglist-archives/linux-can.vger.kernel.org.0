Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE13D2E42
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfJJQCT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 12:02:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:16445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfJJQCT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 10 Oct 2019 12:02:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 09:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="224012491"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2019 09:01:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iIasx-0001Zv-9o; Fri, 11 Oct 2019 00:01:51 +0800
Date:   Fri, 11 Oct 2019 00:00:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild-all@01.org, linux-can@vger.kernel.org
Subject: [mkl-can-next:mcp25xxfd 42/57]
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regmap.c:93:8-10: WARNING:
 PTR_ERR_OR_ZERO can be used
Message-ID: <201910110051.ekDMnRer%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git mcp25xxfd
head:   fc940214e54b37f338dc9e308cd6501b96fcdb0a
commit: 7de255ffe2cc75da3518d110717ca5ef0bf5073f [42/57] can: mcp25xxfd: add regmap infrastructure

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regmap.c:93:8-10: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
