Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B619021
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2019 20:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEISXp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 May 2019 14:23:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:61282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfEISXp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 May 2019 14:23:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 11:23:44 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 May 2019 11:23:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hOnhm-0002vY-UR; Fri, 10 May 2019 02:23:42 +0800
Date:   Fri, 10 May 2019 02:23:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kbuild-all@01.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [mkl-can-next:j1939 108/109] net/can/j1939/socket.c:741:16: sparse:
 sparse: symbol 'j1939_sk_get_timestamping_opt_stats' was not declared.
 Should it be static?
Message-ID: <201905100252.18aBimi8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git j1939
head:   615497ae46c3916c814348718657458523481622
commit: 0d07d158907c09ebaf8e75b2125d2a83b8bd4837 [108/109] j1939: add MSG_ERRQUEUE support
reproduce:
        # apt-get install sparse
        git checkout 0d07d158907c09ebaf8e75b2125d2a83b8bd4837
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/can/j1939/socket.c:741:16: sparse: sparse: symbol 'j1939_sk_get_timestamping_opt_stats' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
